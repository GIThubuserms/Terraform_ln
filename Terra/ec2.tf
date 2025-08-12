// To write an ec2 IAC first think what things are needed 

// KEY PAIR

resource "aws_key_pair" "terraform_Key"{
    key_name = "terraform_Key"
    public_key = file("tera_ec2.pub")
}

// VPC

resource "aws_default_vpc" "terraform_default" {
  
}

//SG

resource "aws_security_group" "terraform_sg" {
  name= "terraform_sg"
  description = "This is my sg created using terraform"
  vpc_id = aws_default_vpc.terraform_default.id  

  tags = {
    Name = "terraform_sg_9704"
  }

//OUTBOUND RULES
   egress {
    protocol= "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port =0
    to_port = 0
    
  }

}

// INBOUND RULES

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
    security_group_id = aws_security_group.terraform_sg.id
    cidr_ipv4 ="0.0.0.0/0"
    from_port =22 
    to_port =22
    ip_protocol= "tcp"

}

resource "aws_vpc_security_group_ingress_rule" "allow_hhtp" {
    security_group_id = aws_security_group.terraform_sg.id
    cidr_ipv4 ="0.0.0.0/0"
    from_port =80
    to_port =80
    ip_protocol ="tcp"


}
resource "aws_vpc_security_group_ingress_rule" "allow_terraform" {
    security_group_id = aws_security_group.terraform_sg.id
    cidr_ipv4 ="0.0.0.0/0"
    from_port = 8000
    to_port =8000
    ip_protocol ="tcp"
}


// PRE REQ DONE NOW ------------

resource "aws_instance" "terraform_instance" {
    instance_type = var.EC2_machine_type
    ami = "ami-020cba7c55df1f615"
    security_groups =[aws_security_group.terraform_sg.name]
    key_name = aws_key_pair.terraform_Key.key_name

    tags={
        Name="Terraform_EC2_Inst"
    }
  
  // storage
  root_block_device {
    volume_size = var.EC2_machine_size
    volume_type = "gp3"
  }
}



