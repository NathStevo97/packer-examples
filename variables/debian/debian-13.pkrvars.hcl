boot_wait = "10s"
boot_command = [
  "<wait>e<wait><down><down><down><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><wait>install <wait>",
  "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/debian/13/preseed.cfg <wait>",
  "debian-installer=en_US.UTF-8 <wait>",
  "auto <wait>locale=en_US.UTF-8 <wait>",
  "kbd-chooser/method=us <wait>",
  "keyboard-configuration/xkb-keymap=us <wait>",
  "netcfg/get_hostname={{ .Name }} <wait>",
  "netcfg/get_domain=vagrantup.com <wait>fb=false <wait>",
  "debconf/frontend=noninteractive <wait>",
  "console-setup/ask_detect=false <wait>",
  "console-keymaps-at/keymap=us<wait>",
  "grub-installer/bootdev=default<wait>",
  "<f10><wait>"
]
boot_command_hyperv = [
  "e<down><down><down><end> ",
  "auto=true priority=critical url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/debian/13/preseed.cfg <wait1m><f10>"
]
cpu                  = "4"
disk_size            = "70000"
guest_os_type_vmware = "debian-64"
guest_os_type_vbox   = "Debian_64"
http_directory       = "./templates/http"
http_port_min        = "9000"
http_port_max        = "9000"
headless             = false
iso_checksum         = "file:https://ftp.debian.org/debian/dists/trixie/main/installer-amd64/current/images/SHA256SUMS"
iso_url              = "https://ftp.debian.org/debian/dists/trixie/main/installer-amd64/current/images/netboot/mini.iso"
name                 = "debian-13"
ram                  = "4096"
ssh_password         = "packer"
ssh_username         = "packer"
switch_name          = "Default Switch"
vlan_id              = ""
