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

variable "guest_os_type_vbox" {
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

variable "iso_url" {
  type    = string
  default = ""
}

variable "non_gui" {
  type    = string
  default = "true"
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
variable "vagrantcloud_token" {
  type    = string
  default = "${env("VAGRANT_CLOUD_TOKEN")}"
}

variable "vm_name" {
  type    = string
  default = ""
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

locals {
  #osdetails    = "ubuntu-${local.vboxversion}-amd64"
  version = "${local.timestamp}"
  #version_desc = "Latest kernel build of Ubuntu Vagrant images based on Ubuntu Server ${local.vboxversion} LTS (Jammy Jellyfish)"
}

# could not parse template for following block: "template: hcl2_upgrade:2: bad character U+0060 '`'"

source "virtualbox-iso" "ubuntu" {
  # boot_command = [
  #   "<wait>c<wait>set gfxpayload=keep<enter><wait>linux /casper/vmlinuz quiet autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ ---<enter><wait>initrd /casper/initrd<wait><enter><wait>boot<enter><wait>"
  # ]

  boot_command = "${var.boot_command}"

  # boot_command = [
  #   "<wait>c<wait>",
  #   "set gfxpayload=keep<enter><wait>",
  #   "linux /casper/vmlinuz <wait>",
  #   "autoinstall quiet fsck.mode=skip <wait>",
  #   "ipv6.disable=1 net.ifnames=0 biosdevname=0 systemd.unified_cgroup_hierarchy=0 ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/' ---<enter><wait>",
  #   "initrd /casper/initrd<wait><enter><wait>",
  #   "boot<enter><wait>"
  # ]

  # boot_command = [
  #   "<wait>c<wait>",
  #   "set gfxpayload=keep<enter><wait>",
  #   "linux /casper/vmlinuz --- autoinstall ds='nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/'<enter><wait>",
  #   "initrd /casper/initrd<wait><enter><wait>",
  #   "boot<enter>",
  #   "<enter><f10><wait>"
  # ]

  # boot_command = [
  #   "<wait>c<wait>",
  #   "set gfxpayload=keep<enter><wait>",
  #   "linux /casper/vmlinuz autoinstall ds='nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/' ---<enter><wait>",
  #   "initrd /casper/initrd<wait><enter><wait>",
  #   "boot<enter>",
  #   "<enter><f10><wait>"
  # ]

  boot_wait               = "${var.boot_wait}"
  http_directory          = "${var.http_directory}"
  guest_additions_path    = "VBoxGuestAdditions_{{.Version}}.iso"
  guest_os_type           = "${var.guest_os_type_vbox}"
  headless                = "${var.non_gui}"
  iso_checksum            = "${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  memory                  = "${var.memory}"
  disk_size               = "${var.disk_size}"
  output_directory        = "${var.vm_name}-vbox"
  shutdown_command        = "echo 'vagrant'|sudo -S shutdown -P now"
  ssh_handshake_attempts  = "1000"
  ssh_keep_alive_interval = "90s"
  ssh_password            = "${var.ssh_password}"
  ssh_timeout             = "90m"
  ssh_username            = "${var.ssh_username}"
  ssh_wait_timeout        = "6h"
  vboxmanage = [
    ["modifyvm", "{{.Name}}", "--memory", "${var.memory}"],
    ["modifyvm", "{{.Name}}", "--cpus", "${var.cpu}"],
    ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"],
  ]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "${var.vm_name}-vbox"
}

build {
  sources = ["source.virtualbox-iso.ubuntu"]

  provisioner "shell" {
    execute_command   = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    expect_disconnect = true
    scripts = [
      "scripts/update.sh",
      "scripts/motd.sh",
      "scripts/networking.sh",
      "scripts/sudoers.sh",
      "scripts/vagrant.sh",
      "scripts/cleanup.sh",
      "scripts/minimize.sh",
    ]
  }
  /*
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
