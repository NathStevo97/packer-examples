variable "iso_path" {
  type    = string
  default = "../../ISOs/RHEL/rhel-8.1-x86_64-dvd.iso"
}

variable "iso_url" {
  type    = string
  default = "https://archive.org/download/rhel-server-7.9-x86_64-dvd/rhel-server-7.9-x86_64-dvd.iso"
}

variable "memsize" {
  type    = string
  default = "2048"
}

variable "numvcpus" {
  type    = string
  default = "2"
}

source "vmware-iso" "rhel-8" {
  boot_command     = ["<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-8.cfg<enter><wait>"]
  boot_wait        = "10s"
  disk_size        = 81920
  guest_os_type    = "rhel8-64"
  headless         = false
  http_directory   = "../http/RHEL"
  iso_checksum     = "md5:d04ab8a647d570708bfef8835faf37da"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  shutdown_command = "echo 'vagrant'|sudo -S /sbin/halt -h -p"
  ssh_password     = "vagrant"
  ssh_port         = 22
  ssh_timeout      = "10000s"
  ssh_username     = "vagrant"
  vmx_data = {
    memsize             = "${var.memsize}"
    numvcpus            = "${var.numvcpus}"
    "scsi0.virtualDev"  = "lsisas1068"
    "virtualHW.version" = "14"
  }
  vm_name = "packer-rhel-8-x86_64"
}

build {
  sources = ["source.vmware-iso.rhel-8"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "./Files/scripts/cleanup.sh"
  }
}