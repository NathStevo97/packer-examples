

source "vmware-iso" "debian" {
  boot_command     = "${var.boot_command}"
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  disk_type_id     = "0"
  guest_os_type    = "${var.guest_os_type_vmware}"
  headless         = "${var.headless}"
  http_directory   = "${var.http_directory}"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  output_directory = "${var.name}-vmware"
  shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "1h"
  ssh_username     = "${var.ssh_username}"
  vm_name          = "${var.name}-vmware"
  vmx_data = {
    firmware            = "efi"
    memsize             = "${var.ram}"
    numvcpus            = "${var.cpu}"
    "virtualHW.version" = "14"
  }
}

source "virtualbox-iso" "debian" {
  boot_command     = "${var.boot_command}"
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  guest_os_type    = "${var.guest_os_type_vbox}"
  headless         = "${var.headless}"
  http_directory   = "${var.http_directory}"
  iso_checksum     = "${var.iso_checksum}"
  iso_interface    = "sata"
  iso_url          = "${var.iso_url}"
  output_directory = "${var.name}-vbox"
  shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "30m"
  ssh_username     = "${var.ssh_username}"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--memory", "${var.ram}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${var.cpu}"],
    ["modifyvm", "{{ .Name }}", "--firmware", "EFI"],
    ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]
  ]
  vm_name = "${var.name}-virtualbox"
}

build {
  sources = ["source.vmware-iso.debian", "source.virtualbox-iso.debian"]
}