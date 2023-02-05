boot_command = [
  "<esc><esc><esc><esc>e<wait>",
  "<del><del><del><del><del><del><del><del>",
  "<del><del><del><del><del><del><del><del>",
  "<del><del><del><del><del><del><del><del>",
  "<del><del><del><del><del><del><del><del>",
  "<del><del><del><del><del><del><del><del>",
  "<del><del><del><del><del><del><del><del>",
  "<del><del><del><del><del><del><del><del>",
  "<del><del><del><del><del><del><del><del>",
  "<del><del><del><del><del><del><del><del>",
  "<del><del><del><del><del><del><del><del>",
  "<del><del><del><del><del><del><del><del>",
  "<del><del><del><del><del><del><del><del>",
  "<del><del><del><del><del><del><del><del>",
  "<del><del><del><del><del><del><del><del>",
  "linux /casper/vmlinuz --- autoinstall ds=\"nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/\"<enter><wait>",
  "initrd /casper/initrd<enter><wait>",
  "boot<enter>",
  "<enter><f10><wait>"
]
boot_wait            = "10s"
box_basename         = "ubuntu-22.04"
build_directory      = "../../builds"
cpus                 = "2"
disk_size            = "65536"
git_revision         = "__unknown_git_revision__"
guest_additions_url  = ""
guest_os_type_vmware = "ubuntu-64"
headless             = "false"
http_directory       = "../http/Ubuntu/22.04"
iso_checksum         = "10f19c5b2b8d6db711582e0e27f5116296c34fe4b313ba45f9b201a5007056cb"
iso_name             = "ubuntu-22.04.1-live-server-amd64.iso"
iso_url              = "https://releases.ubuntu.com/22.04.1/ubuntu-22.04.1-live-server-amd64.iso"
memory               = "1024"
mirror_directory     = "jammy"
name                 = "ubuntu-22.04"
ssh_password         = "vagrant"
ssh_timeout          = "10000s"
ssh_username         = "vagrant"
template             = "ubuntu-22.04-amd64"
version              = "TIMESTAMP"