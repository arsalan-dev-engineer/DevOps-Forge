variable "db_subnet_group" {
  description = "Private subnet group for db"
  type        = string
}


variable "instance_sg" {
  description = "Private subnet group for db"
  type        = string
}


variable "vpc_id" {
  description = "VPC ID from network module"
  type        = string
}


