resource "aws_iam_role" "ec2_role" {
  name = "EC2role_terra"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_describe"
  role = aws_iam_role.ec2_role.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "rds:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2profilerole"
  role = aws_iam_role.ec2_role.name
}
