# variable "instancias"{
#   description = "Nombres de instancias"
#   type = list(string)
#   default = ["apache", "mysql", "jumpserver"]
# }

# resource "aws_instance" "public_ec2" {
#   count                  = length(var.instancias)
#   ami                    = var.ec2_specs["ami"]
#   instance_type          = var.ec2_specs["instance_type"]
#   subnet_id              = aws_subnet.subnet_public.id
#   key_name               = data.aws_key_pair.public_key.key_name
#   vpc_security_group_ids = [aws_security_group.public_instance.id]
#   user_data              = file("/scripts/user_data.sh")
#   tags = {
#     Name = var.instancias[count.index]
#   }
# }

variable "instancias"{
  description = "Nombres de instancias"
  type = list(string)
  default = ["apache"]#, "jumpserver","mysql"]
}

resource "aws_instance" "public_ec2" {
  for_each = toset(var.instancias)
  ami                    = var.ec2_specs["ami"]
  instance_type          = var.ec2_specs["instance_type"]
  subnet_id              = aws_subnet.subnet_public.id
  key_name               = data.aws_key_pair.public_key.key_name
  vpc_security_group_ids = [aws_security_group.public_instance.id]
  user_data              = file("/scripts/user_data.sh")
  tags = {
    Name = "${each.value}-${local.sufix}"
  }
}

# variable "ejemplocadenaconsola"{
#   description = "variable usada para ejemplo de terraform console"
#   type = string
#   default = "ami-123,AMI-AAV,ami-12f"
# }

# variable "ejemplolistaconsola2"{
#   description = "variable usada para ejemplo de terraform console"
#   type = list(string)
#   default = ["ami-123","AMI-AAV","ami-12f"]
# }

# variable "ejemplomapconsola3"{
#   description = "variable usada para ejemplo de terraform console"
#   type = map(string)
#   default = {
#     prod="10.10.0.0/16"
#     dev="172.16.0.0/16"
#   }
# }

resource "aws_instance" "public_ec2_mon" {
  count = var.enable_monitoring==1 ? 1:0
  ami                    = var.ec2_specs["ami"]
  instance_type          = var.ec2_specs["instance_type"]
  subnet_id              = aws_subnet.subnet_public.id
  key_name               = data.aws_key_pair.public_key.key_name
  vpc_security_group_ids = [aws_security_group.public_instance.id]
  user_data              = file("/scripts/user_data.sh")
  tags = {
    Name = "Monitoreo Instancias"
  }
}