boot_command         = [
    "<wait3>c<wait3>",
    "linux /casper/vmlinuz quiet autoinstall net.ifnames=0 biosdevname=0 ip=dhcp ipv6.disable=1 ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ <enter>",
    "initrd /casper/initrd <enter>",
    "boot <enter>"
    ]
boot_wait            = "5s"
cpu                  = 2
disk_size            = 70000
disk_additional_size = ["150000"]
guest_os_type_vbox   = "Ubuntu_64"
guest_os_type_vmware = "ubuntu-64"
http_directory       = "./http"
iso_checksum         = "a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"
iso_url              = "https://releases.ubuntu.com/jammy/ubuntu-22.04.3-live-server-amd64.iso"
memory               = 4096
vm_name              = "ubuntu-22.04.3-amd"
non_gui              = "false"
ssh_password         = "password"
ssh_username         = "ubuntu"
switch_name          = "Default Switch"
vlan_id              = ""
