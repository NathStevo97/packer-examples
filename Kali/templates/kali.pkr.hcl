variable "boot_wait" {
  type    = string
  default = ""
}

variable "box_desc" {
  type    = string
  default = ""
}

variable "box_name" {
  type    = string
  default = ""
}

variable "cpus" {
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

variable "headless" {
  type    = string
  default = "true"
}

variable "iso_checksum" {
  type    = string
  default = ""
}

variable "iso_checksum_type" {
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

variable "http_directory" {
  type    = string
  default = ""
}

variable "memory" {
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

source "virtualbox-iso" "kali_virtualbox" {
  boot_command            = ["<esc><wait>", "install preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kali/preseed-rolling-desktop.cfg locale=en_US.UTF-8 keymap=us <wait>", "netcfg/get_hostname={{ .Name }} netcfg/get_domain=local.lan fb=false debconf/frontend=noninteractive console-setup/ask_detect=false <wait>", "<enter><wait>"]
  boot_wait               = "${var.boot_wait}"
  disk_size               = "${var.disk_size}"
  format                  = "ova"
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "${var.guest_os_type_virtualbox}"
  headless                = "${var.headless}"
  http_directory          = "${var.http_directory}"
  iso_checksum            = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_urls                = ["${var.iso_path}", "${var.iso_url}"]
  output_directory        = "../builds/${var.vm_name}-vbox"
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -h -P now"
  shutdown_timeout        = "30m"
  ssh_password            = "${var.ssh_password}"
  ssh_port                = 22
  ssh_timeout             = "${var.ssh_timeout}"
  ssh_username            = "${var.ssh_username}"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "${var.memory}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.cpus}"], ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "${var.vm_name}"
}

source "vmware-iso" "kali_vmware" {
  boot_command   = ["<esc><wait>", "install preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kali/preseed-rolling-desktop.cfg locale=en_US.UTF-8 keymap=us <wait>", "netcfg/get_hostname={{ .Name }} netcfg/get_domain=local.lan fb=false debconf/frontend=noninteractive console-setup/ask_detect=false <wait>", "<enter><wait>"]
  boot_wait      = "${var.boot_wait}"
  cpus           = "${var.cpus}"
  disk_size      = "${var.disk_size}"
  guest_os_type  = "${var.guest_os_type_vmware}"
  headless       = "${var.headless}"
  http_directory = "${var.http_directory}"
  iso_checksum   = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_urls       = ["${var.iso_path}", "${var.iso_url}"]
  network        = "nat"
  memory         = "${var.memory}"
  output_directory = "../builds/${var.vm_name}-vmware"
  shutdown_command = "echo 'vagrant'|sudo -S shutdown -P now"
  shutdown_timeout = "1h"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "${var.ssh_timeout}"
  ssh_username     = "${var.ssh_username}"
  vm_name          = "${var.vm_name}"
}

build {
  description = "{{user `box_desc`}}"

  sources = ["source.virtualbox-iso.kali_virtualbox", "source.vmware-iso.kali_vmware"]

  provisioner "shell" {
    expect_disconnect = true
    execute_command   = "echo 'vagrant'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    pause_before      = "10s"
    scripts           = ["./Files/ansible.sh", ]
  }
  /*
  provisioner "shell" {
    execute_command = "echo 'vagrant'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    pause_before = "10s"
    Files      = ["./Files/sudoers.sh","./Files/python.sh", "./Files/virtualbox.sh", "./Files/networking.sh", "./Files/vagrant.sh", "./Files/cleanup.sh", "./Files/minimize.sh"]
  }

  post-processor "vagrant" {
    keep_input_artifact = true
    only                = ["virtualbox-iso"]
    output              = "builds/${var.box_name}"
  }
  */
}
