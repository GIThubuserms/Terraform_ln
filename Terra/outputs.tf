output "Ec2_Machine_IpAddress" {
   value = aws_instance.terraform_instance.public_ip
}

output "Ec2_Machine_Dns" {
   value = aws_instance.terraform_instance.public_dns
}