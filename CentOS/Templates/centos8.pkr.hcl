
variable "boot_wait" {
  type    = string
  default = ""
}

variable "disk_size" {
  type    = string
  default = ""
}

variable "guest_os_type_virtualbox" {
  type    = string
  default = ""
}

variable "guest_os_type_vmware" {
  type    = string
  default = ""
}

variable "http_directory" {
  type    = string
  default = ""
}

variable "iso_checksum" {
  type    = string
  default = ""
}

variable "iso_path" {
  type    = string
  default = ""
}

variable "iso_url" {
  type    = string
  default = ""
}

variable "memsize" {
  type    = string
  default = ""
}

variable "numvcpus" {
  type    = string
  default = ""
}

variable "ssh_password" {
  type    = string
  default = ""
}

variable "ssh_timeout" {
  type    = string
  default = ""
}

variable "ssh_username" {
  type    = string
  default = ""
}

variable "vm_name" {
  type    = string
  default = ""
}

source "virtualbox-iso" "centos8_vbox" {
  boot_command     = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text <wait10s> inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-8-stream.cfg <wait10s> <leftCtrlOn>x<leftCtrlOff>"]
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  guest_os_type    = "${var.guest_os_type_virtualbox}"
  headless         = true
  http_directory   = "${var.http_directory}"
  iso_checksum     = "${var.iso_checksum}"
  iso_interface    = "sata"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  shutdown_command = "echo 'vagrant' | sudo -S /sbin/shutdown -P now"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "${var.ssh_timeout}"
  ssh_username     = "${var.ssh_username}"
  vboxmanage       = [["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"], ["modifyvm", "{{ .Name }}", "--firmware", "EFI"], ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]]
  vm_name          = "${var.vm_name}"
}

source "vmware-iso" "centos8_vmware" {
  boot_command     = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-8-stream.cfg<leftCtrlOn>x<leftCtrlOff>"]
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  disk_type_id     = "0"
  guest_os_type    = "${var.guest_os_type_vmware}"
  headless         = false
  http_directory   = "${var.http_directory}"
  iso_checksum     = "${var.iso_checksum}"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  shutdown_command = "echo 'vagrant' | sudo -S /sbin/shutdown -P now"
  shutdown_timeout = "1h"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "${var.ssh_timeout}"
  ssh_username     = "${var.ssh_username}"
  vm_name          = "${var.vm_name}"
  vmx_data = {
    firmware            = "efi"
    memsize             = "${var.memsize}"
    numvcpus            = "${var.numvcpus}"
    "virtualHW.version" = "14"
  }
}

build {
  sources = ["source.virtualbox-iso.centos8_vbox", "source.vmware-iso.centos8_vmware"]

  provisioner "shell" {
    execute_command = "echo 'vagrant'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline          = ["dnf -y update", "dnf -y install python3", "alternatives --set python /usr/bin/python3"]
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline          = ["yum -y install epel-release", "yum -y update", "yum -y install ansible"]
  }


  provisioner "ansible-local" {
    playbook_file = "./Files/scripts/setup.yml"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = ["./Files/scripts/cleanup.sh"]
  }

}
