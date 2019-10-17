data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "odoo" {
  ami                                  = data.aws_ami.ubuntu.id
  instance_type                        = var.ec2_instance_type
  iam_instance_profile                 = aws_iam_instance_profile.EC2profilerole_terra.name
  availability_zone                    = "us-east-1a"
  vpc_security_group_ids               = [aws_security_group.odooSG_terra.id]
  subnet_id                            = aws_subnet.main_terra_1.id
  key_name                             = var.ssh_key
  associate_public_ip_address          = true
  instance_initiated_shutdown_behavior = "stop"

  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
  }

  tags = {
    Name = "Odoo"
  }

  provisioner "file" {
    destination = "/home/ubuntu/install_odoo.sh"
    source      = "install_odoo.sh"

    connection {
      host        = self.public_dns
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ssh_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "touch /home/ubuntu/odoo.conf",
      "echo \"[options]\" >> /home/ubuntu/odoo.conf",
      "echo \"db_host = ${aws_db_instance.odooDB_terra.address}\" >> /home/ubuntu/odoo.conf",
      "echo \"db_port = ${aws_db_instance.odooDB_terra.port}\" >> /home/ubuntu/odoo.conf",
      "echo \"db_user = ${aws_db_instance.odooDB_terra.username}\" >> /home/ubuntu/odoo.conf",
      "echo \"db_password = ${aws_db_instance.odooDB_terra.password}\" >> /home/ubuntu/odoo.conf",
      "sudo sh /home/ubuntu/install_odoo.sh ${var.odooversion}",
    ]

    connection {
      host        = self.public_dns
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ssh_key_path)
    }
  }
}

output "server_domain" {
  value = aws_instance.odoo.public_dns
}

output "ssh_command" {
  value = "ssh -i ${var.ssh_key_path} ubuntu@${aws_instance.odoo.public_dns}"
}

output "web_url" {
  value = "http://${aws_instance.odoo.public_dns}"
}

