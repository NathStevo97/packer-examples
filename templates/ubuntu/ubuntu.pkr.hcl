variable "box_tag" {
  type    = string
  default = ""
}

variable "boot_command" {
  type    = list(string)
  default = []
}

variable "boot_wait" {
  type    = string
  default = "10s"
}

variable "cpu" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "70000"
}

variable "disk_additional_size" {
  type    = list(number)
  default = ["1024"]
}

variable "guest_os_type_vmware" {
  type    = string
  default = ""
}

variable "guest_os_type_vbox" {
  type    = string
  default = ""
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
  default = "9bc6028870aef3f74f4e16b900008179e78b130e6b0b9a140635434a46aa98b0"
}

variable "iso_url" {
  type    = string
  default = "https://releases.ubuntu.com/jammy/ubuntu-22.04.5-live-server-amd64.iso"
}

variable "headless" {
  type    = bool
  default = false
}

variable "memory" {
  type    = string
  default = "4096"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}

variable "switch_name" {
  type    = string
  default = ""
}

variable "vagrantcloud_token" {
  type    = string
  default = "${env("VAGRANT_CLOUD_TOKEN")}"
}

variable "vlan_id" {
  type    = string
  default = ""
}

variable "vm_name" {
  type    = string
  default = ""
}

#################################################################
#                    QEMU-ISO Builder                     #
#################################################################

source "qemu" "ubuntu" {
  boot_command     = var.boot_command
  boot_wait        = var.boot_wait
  cpus             = var.cpu
  disk_cache       = "none"
  disk_discard     = "unmap"
  disk_interface   = "virtio"
  disk_size        = var.disk_size
  format           = "qcow2"
  headless         = var.headless
  http_directory   = var.http_directory
  http_port_min    = var.http_port_min
  http_port_max    = var.http_port_max
  iso_checksum     = var.iso_checksum
  iso_url          = var.iso_url
  memory           = var.memory
  output_directory = "./builds/${var.vm_name}-qemu"
  qemuargs = [
    # ["-cpu", "Nehalem"], # set to "host" for linux-based packer execution
    ["-cpu", "host,+nx"], # set to "Nehalem" for windows-based packer execution
    ["-netdev", "user,hostfwd=tcp::{{ .SSHHostPort }}-:22,id=forward"],
    ["-device", "virtio-net,netdev=forward,id=net0"]
  ]
  shutdown_command = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = "6h"
  ssh_username     = var.ssh_username
}

source "vmware-iso" "ubuntu" {
  boot_command     = var.boot_command
  boot_wait        = var.boot_wait
  cpus             = var.cpu
  disk_size        = var.disk_size
  firmware         = "efi"
  guest_os_type    = var.guest_os_type_vmware
  headless         = var.headless
  http_directory   = var.http_directory
  http_port_min    = var.http_port_min
  http_port_max    = var.http_port_max
  iso_checksum     = var.iso_checksum
  iso_url          = var.iso_url
  memory           = var.memory
  output_directory = "./builds/${var.vm_name}-vmware"
  shutdown_command = "echo '${var.ssh_password}' |sudo -S /sbin/halt -h -p"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = "6h"
  ssh_username     = var.ssh_username
  vm_name          = "${var.vm_name}-vmware"
}

/*
Deprecated Sources
*/

# DEPRECATED: VirtualBox - conflicts with KVM on Linux
# source "virtualbox-iso" "ubuntu" {
#   boot_command = "${var.boot_command}"
#   boot_wait              = "${var.boot_wait}"
#   http_directory         = "${var.http_directory}"
#   guest_additions_path   = "VBoxGuestAdditions_{{.Version}}.iso"
#   guest_os_type          = "${var.guest_os_type_vbox}"
#   headless               = var.headless
#   iso_checksum           = "${var.iso_checksum}"
#   iso_url                = "${var.iso_url}"
#   memory                 = "${var.memory}"
#   disk_size              = "${var.disk_size}"
#   output_directory       = "./builds/${var.vm_name}-vbox"
#   shutdown_command       = "echo '${var.ssh_password}'|sudo -S shutdown -P now"
#   ssh_handshake_attempts = "1000"
#   ssh_password           = "${var.ssh_password}"
#   ssh_timeout            = "6h"
#   ssh_username           = "${var.ssh_username}"
#   ssh_wait_timeout       = "6h"
#   vboxmanage = [
#     ["modifyvm", "{{.Name}}", "--memory", "${var.memory}"],
#     ["modifyvm", "{{.Name}}", "--cpus", "${var.cpu}"],
#     ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"],
#   ]
#   virtualbox_version_file = ".vbox_version"
#   vm_name                 = "${var.vm_name}-vbox"
# }

# DEPRECATED: Hyper-V - Windows only
# source "hyperv-iso" "ubuntu" {
#   boot_command          = "${var.boot_command}"
#   boot_wait             = "${var.boot_wait}"
#   communicator          = "ssh"
#   cpus                  = "${var.cpu}"
#   disk_block_size       = "1"
#   disk_size             = "${var.disk_size}"
#   enable_dynamic_memory = "true"
#   enable_secure_boot    = false
#   generation            = 2
#   guest_additions_mode  = "disable"
#   headless              = var.headless
#   http_directory        = "${var.http_directory}"
#   iso_checksum          = "sha256:${var.iso_checksum}"
#   iso_url               = "${var.iso_url}"
#   memory                = "${var.memory}"
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
  sources = ["source.qemu.ubuntu", "source.vmware-iso.ubuntu"]

  /*  provisioner "shell" {
    only              = ["hyperv-iso.ubuntu"]
    execute_command   = "echo 'password' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    expect_disconnect = true
    scripts = [
      "scripts/init_hyperv.sh",
      "scripts/uefi.sh"
    ]
  }

  provisioner "shell" {
    execute_command   = "echo 'password' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    expect_disconnect = true
    script            = "scripts/update.sh"
  }

  provisioner "shell" {
    execute_command   = "echo 'password' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    expect_disconnect = true
    scripts = [
      "scripts/motd.sh",
      "scripts/networking.sh",
      "scripts/sudoers.sh",
      "scripts/vagrant.sh",
      "scripts/cleanup.sh",
      "scripts/minimize.sh",
    ]
  } */

  /*##
  post-processors {
    post-processor "vagrant" {
      keep_input_artifact = false
      compression_level   = 9
      # provider_override = {
      #   virtualbox = {
      #     output = "target/${local.osdetails}.box"
      #   }
      # }
    }
    post-processor "vagrant-cloud" {
      access_token        = "${var.vagrantcloud_token}"
      box_tag             = "${var.box_tag}"
      version             = "${local.vboxversion}-${local.version}"
      version_description = "${local.version_desc}"
    }
  }
  */
}
