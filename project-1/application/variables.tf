variable "vpc_id" {
  description = "VPC ID from network module"
  type        = string
}

variable "private_subnet_id_A" {
  description = "Private subnet A ID"
  type        = string
}

variable "private_subnet_id_B" {
  description = "Private subnet B ID"
  type        = string
}

variable "alb_id" {
  description = "Application Load Balancer ID"
  type        = string
}

variable "alb_sg_id" {
  description = "ALB Security Group ID"
  type        = string
}
