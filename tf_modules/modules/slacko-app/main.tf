data "aws_subnet" "subnet_public"{
    cidr_block = var.subnet_cidr
} 

resource "aws_key_pair" "slacko-sshkey" {
    key_name = "${var.name}-slacko-app-key"
    public_key = var.ssh_key
}

resource "aws_instance" "slacko-app" {
    ami = var.ami
    instance_type = var.instance_app 
    subnet_id = data.aws_subnet.subnet_public.id
    associate_public_ip_address = true
    
    key_name = aws_key_pair.slacko-sshkey.id
    user_data = file ("${path.module}/files/ec2.sh") 

    tags = merge(var.tags,{ "Name" = format("%s-slacko-EC2", var.name)},)
}

resource "aws_instance" "mongodb" {
    ami = var.ami
    instance_type = var.instance_mongo 
    subnet_id = data.aws_subnet.subnet_public.id
    
    key_name = aws_key_pair.slacko-sshkey.id
    user_data = file ("${path.module}/files/mongodb.sh") 

    tags = merge(var.tags,{ "Name" = format("%s-mongodb-EC2", var.name)},)
}

resource  "aws_security_group" "allow_slacko"{
    name = "${var.name}-SG-allow_ssh_http"
    description = "Allow protocol SSH and HTTP"
    vpc_id = var.vpc_id
    tags = merge(var.tags,{ "Name" = format("%s-allow-slacko", var.name)},)
    ingress = [
        {
            description = "Allow SSH"
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
            prefix_list_ids = null
            security_groups = null
            self = null
        },
        {
            description = "Allow HTTP"
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
            prefix_list_ids = null
            security_groups = null
            self = null
        }
    ]
    egress = [
        {
            description = "Allow ALL Trafic Out"
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
            prefix_list_ids = null
            security_groups = null
            self = null
        }      
    ]
}

resource "aws_security_group" "allow-mongodb"{
    name = "${var.name}-SG-allow_mongodb"
    description = "SG Allow Port 27017 (MongoDB)"
    vpc_id = var.vpc_id

    tags = merge(var.tags,{ "Name" = format("%s-allow-mongodb", var.name)},)
    
    ingress = [
        {
            description = "Allow Port 27017 (MongoDB)"
            from_port = 27017
            to_port = 27017
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
            prefix_list_ids = null
            security_groups = null
            self = null
        }
    ]
    egress = [
        {
            description = "Allow ALL Trafic Out"
            from_port = 0
            to_port = 0
            protocol = "all"
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
            prefix_list_ids = null
            security_groups = null
            self = null
        }
    ]
}

resource "aws_network_interface_sg_attachment" "mongo-sg" {
    security_group_id = aws_security_group.allow-mongodb.id
    network_interface_id = aws_instance.mongodb.primary_network_interface_id
}

resource "aws_network_interface_sg_attachment" "slacko-sg" {
    security_group_id = aws_security_group.allow_slacko.id
    network_interface_id = aws_instance.slacko-app.primary_network_interface_id
}

resource "aws_route53_zone" "slack_zone" {
    name = "iaac0506.com.br"
    vpc{
        vpc_id = var.vpc_id
    }
     tags = merge(var.tags,{ "Name" = format("%s-iaac0506.com.br", var.name)},)
}

resource "aws_route53_record" "mongodb" {
    zone_id = aws_route53_zone.slack_zone.id
    name = "mongodb.iaac0506.com.br"
    type = "A"
    ttl = "300"
    records = [aws_instance.mongodb.private_ip]
}