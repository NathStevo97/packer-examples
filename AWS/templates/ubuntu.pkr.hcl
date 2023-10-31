variable "name_prefix" {
  type        = string
  description = "resource naming prefix for identification"
}

variable "instance_type" {
  type        = string
  description = "AWS EC2 Instance Type"
}

variable "region" {
  type        = string
  description = "AWS Region for EC2 Base AMI"
}

variable "ssh_username" {
  type        = string
  description = "SSH Username to connect to base AMI for provisioner execution"
}

data "amazon-ami" "ubuntu" {
  filters = {
    name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["099720109477"]
  region      = "${var.region}"
  #profile     = "${var.profile}"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "ubuntu" {
  ami_name      = "ubuntu-ami-example ${local.timestamp}"
  instance_type = "${var.instance_type}"
  region        = "${var.region}"
  #profile       = "${var.profile}"
  source_ami    = "${data.amazon-ami.ubuntu.id}"
  ssh_username  = "${var.ssh_username}"
  tags = {
    Name  = "${var.name_prefix}"
    Value = "${var.name_prefix}-${local.timestamp}"
  }
}

build {
  sources = ["source.amazon-ebs.ubuntu"]
}