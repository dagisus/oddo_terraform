resource "aws_iam_role" "EC2role_terra" {
  name = "EC2role_terra"

  assume_role_policy = <<EOF
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
EOF

}

resource "aws_iam_role_policy" "EC2policy_terra" {
  name = "test_policy"
  role = aws_iam_role.EC2role_terra.id

  policy = <<EOF
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
EOF

}

resource "aws_iam_instance_profile" "EC2profilerole_terra" {
  name = "EC2profilerole"
  role = aws_iam_role.EC2role_terra.name
}

