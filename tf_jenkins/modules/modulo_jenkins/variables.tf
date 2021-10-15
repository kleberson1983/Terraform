variable "subnet_cidr" {
    description = "Informe a SubNet"
    type = string
    default = "10.0.102.0/24"
}

variable "ami"{
    description = "Informe a ami "
    type = string
}

variable "vpc_id" {
    description = "Digite a VPC"
    type = string
}

variable "name" {
    description = "Nome do Projeto a ser concatenado ao nome do recurso"
    type = string
}

variable "tags" {
    default = {
        curso = "CIA0506"
        Exercicio = "Jenkins"
        autor = "Kleberson-Brandao"
    }
    description = "TAGS para os recursos"
    type = map(string)
    
}

variable "instance" {
    description = "Instancia AWS EC2"
    type = string
    default = "t2.micro"
}