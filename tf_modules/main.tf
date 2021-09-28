module "slackoapp"{
    source = "./modules/slacko-app"
    vpc_id = "vpc-07e446fe3d5e14d6f"
    subnet_cidr = "10.0.102.0/24"
    name = "Kleberson"
    tags = {
        curso = "CIA0506"
        Exercicio = "Slacko-mdules"
        autor = "Kleberson-Brandao"
    }
}

output "slackoip" {
    value =module.slackoapp.slacko-app
} 
