boot_command = [
  "<wait>c<wait>",
  "set gfxpayload=keep<enter><wait>",
  # "linux /casper/vmlinuz autoinstall quiet ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/' ---<enter><wait>",
  "linux /casper/vmlinuz autoinstall ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/' ---<enter><wait>",
  "initrd /casper/initrd<wait><enter><wait>",
  "boot<enter><wait>"
]
boot_wait          = "5s"
cpu                = 2
disk_size          = 70000
guest_os_type_vbox = "Ubuntu_64"
http_directory     = "./http"
iso_checksum       = "file:https://releases.ubuntu.com/jammy/SHA256SUMS"
iso_url            = "http://releases.ubuntu.com/22.04/ubuntu-22.04.2-live-server-amd64.iso"
memory             = 4096
vm_name            = "ubuntu-22.04.2-amd"
non_gui            = "true"
ssh_password       = "vagrant"
ssh_username       = "vagrant"
