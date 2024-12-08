variable "virginia_cidr" {
  description = "CIDR Virginia"
  type        = string
  # sensitive   = true
}

# variable "public_subnet"{
#     description = "CIDR public subnet"
#     type = string
# }

# variable "private_subnet"{
#     description = "CIDR private subnet"
#     type = string
# }
variable "subnets" {
  description = "Lista de subnets"
  type        = list(string)
}
variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}

variable "sg_ingress_cidr" {
  description = "Secutiry Group ingress cidr"
  type        = string
}
variable "ec2_specs" {
  description = "Parametros de la instancia"
  type        = map(string)
}

variable "enable_monitoring" {
  description = "Habilita el despliegue de un server monitoring"
  type = number
}

variable "ingress_ports_list" {
  description="Puerto de ingreso a la EC2"
  type=list(number)
}