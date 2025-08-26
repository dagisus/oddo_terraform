variable "odoo_version" {
  type = string
}

variable "ami_version" {
  type = string
  default = "v1"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

source "amazon-ebs" "odoo" {
  region        = var.region
  instance_type = "t3.micro"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["099720109477"]
    most_recent = true
  }
  ssh_username = "ubuntu"
  ami_name     = "odoo-${var.odoo_version}-${var.ami_version}"
  tags = {
    odoo_version = var.odoo_version
    ami_version  = var.ami_version
  }
}

build {
  sources = ["source.amazon-ebs.odoo"]

  provisioner "shell" {
    script          = "${path.root}/install_odoo.sh"
    execute_command = "sudo -E bash '{{ .Path }}' ${var.odoo_version}"
  }
}
