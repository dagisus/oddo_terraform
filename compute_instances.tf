data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "odoo" {
  ami                             = "${data.aws_ami.ubuntu.id}"
  instance_type                   = "t2.micro"
  iam_instance_profile            = "EC2Role"
  availability_zone               = "us-east-1a"
  vpc_security_group_ids          = ["${aws_security_group.odooSG_terra.id}"]
  subnet_id                       = "${aws_subnet.main_terra_1.id}"
  key_name                        = "hosts_key"
  associate_public_ip_address     = true
  instance_initiated_shutdown_behavior = "stop"



  root_block_device {
    volume_size                   = "8"
    volume_type                   = "gp2"
  }  

  tags {
    Name = "Odoo"
  }
  
  connection {
    host     = "self.public_ip"
    type     = "ssh"
    user     = "ubuntu" 
    private_key = "${file("/Users/dagisus/Dropbox/PC_CM/ssh/pem/hosts_key.pem")}"
  }

  provisioner "remote-exec" {
  inline = [
    "sudo su",
    "apt-get update",
    "apt-get upgrde",
    "wget -O - https://nightly.odoo.com/odoo.key | apt-key add -",
    "echo \"deb http://nightly.odoo.com/11.0/nightly/deb/ ./\" >> /etc/apt/sources.list.d/odoo.list",
    "apt-get update && apt-get install odoo",
    "rm /etc/odoo/odoo.conf",
    "touch /etc/odoo/odoo.conf",
    "echo \"${aws_db_instance.odooDB_terra.endpoint}\" >> /etc/odoo/odoo.conf",
    "echo \"db_port = ${aws_db_instance.odooDB_terra.port}\" >> /etc/odoo/odoo.conf",
    "echo \"db_user = ${aws_db_instance.odooDB_terra.username}\" >> /etc/odoo/odoo.conf",
    "echo \"db_password = ${aws_db_instance.odooDB_terra.password}\" >> /etc/odoo/odoo.conf",
    "service odoo restart",
    ]
  }
}

output "server_domain" {
  value = "${aws_instance.odoo.public_dns}"
}
