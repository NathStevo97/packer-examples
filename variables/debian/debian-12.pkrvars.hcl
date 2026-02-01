boot_wait           = "10s"
boot_command        = ["e<down><down><down><end> ", "auto=true priority=critical url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/debian/12/preseed.cfg<wait1m><f10>"]
boot_command_hyperv = ["e<down><down><down><end> ", "auto=true priority=critical url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/debian/12/preseed.cfg <wait1m><f10>"]
boot_command_qemu = [
  "<esc><wait>",
  "auto <wait>",
  "console-keymaps-at/keymap=us <wait>",
  "console-setup/ask_detect=false <wait>",
  "debconf/frontend=noninteractive <wait>",
  "debian-installer=en_US <wait>",
  "fb=false <wait>",
  "install <wait>",
  "kbd-chooser/method=us <wait>",
  "keyboard-configuration/xkb-keymap=us <wait>",
  "locale=en_US <wait>",
  "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/debian/12/preseed.cfg <wait>",
  "<enter><wait>"
]
cpu                  = "4"
disk_size            = "70000"
guest_os_type_vmware = "debian-64"
guest_os_type_vbox   = "Debian_64"
http_directory       = "./templates/http"
http_port_min        = "9000"
http_port_max        = "9000"
headless             = false
iso_checksum         = "1c8f5ee61b0bc1da1ee2e32cf9c60f4c381523a468b0ae82170a17592979a783"
iso_url              = "https://ftp.debian.org/debian/dists/bookworm/main/installer-amd64/current/images/netboot/mini.iso"
name                 = "debian-12"
ram                  = "4096"
ssh_password         = "packer"
ssh_username         = "packer"
switch_name          = "Default Switch"
vlan_id              = ""
