variable "boot_command" {
  type    = list(string)
  default = []
}

variable "boot_command_hyperv" {
  type    = list(string)
  default = []
}

variable "boot_command_qemu" {
  type    = list(string)
  default = []
}

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

variable "headless" {
  type    = bool
  default = false
}

variable "http_directory" {
  type    = string
  default = ""
}

variable "http_port_min" {
  type    = string
  default = "9000"
}

variable "http_port_max" {
  type    = string
  default = "9000"
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

variable "switch_name" {
  type    = string
  default = ""
}

variable "vlan_id" {
  type    = string
  default = ""
}

variable "vm_name" {
  type    = string
  default = ""
}

source "vmware-iso" "centos" {
  boot_command     = var.boot_command
  boot_wait        = var.boot_wait
  cpus             = var.numvcpus
  disk_size        = var.disk_size
  disk_type_id     = "0"
  firmware         = "efi"
  guest_os_type    = var.guest_os_type_vmware
  headless         = var.headless
  http_directory   = var.http_directory
  http_port_min    = var.http_port_min
  http_port_max    = var.http_port_max
  iso_checksum     = var.iso_checksum
  iso_urls         = [var.iso_path, var.iso_url]
  memory           = var.memsize
  output_directory = "./builds/${var.vm_name}"
  shutdown_command = "echo '${var.ssh_password}' | sudo -S /sbin/shutdown -P now"
  shutdown_timeout = "1h"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_username
  vm_name          = var.vm_name
}

source "qemu" "centos" {
  boot_command     = var.boot_command_qemu
  boot_wait        = var.boot_wait
  disk_size        = var.disk_size
  headless         = var.headless
  http_directory   = var.http_directory
  http_port_min    = var.http_port_min
  http_port_max    = var.http_port_max
  iso_checksum     = var.iso_checksum
  iso_url          = var.iso_url
  memory           = var.memsize
  output_directory = "./builds/${var.vm_name}-qemu"
  qemuargs = [
    ["-cpu", "Nehalem"], # set to "host" for linux-based packer execution
    ["-netdev", "user,hostfwd=tcp::{{ .SSHHostPort }}-:22,id=forward"],
    ["-device", "virtio-net,netdev=forward,id=net0"]
  ]
  shutdown_command = "echo '${var.ssh_password}'|sudo -S /sbin/halt -h -p"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = "6h"
  ssh_username     = var.ssh_username
  vm_name          = "${var.vm_name}-qemu"
}

/*
Deprecated Sources
*/

# DEPRECATED: VirtualBox - conflicts with KVM on Linux
# source "virtualbox-iso" "centos" {
#   boot_command     = "${var.boot_command}"
#   boot_wait        = "15s"
#   disk_size        = "${var.disk_size}"
#   guest_os_type    = "${var.guest_os_type_virtualbox}"
#   headless         = var.headless
#   http_directory   = "${var.http_directory}"
#   iso_checksum     = "${var.iso_checksum}"
#   iso_interface    = "sata"
#   iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
#   output_directory = "./builds/${var.vm_name}"
#   shutdown_command = "echo 'vagrant' | sudo -S /sbin/shutdown -P now"
#   ssh_password     = "${var.ssh_password}"
#   ssh_port         = 22
#   ssh_timeout      = "${var.ssh_timeout}"
#   ssh_username     = "${var.ssh_username}"
#   vboxmanage = [
#     ["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"],
#     ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"],
#     ["modifyvm", "{{ .Name }}", "--firmware", "EFI"],
#     ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]
#   ]
#   vm_name = "${var.vm_name}"
# }

# DEPRECATED: Hyper-V - Windows only
# source "hyperv-iso" "centos" {
#   boot_command          = "${var.boot_command_hyperv}"
#   boot_wait             = "${var.boot_wait}"
#   communicator          = "ssh"
#   cpus                  = "${var.numvcpus}"
#   disk_block_size       = "1"
#   disk_size             = "${var.disk_size}"
#   enable_dynamic_memory = "true"
#   enable_secure_boot    = false
#   generation            = 2
#   guest_additions_mode  = "disable"
#   headless              = var.headless
#   http_directory        = "${var.http_directory}"
#   iso_checksum          = "${var.iso_checksum}"
#   iso_urls              = ["${var.iso_path}", "${var.iso_url}"]
#   memory                = "${var.memsize}"
#   output_directory      = "./builds/${var.vm_name}-hyperv"
#   shutdown_command      = "echo 'password' | sudo -S shutdown -P now"
#   shutdown_timeout      = "30m"
#   ssh_password          = "${var.ssh_password}"
#   ssh_timeout           = "4h"
#   ssh_username          = "${var.ssh_username}"
#   switch_name           = "${var.switch_name}"
#   temp_path             = "."
#   vlan_id               = "${var.vlan_id}"
#   vm_name               = "${var.vm_name}"
# }

build {
  sources = ["source.vmware-iso.centos", "source.qemu.centos"]

  /*   provisioner "shell" {
    execute_command = "echo 'vagrant'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline          = ["yum -y update", "yum -y install python3"]
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' |{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline          = ["yum -y install epel-release", "yum -y update", "yum -y install ansible"]
  }

  provisioner "ansible-local" {
    playbook_file = "./Files/scripts/setup.yml"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = ["./Files/scripts/cleanup.sh"]
  } */

}
