variable "subnet_cidr" {
    description = "Informe a SubNet"
    type = string
    default = "10.0.102.0/24"
}

variable "ami"{
    description = "digite a ami "
    type = string
}

variable "ssh_key" {
    description = "ssh publica"
    type = string
}

variable "vpc_id" {
    description = "Digite a VPC"
    type = string
}

variable "name" {
    description = "Nome do recurso"
    type = string
}

variable "tags" {
    default = {
        curso = "CIA0506"
        Exercicio = "Jenkins"
        autor = "Kleberson-Brandao"
    }
        
}

variable "instance_app" {
    description = "Instancia AWS EC2"
    type = string
    default = "t2.micro"
}