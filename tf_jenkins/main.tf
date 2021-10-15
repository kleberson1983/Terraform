module "mod_jenkins" {
    source = "./modules/modulo_jenkins"
    vpc_id = data.aws_vpc.my-vpc.id
    ami = data.aws_ami.ubuntu.id
    
    subnet_cidr = "10.0.102.0/24"
    name = "Kleberson"
    instance = "t2.micro"
    
    tags = {
        curso = "CIA0506"
        Exercicio = "Jenkins"
        autor = "Kleberson-Brandao"
    }
}

resource "null_resource" "PassJenkins" {
    triggers = {
        instance = module.mod_jenkins.jenkins-app
    }
    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("${path.module}/modules/modulo_jenkins/files/jenkins")
        host = module.mod_jenkins.jenkins-app
    }
    provisioner "remote-exec" {
    inline = [
        "echo 'Jenkins carregando...'",
        "sleep 60",
        "echo 'Jenkins carregando...'",
        "sleep 70",
        "echo 'Jenkins carregando...'",
        "sleep 80",
        "echo 'Jenkins carregando...'",
        "sleep 70",
        "sudo cat /var/lib/jenkins/secrets/initialAdminPassword",
    ]
  }
}

output "jenkinsIP" {
    value = module.mod_jenkins.jenkins-app
}