provider "aws" {
  region     = "ap-southeast-2"
}

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

data "aws_vpc" "vpc" {
  default = "true"
}

data "aws_subnet" "subnet" {
  vpc_id = "${data.aws_vpc.vpc.id}"
  default_for_az = "true"
  availability_zone = "ap-southeast-2a"
}

resource "aws_security_group" "jumpbox" {
  name = "jumpbox"
  vpc_id      = "${data.aws_vpc.vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jumpbox" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id     = "${data.aws_subnet.subnet.id}"
  security_groups = [
    "${aws_security_group.jumpbox.id}"
  ]
  associate_public_ip_address = "true"
  key_name = "jaap-key"
}

resource "aws_key_pair" "jaap" {
  key_name = "jaap-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHax/vwh/MUwHGpN+DFhfPkUuna/uCn6CGYKiX2mauGMACR4XHtqGIgRdEzDg8UPJ6P8RsWFLbBLTtbAQVqBvnxcZMQRIDywWzi5wxM4ieDbDTZmT6D+WMyLahmPGZS0OgCv/a1F/hkW3t7cRjc5JG5HAlWbfuP0eSvtE7LPfh0Ngu6oxtiH8bvY6MjK3u0W5eDSftUcNozkqMbFKyv/iv18VZGquPhj4I+GfoV1Xhftl3y0Q03SxNTTxJXxVuaPqJhDTlxZ3ohRqdnpzAKH30oDVerMGhwicwwmxbbNBfqHYCgHWxcYALuZxhQ12Xbmru+GwU8s5+fI5b6BhPSVbz vagrant@carverlinux-devops-infra"
}

output "public_ip" {
  value = "${aws_instance.jumpbox.public_ip}"
}
