variable "boot_wait" {
  type    = string
  default = ""
}

variable "build_directory" {
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

variable "headless" {
  type    = bool
  default = "false"
}

variable "guest_os_type_vmware" {
  type    = string
  default = ""
}

variable "guest_os_type_virtualbox" {
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

variable "memory" {
  type    = string
  default = ""
}

variable "name" {
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

source "virtualbox-iso" "kali_vbox" {
  boot_command            = ["<esc><wait2m>", "/install.amd/vmlinuz<wait>", " auto<wait>", " console-setup/ask_detect=false<wait>", " console-setup/layoutcode=us<wait>", " console-setup/modelcode=pc105<wait>", " debconf/frontend=noninteractive<wait>", " debian-installer=en_US<wait>", " fb=false<wait>", " initrd=/install.amd/initrd.gz<wait>", " kbd-chooser/method=us<wait>", " netcfg/choose_interface=eth0<wait>", " console-keymaps-at/keymap=us<wait>", " keyboard-configuration/xkb-keymap=us<wait>", " keyboard-configuration/layout=USA<wait>", " keyboard-configuration/variant=USA<wait>", " locale=en_US<wait>", " netcfg/get_domain=vm<wait>", " netcfg/get_hostname=kali<wait>", " grub-installer/bootdev=/dev/sda<wait>", " noapic<wait>", " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kali/preseed.cfg auto=true priority=critical", " -- <wait2m>", "<enter>"]
  /*  
  boot_command = ["<esc><wait>",
        "/install.amd/vmlinuz<wait>",
        " auto<wait>",
        " console-setup/ask_detect=false<wait>",
        " console-setup/layoutcode=us<wait>",
        " console-setup/modelcode=pc105<wait>",
        " debconf/frontend=noninteractive<wait>",
        " debian-installer=en_US<wait>",
        " fb=false<wait>",
        " initrd=/install.amd/initrd.gz<wait>",
        " kbd-chooser/method=us<wait>",
        " netcfg/choose_interface=eth0<wait>",
        " console-keymaps-at/keymap=us<wait>",
        " keyboard-configuration/xkb-keymap=us<wait>",
        " keyboard-configuration/layout=USA<wait>",
        " keyboard-configuration/variant=USA<wait>",
        " locale=en_US<wait>",
        " netcfg/get_domain=vm<wait>",
        " netcfg/get_hostname=kali<wait>",
        " grub-installer/bootdev=/dev/sda<wait>",
        " noapic<wait>",
        " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg auto=true priority=critical",
        " -- <wait>",
        "<enter><wait>"]
  
  boot_command = ["<esc><wait2m>",
    "install <wait>",
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kali/preseed.cfg ",
    "locale=en_US ",
    "keymap=us ",
    "hostname=kali ",
    "domain='' ",
    "<enter>"
  ]
  */
  boot_wait               = "${var.boot_wait}"
  disk_size               = "${var.disk_size}"
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "${var.guest_os_type_virtualbox}"
  headless                = "${var.headless}"
  http_directory          = "${var.http_directory}"
  iso_checksum            = "${var.iso_checksum}"
  iso_urls                = ["${var.iso_path}", "${var.iso_url}"]
  output_directory        = "${var.build_directory}/${var.name}-virtualbox"
  shutdown_command        = "echo 'kali'|sudo -S shutdown -P now"
  ssh_password            = "${var.ssh_password}"
  ssh_port                = 22
  ssh_timeout             = "${var.ssh_timeout}"
  ssh_username            = "${var.ssh_username}"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "${var.memory}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.cpus}"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "${var.name}"
}

source "vmware-iso" "kali_vmware" {
  #boot_command     = ["<esc><wait2m>", "/install.amd/vmlinuz<wait>", " auto<wait>", " console-setup/ask_detect=false<wait>", " console-setup/layoutcode=us<wait>", " console-setup/modelcode=pc105<wait>", " debconf/frontend=noninteractive<wait>", " debian-installer=en_US<wait>", " fb=false<wait>", " initrd=/install.amd/initrd.gz<wait>", " kbd-chooser/method=us<wait>", " netcfg/choose_interface=eth0<wait>", " console-keymaps-at/keymap=us<wait>", " keyboard-configuration/xkb-keymap=us<wait>", " keyboard-configuration/layout=USA<wait>", " keyboard-configuration/variant=USA<wait>", " locale=en_US<wait>", " netcfg/get_domain=vm<wait>", " netcfg/get_hostname=kali<wait>", " grub-installer/bootdev=/dev/sda<wait>", " noapic<wait>", " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kali/preseed.cfg auto=true priority=critical", " -- <wait2m>", "<enter><wait>"]
  boot_command = [ "<esc><wait>",
        "install <wait>",
        " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kali/preseed-test-elrey.cfg <wait>",
        "debian-installer=en_US.UTF-8 <wait>",
        "auto <wait>",
        "locale=en_US.UTF-8 <wait>",
        "kbd-chooser/method=us <wait>",
        "keyboard-configuration/xkb-keymap=us <wait>",
        "netcfg/get_hostname=kali <wait>",
        "netcfg/get_domain=vagrantup.com <wait>",
        "fb=false <wait>",
        "debconf/frontend=noninteractive <wait>",
        "console-setup/ask_detect=false <wait>",
        "console-keymaps-at/keymap=us <wait>",
        "grub-installer/bootdev=/dev/sda <wait>",
        "<enter><wait>"
  ]
  boot_wait        = "${var.boot_wait}"
  cpus             = "${var.cpus}"
  cores            = "2"
  disk_size        = "${var.disk_size}"
  guest_os_type    = "${var.guest_os_type_vmware}"
  headless         = "${var.headless}"
  http_directory   = "${var.http_directory}"
  iso_checksum     = "${var.iso_checksum}"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  network          = "nat"
  memory           = "${var.memory}"
  output_directory = "${var.build_directory}/${var.name}-vmware"
  shutdown_command = "echo 'kali'|sudo -S shutdown -P now"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "${var.ssh_timeout}"
  ssh_username     = "${var.ssh_username}"
  vm_name          = "${var.name}"
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
