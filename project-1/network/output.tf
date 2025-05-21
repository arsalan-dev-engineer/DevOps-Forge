output "private_subnet_id_A" {
  value = aws_subnet.private_subnet_a.id
}


output "private_subnet_id_B" {
  value = aws_subnet.private_subnet_b.id
}

output "alb_sg_id" {
  value= aws_security_group.alb_sg.id
}

output "vpc_id" {
  value=aws_vpc.website-vpc.id
}

output "alb_id" {
  value=aws_lb.app_lb.id
}

