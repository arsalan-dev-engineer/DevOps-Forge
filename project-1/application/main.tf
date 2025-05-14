module "network" {
  source = "../network/"  # importing this
}

##SG



##ami
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}



###ec2 for private subnet A
resource "aws_instance" "web-A" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

    # Ensure the instance is launched in the private subnet
   subnet_id = module.network.private_subnet_id_A
  
  # Ensure the instance doesn't have a public IP
  associate_public_ip_address = false

##ssm access
    iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile.name



  tags = {
    Name = "private-website-mo-A"
  }
}


###ec2 for private subnet B
resource "aws_instance" "web-B" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

    # Ensure the instance is launched in the private subnet
   subnet_id = module.network.private_subnet_id_B
  
  # Ensure the instance doesn't have a public IP
  associate_public_ip_address = false

##ssm access
    iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile.name



  tags = {
    Name = "private-website-mo-B"
  }
}



