module "network" {
  source = "../network/"  # <- update this to your new folder
  # other variables...
}

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

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

    # Ensure the instance is launched in the private subnet
   subnet_id = module.network.private_subnet_id
  
  # Ensure the instance doesn't have a public IP
  associate_public_ip_address = false


  tags = {
    Name = "HelloWorld"
  }
}