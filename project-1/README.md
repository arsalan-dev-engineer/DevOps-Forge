# High Availability WordPress on AWS

This project sets up a highly available, scalable, and secure WordPress deployment on AWS using best practices in cloud infrastructure. The deployment leverages various AWS services to ensure robust performance, reliability, and scalability.

## Architecture Overview
The following AWS services are used in this deployment:
- **EC2**: Hosts WordPress instances in multiple Availability Zones.
- **RDS (MySQL)**: Provides a highly available database backend with Multi-AZ replication.
- **Elastic Load Balancer (ELB)**: Distributes incoming traffic across EC2 instances.
- **S3**: Stores WordPress media assets.
- **Auto Scaling**: Dynamically adjusts the number of EC2 instances based on traffic and load.
- **Route 53**: Manages DNS and routes traffic to the ELB.
- **CloudFront (optional)**: Optimizes content delivery with a CDN for static assets.

## Prerequisites
- AWS Account
- Terraform installed on your machine
- IAM access with permissions to create and manage AWS resources
- Domain name (for Route 53 setup)

## Project Structure
```plaintext
project-root/
├── terraform/
│   ├── main.tf                 # Main configuration for AWS services
│   ├── variables.tf            # Variables used in the Terraform scripts
│   ├── outputs.tf              # Outputs (e.g., public DNS)
│   ├── autoscaling.tf          # Auto Scaling configuration
│   ├── ec2.tf                  # EC2 instance configuration
│   ├── rds.tf                  # RDS configuration
│   ├── elb.tf                  # ELB configuration
│   ├── s3.tf                   # S3 bucket for media storage
│   ├── route53.tf              # Route 53 DNS setup
│   └── security.tf             # Security group definitions
├── README.md                   # Project documentation
└── .gitignore                  # Files to be ignored by Git
