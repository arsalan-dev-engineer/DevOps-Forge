data "aws_iam_policy" "boundary" {
  name = "UKDDCAWSRestrictedAdmin-PermBoundary"
}

resource "aws_iam_role" "ec2_ssm_role" {
  name               = "UKDDC-EC2-SSM-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action = "sts:AssumeRole",
    }]
  })
  permissions_boundary = data.aws_iam_policy.boundary.arn
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_ssm_profile" {
  name = "UKDDC-EC2-SSM-InstanceProfile"
  role = aws_iam_role.ec2_ssm_role.name
}
