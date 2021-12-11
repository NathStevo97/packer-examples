variable "iso_url" {
  type = string
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

source "vmware-iso" "rhel-7" {
  boot_command     = ["<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-7.cfg<enter><wait>"]
  boot_wait        = "10s"
  disk_size        = 81920
  guest_os_type    = "rhel7-64"
  headless         = false
  http_directory   = "../http/RHEL"
  iso_checksum     = "md5:7e40e30e794ca80fcd840aa1a54876b0"
  iso_urls         = ["../../ISOs/RHEL/rhel-server-7.9-x86_64-dvd.iso"]
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
  vm_name          = "packer-rhel-7-x86_64"
}

build {
  sources = ["source.vmware-iso.rhel-7"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "./Files/scripts/cleanup.sh"
  }
}