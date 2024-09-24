# Project 1
# High Availability WordPress on AWS
## Objective: 
Deploy a highly available WordPress website on AWS using public, private, and database subnets to ensure security and scalability.
### Architecture Overview:
### Two availability zones (AZs) for redundancy and high availability.
* A public subnet in each AZ to host the load balancer and allow public access to the WordPress site.
* A private subnet in each AZ to host the application servers running WordPress.
* A database subnet in each AZ to host the database instances (ec2 with mysql, or AWS managed RDS)
* Depending on individual/team skill levels, there could be several "nice to have" considerations, such as:

### CloudWatch monitoring / alerting for ec2 (eg, is a hard drive full, or is the RAM spiking)
* Autoscaling group instead of standalone instances
* IAM role for WordPress admins
* SSM access to the instances, instead of direct ssh
* Configuration templating or management (Jinja/Ansible etc)
* Deployment pipeline
