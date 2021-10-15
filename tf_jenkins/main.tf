module "mod_jenkins" {
    source = "./modules/modulo_jenkins"
    vpc_id = data.aws_vpc.my-vpc.id
    ami = data.aws_ami.ubuntu.id
    
    subnet_cidr = "10.0.102.0/24"
    name = "Kleberson"
    
    
    tags = {
        curso = "CIA0506"
        Exercicio = "Jenkins"
        autor = "Kleberson-Brandao"
    }
   
    instance_app = "t2.small"
    ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFsKcyMyI9p+2oq8L8ztWqy6zW2ZxelZFoXpaewh9htYrHXgZVgY8VvU4djCWwujVBpfBPE4xxbJK9daJ4ehJrsTsWby+JcL8DvoGPFWVACVka2QyujaLN7jdTN9GeyTbkFSjwtWzpAKNTDmZ7EH3otJf4gDy3wnIuj6+K4Si/RXVEqioPojIyE++PVDNNBLQ0ci7q0kosojwLsz4C3lfRTgxyQEXzu8oaU5oDeY1P7LIvxpkR0xqAMiGSDnU+wbSllZph3IeWCYisWm6KT6rY/CSYXyTpupB7MuLWtWFvQU5Lrrj/4pPcumIizOFlPQvRheqCvzPn/E8axfwBUT4SH9QGta111GsA0Ehbq2FMxaRv8QnIGp7QVC+TNrO/TJGdgU9RBf3c85xUG91kCI0WOgE+NB5axrMwMjRqMkwuXI39rv/HkK3XTgIn6g5HMfX7owAcpRpfXS763c39f1kJE+aMzKJ3b73M5aw3dipOR8S90+eQyTBdyf8GsWxuCAU= slacko"
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