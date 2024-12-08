resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  # cidr_block = lookup(var.virginia_cidr,terraform.workspace)
  tags = {
    Name = "Vpc Virginia"
  }
}

resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet Publica Temp"
  }
}

resource "aws_subnet" "subnet_private" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
  tags = {
    Name = "Subnet Privada Temp"
  }
  depends_on = [
    aws_subnet.subnet_public
  ]
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "gateway_vpc_virginia"
  }
}


resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "crt publica"
  }
}

resource "aws_route_table_association" "associarion_crt" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.public_crt.id
}

resource "aws_security_group" "public_instance" {
  name        = "sg_public_instance"
  description = "allow SHH inbound trafic and all egress trafic"
  vpc_id      = aws_vpc.vpc_virginia.id

  # ingress {
  #   description = "SSH over internet"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }

  # ingress {
  #   description = "http over internet"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }

  # ingress {
  #   description = "https over internet"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }
#Estos tres bloques se cambiaran 
  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.sg_ingress_cidr]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "sg_public_instance"
  }
}