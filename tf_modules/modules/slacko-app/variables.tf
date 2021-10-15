variable "subnet_cidr" {
    type = string
    default = "10.0.102.0/24"
}

variable "ssh_key" {
    type = string
}

variable "ami"{
    type = string
}

variable "vpc_id" {
    description = "informe VPC utilizada"
    type = string
}

variable "name" {
    description = "nome do recurso"
    type = string
}

variable "tags" {
    default = {
       curso = "CIA0506"
       Exercicio = "Slacko-mdules"
       autor = "Kleberson-Brandao"
    }
}

variable "instance_app" {
    description = "instancia de App"
    type = string
     default = "t2.micro"

}

variable "instance_mongo" {
    description = "instancia de Mongo"
    type = string
     default = "t2.micro"
   
}