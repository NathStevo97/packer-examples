variable "boot_wait" {
  type    = string
  default = ""
}

variable "boot_wait_virtualbox" {
  type    = string
  default = ""
}

variable "box_basename" {
  type    = string
  default = ""
}

variable "build_directory" {
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
  type    = bool
  default = "false"
}

variable "http_directory" {
  type    = string
  default = ""
}

variable "hyperv_generation" {
  type    = string
  default = ""
}

variable "hyperv_switch" {
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

source "vmware-iso" "rhel-7" {
  boot_command     = ["<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-7.cfg<enter><wait>"]
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  guest_os_type    = "${var.guest_os_type_vmware}"
  headless         = "${var.headless}"
  http_directory   = "${var.http_directory}"
  iso_checksum     = "${var.iso_checksum}"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  output_directory = "${var.build_directory}/${var.vm_name}-vmware"
  shutdown_command = "echo 'vagrant'|sudo -S /sbin/halt -h -p"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "${var.ssh_timeout}"
  ssh_username     = "${var.ssh_username}"
  vmx_data = {
    memsize  = "${var.memsize}"
    numvcpus = "${var.numvcpus}"
  }
  vm_name = "${var.vm_name}"
}

#################################################################
#                    Virtualbox-ISO Builder                     #
#################################################################

source "virtualbox-iso" "rhel-7" {
  boot_command         = ["<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-7.cfg<enter><wait>"]
  boot_wait            = "${var.boot_wait_virtualbox}"
  disk_size            = "${var.disk_size}"
  guest_additions_mode = "disable"
  #guest_additions_path = "c:/Windows/Temp/windows.iso"
  guest_os_type        = "${var.guest_os_type_virtualbox}"
  hard_drive_interface = "sata"
  headless             = true
  http_directory       = "${var.http_directory}"
  iso_checksum         = "${var.iso_checksum}"
  iso_urls             = ["${var.iso_path}", "${var.iso_url}"]
  iso_interface        = "sata"
  output_directory     = "${var.build_directory}/${var.vm_name}-vbox"
  shutdown_command     = "echo 'vagrant'|sudo -S /sbin/halt -h -p"
  ssh_password         = "${var.ssh_password}"
  ssh_port             = 22
  ssh_timeout          = "${var.ssh_timeout}"
  ssh_username         = "${var.ssh_username}"
  vboxmanage           = [["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"], ["modifyvm", "{{ .Name }}", "--vram", "32"], ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]]
}

#################################################################
#                    QEMU-ISO Builder                     #
#################################################################

source "qemu" "rhel-7" {
  headless         = var.headless
  boot_command     = ["<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-7.cfg<enter><wait>"]
  floppy_files     = ["${var.http_directory}/ks-7.cfg", ]
  http_directory   = "${var.http_directory}"
  iso_checksum     = "${var.iso_checksum}"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  output_directory = "../builds/${var.vm_name}-qemu"
  shutdown_command = "echo 'vagrant'|sudo -S shutdown -P now"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "${var.ssh_timeout}"
  ssh_username     = "${var.ssh_username}"
  disk_size        = "${var.disk_size}"
  disk_interface   = "virtio-scsi"
  memory           = "${var.memsize}"
  cpus             = "${var.numvcpus}"
  boot_wait        = "5s"
}

build {
  sources = ["source.vmware-iso.rhel-7", "source.virtualbox-iso.rhel-7", "source.qemu.rhel-7"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "./Files/scripts/cleanup.sh"
  }
}