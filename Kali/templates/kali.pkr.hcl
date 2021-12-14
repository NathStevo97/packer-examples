variable "iso_path" {
  type    = string
  default = "../../ISOs/Kali/kali-linux-2021.1-installer-amd64.iso"
}

variable "iso_url" {
  type    = string
  default = "https://cdimage.kali.org/kali-2021.1/kali-linux-2021.1-installer-amd64.iso"
}

variable "password" {
  type    = string
  default = "kali"
}

variable "username" {
  type    = string
  default = "kali"
}

source "virtualbox-iso" "kali_vbox" {
  boot_command            = ["<esc><wait>", "/install.amd/vmlinuz<wait>", " auto<wait>", " console-setup/ask_detect=false<wait>", " console-setup/layoutcode=us<wait>", " console-setup/modelcode=pc105<wait>", " debconf/frontend=noninteractive<wait>", " debian-installer=en_US<wait>", " fb=false<wait>", " initrd=/install.amd/initrd.gz<wait>", " kbd-chooser/method=us<wait>", " netcfg/choose_interface=eth0<wait>", " console-keymaps-at/keymap=us<wait>", " keyboard-configuration/xkb-keymap=us<wait>", " keyboard-configuration/layout=USA<wait>", " keyboard-configuration/variant=USA<wait>", " locale=en_US<wait>", " netcfg/get_domain=vm<wait>", " netcfg/get_hostname=kali<wait>", " grub-installer/bootdev=/dev/sda<wait>", " noapic<wait>", " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kali/preseed.cfg auto=true priority=critical", " -- <wait>", "<enter><wait>"]
  boot_wait               = "10s"
  disk_size               = 81920
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "Debian_64"
  headless                = true
  http_directory          = "../http"
  iso_checksum            = "sha256:265812bc13ab11d40c610424871bdf9198b9e7cad99b06540d96fac67dd704de"
  iso_urls                = ["${var.iso_path}", "${var.iso_url}"]
  shutdown_command        = "echo 'kali'|sudo -S shutdown -P now"
  ssh_password            = "kali"
  ssh_port                = 22
  ssh_timeout             = "8000s"
  ssh_username            = "kali"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "4096"], ["modifyvm", "{{ .Name }}", "--cpus", "1"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "packer-kali-rolling-amd64"
}

source "vmware-iso" "kali_vmware" {
  boot_command     = ["<esc><wait>", "/install.amd/vmlinuz<wait>", " auto<wait>", " console-setup/ask_detect=false<wait>", " console-setup/layoutcode=us<wait>", " console-setup/modelcode=pc105<wait>", " debconf/frontend=noninteractive<wait>", " debian-installer=en_US<wait>", " fb=false<wait>", " initrd=/install.amd/initrd.gz<wait>", " kbd-chooser/method=us<wait>", " netcfg/choose_interface=eth0<wait>", " console-keymaps-at/keymap=us<wait>", " keyboard-configuration/xkb-keymap=us<wait>", " keyboard-configuration/layout=USA<wait>", " keyboard-configuration/variant=USA<wait>", " locale=en_US<wait>", " netcfg/get_domain=vm<wait>", " netcfg/get_hostname=kali<wait>", " grub-installer/bootdev=/dev/sda<wait>", " noapic<wait>", " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kali/preseed.cfg auto=true priority=critical", " -- <wait>", "<enter><wait>"]
  boot_wait        = "10s"
  disk_size        = 81920
  guest_os_type    = "debian8-64"
  headless         = false
  http_directory   = "../http"
  iso_checksum     = "sha256:265812bc13ab11d40c610424871bdf9198b9e7cad99b06540d96fac67dd704de"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  output_directory = "output-vmware-iso"
  shutdown_command = "echo 'kali'|sudo -S shutdown -P now"
  ssh_password     = "kali"
  ssh_port         = 22
  ssh_timeout      = "8000s"
  ssh_username     = "kali"
  vm_name          = "packer-kali-rolling-amd64"
  vmx_data = {
    "cpuid.coresPerSocket"    = "1"
    "ethernet0.pciSlotNumber" = "32"
    memsize                   = "4096"
    numvcpus                  = "1"
  }
}

build {
  sources = ["source.virtualbox-iso.kali_vbox", "source.vmware-iso.kali_vmware"]
  /*  
  provisioner "shell" {
    execute_command = "echo 'kali' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    only            = ["virtualbox-iso"]
    script          = "packer-scripts/virtualbox-guest-additions.sh"
  }

  provisioner "shell" {
    execute_command = "echo 'kali' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    only            = ["vmware-iso"]
    script          = "packer-scripts/vmware-tools.sh"
  }

  provisioner "shell" {
    execute_command = "echo 'kali' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "packer-scripts/ansible.sh"
  }

  provisioner "shell" {
    execute_command = "echo 'kali' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "packer-scripts/setup.sh"
  }

  provisioner "ansible-local" {
    command           = "PYTHONUNBUFFERED=1 ANSIBLE_PYTHON_INTERPRETER=/usr/bin/python3 ANSIBLE_ROLES_PATH=\"/tmp/ansible-roles/roles:/home/kali/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/tmp/ansible-roles:/tmp/ansible-roles/roles/roles\" ansible-playbook"
    playbook_file     = "./playbook.yml"
    role_paths        = ["./ansible-collection-dev/roles/", "./ansible-collection-security/roles/"]
    staging_directory = "/tmp/ansible-roles/"
  }

  provisioner "shell" {
    execute_command = "echo 'kali' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "packer-scripts/cleanup.sh"
  }
  */
}
