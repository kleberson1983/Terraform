module "slackoapp" {
    source = "./modules/slacko-app"
    vpc_id = data.aws_vpc.my-vpc.id
    ami = data.aws_ami.slacko-app.id
   
    subnet_cidr = "10.0.102.0/24"
   
    name = "Kleberson"
    tags = {
        curso = "CIA0506"
        Exercicio = "Slacko-modules"
        autor = "Kleberson-Brandao"
	}
   
    ssh_key = "ssh-key"
    instance_app = "t2.micro"
    instance_mongo = "t2.small"
}

output "slackip" {
    value = module.slackoapp.slacko-app
}

output "mongodb" {
    value = module.slackoapp.slacko-mongodb
}