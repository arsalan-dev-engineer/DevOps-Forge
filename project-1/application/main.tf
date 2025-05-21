module "network" {
  source = "../network/"  # importing this
}

##SG for ec2 instances
resource "aws_security_group" "instance_sg" {
  name        = "private-instance-sg"
  description = "Allow HTTP from ALB"
  vpc_id      = module.network.vpc_id


  ingress {
    description = "HTTP from ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [module.network.alb_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}








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

  vpc_security_group_ids = [aws_security_group.instance_sg.id]


    # Ensure the instance is launched in the private subnet
   subnet_id = module.network.private_subnet_id_A
  
  # Ensure the instance doesn't have a public IP
  associate_public_ip_address = false

##ssm access
    iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile.name


  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              systemctl enable apache2
              systemctl start apache2
              echo "Hello from A (Apache)" > /var/www/html/index.html
              EOF


  tags = {
    Name = "private-website-mo-A"
  }
}


###ec2 for private subnet B
resource "aws_instance" "web-B" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"


vpc_security_group_ids = [aws_security_group.instance_sg.id]

    # Ensure the instance is launched in the private subnet
   subnet_id = module.network.private_subnet_id_B
  
  # Ensure the instance doesn't have a public IP
  associate_public_ip_address = false

##ssm access
    iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile.name

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              systemctl enable apache2
              systemctl start apache2
              echo "Hello from B (Apache)" > /var/www/html/index.html
              EOF

  tags = {
    Name = "private-website-mo-B"
  }
}




resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.network.vpc_id
  target_type = "instance"

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
  }
}

resource "aws_lb_target_group_attachment" "target_attachmentA" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.web-A.id # Replace with EC2 ID
  port             = 80

    depends_on = [aws_instance.web-A]

}


resource "aws_lb_target_group_attachment" "target_attachmentB" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.web-B.id # Replace with EC2 ID
  port             = 80
    depends_on = [aws_instance.web-B]

}



resource "aws_lb_listener" "http_listener" {
  load_balancer_arn =  module.network.alb_id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
