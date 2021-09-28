variable "vpc_id" {
    type = string
    description = "ID da VPC"
}

variable "subnet_cidr" {
    type = string
    description = "Subnet Publica"
}

variable "name" {
    default = "kleberson"
    type = string
    description = "Nome dos recusos"
}

variable "tags" {
    type = map(string)
    description = "TAGS para os recursos"
}