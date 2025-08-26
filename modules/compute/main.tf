data "aws_ami" "odoo" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "tag:odoo_version"
    values = [var.odoo_version]
  }
}

resource "aws_launch_template" "odoo" {
  name_prefix   = "odoo-"
  image_id      = data.aws_ami.odoo.id
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  network_interfaces {
    subnet_id                   = var.subnet_id
    security_groups             = var.security_group_ids
    associate_public_ip_address = true
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh.tpl", {
    db_secret_arn = var.db_secret_arn
    region        = var.region
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Odoo"
    }
  }
}

resource "aws_instance" "odoo" {
  launch_template {
    id      = aws_launch_template.odoo.id
    version = "$Latest"
  }
}
