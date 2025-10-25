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


resource "aws_iam_policy" "ssm_db_access" {
  name        = "SSM-DB-Password-Access"
  description = "Allows EC2 instances to read the DB password from SSM"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters"
        ]
        Resource = "arn:aws:ssm:eu-west-2:${data.aws_caller_identity.current.account_id}:parameter/wordpress/db/password"
      }
    ]
  })
}

data "aws_caller_identity" "current" {}







resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_ssm_profile" {
  name = "UKDDC-EC2-SSM-InstanceProfile"
  role = aws_iam_role.ec2_ssm_role.name
}


resource "aws_iam_role_policy_attachment" "ssm_db_access_attach" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = aws_iam_policy.ssm_db_access.arn
}
