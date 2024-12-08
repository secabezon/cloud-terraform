virginia_cidr = "10.10.0.0/16"
# virginia_cidr = {
#   dev = "10.20.0.0/16"
#   prod = "10.10.0.0/16"
# }
# private_subnet = "10.10.0.0/24"
# public_subnet = "10.10.1.0/24"
subnets = ["10.10.1.0/24", "10.10.0.0/24"]
tags = {
  name        = "prueba"
  env         = "dev"
  cloud       = "aws"
  IAC         = "Terraform"
  IAC_version = "1.10.0"
  project="severus"
  region="us-east-1"
}
sg_ingress_cidr = "0.0.0.0/0"
ec2_specs = {
  "ami"           = "ami-0453ec754f44f9a4a"
  "instance_type" = "t2.micro"
}
enable_monitoring=0
ingress_ports_list=[22,443,80]