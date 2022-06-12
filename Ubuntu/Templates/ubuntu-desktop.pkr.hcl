
variable "accelerator" {
  type    = string
  default = "kvm"
}

variable "cpus" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "51200"
}

variable "headless" {
  type    = string
  default = "false"
}

variable "memory" {
  type    = string
  default = "4096"
}

variable "name" {
  type    = string
  default = ""
}

variable "packer_images_output_dir" {
  type    = string
  default = "${env("PACKER_IMAGES_OUTPUT_DIR")}"
}

variable "packer_templates_logs" {
  type    = string
  default = "${env("LOGDIR")}"
}

variable "preseed_file_name" {
  type    = string
  default = "preseed-desktop.cfg"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}

variable "iso_checksum" {
  type    = string
  default = ""
}

variable "iso_url" {
  type    = string
  default = ""
}

source "vmware-iso" "ubuntu-desktop" {
  boot_command         = ["<tab>", "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/Ubuntu/${var.preseed_file_name} ", "auto=true ", "net.ifnames=0 ", "hostname=localhost ", "<enter>"]
  boot_wait            = "10s"
  cpus                 = "${var.cpus}"
  disk_size            = "${var.disk_size}"
  guest_os_type        = "ubuntu64Guest"
  headless             = "${var.headless}"
  http_directory       = "../http"
  iso_checksum         = "${var.iso_checksum}"
  iso_urls             = ["${var.iso_url}"]
  memory               = "${var.memory}"
  output_directory     = "${var.name}-vmware-iso"
  shutdown_command     = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_password         = "${var.ssh_password}"
  ssh_timeout          = "1h"
  ssh_username         = "${var.ssh_username}"
  vm_name              = "${var.name}"
  vmx_data = {
    memsize             = "${var.memory}"
    numvcpus            = "${var.cpus}"
  }
}

build {
  sources = ["source.vmware-iso.ubuntu-desktop"]
  /* 
  provisioner "shell" {
    execute_command = "echo 'vagrant' | sudo -S -E bash '{{ .Path }}'"
    scripts         = ["scripts/linux-common/vagrant.sh", "scripts/ubuntu/update.sh", "scripts/ubuntu/disable_apt-daily.sh", "scripts/ubuntu/spice-vdagent.sh", "scripts/ubuntu/virtualbox-guest-x11.sh", "scripts/linux-common/packer-virt-sysprep/sysprep-op-dhcp-client-state.sh", "scripts/linux-common/packer-virt-sysprep/sysprep-op-logfiles.sh", "scripts/linux-common/packer-virt-sysprep/sysprep-op-machine-id.sh", "scripts/linux-common/packer-virt-sysprep/sysprep-op-network.sh", "scripts/linux-common/packer-virt-sysprep/sysprep-op-package-manager-cache.sh", "scripts/linux-common/packer-virt-sysprep/sysprep-op-ssh-hostkeys.sh", "scripts/linux-common/packer-virt-sysprep/sysprep-op-tmp-files.sh", "scripts/linux-common/packer-virt-sysprep/sysprep-op-disk-space.sh"]
  }

   
  post-processor "vagrant" {
    compression_level    = 9
    output               = "${var.packer_images_output_dir}/${var.name}-<no value>.box"
    vagrantfile_template = "Vagrantfile-linux.template"
  }
  */
}
