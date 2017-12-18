resource "aws_security_group" "odooSG_terra" {
  name        = "odooSG_terra"
  description = "odooSG_terra"
  vpc_id      = "${aws_vpc.main_terra.id}"

  ingress {
    from_port   = 8069
    to_port     = 8069
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "odooDBSG_terra" {
  name        = "odooDBSG_terra"
  description = "odooDBSG_terra"
  vpc_id      = "${aws_vpc.main_terra.id}"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = ["${aws_security_group.odooSG_terra.id}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_vpc" "main_terra" {
  cidr_block = "172.30.0.0/16"
}

resource "aws_subnet" "main_terra_1" {
  vpc_id     = "${aws_vpc.main_terra.id}"
  cidr_block = "172.30.0.0/24"
  availability_zone = "us-east-1a"

  tags {
    Name = "Main"
  }
}

resource "aws_subnet" "main_terra_2" {
  vpc_id     = "${aws_vpc.main_terra.id}"
  cidr_block = "172.30.1.0/24"
  availability_zone = "us-east-1b"

  tags {
    Name = "Main"
  }
}

resource "aws_db_subnet_group" "main_bd_subnet_group" {
  name       = "main_bd_subnet_group"
  subnet_ids = ["${aws_subnet.main_terra_1.id}", "${aws_subnet.main_terra_2.id}"]

  tags {
    Name = "My DB subnet group"
  }
}