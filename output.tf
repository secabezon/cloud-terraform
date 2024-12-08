output "ec2_public_ip" {
  description = "ip publica de instancia"
  # value       = aws_instance.public_ec2[*].public_ip #para iterar count
    value       = { for key, instance in aws_instance.public_ec2 : key => instance.public_ip } #para iterar each value
} 