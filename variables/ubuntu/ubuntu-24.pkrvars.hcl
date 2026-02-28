boot_command         = ["<wait20>c<wait20>", "linux /casper/vmlinuz quiet autoinstall net.ifnames=0 biosdevname=0 ip=dhcp ipv6.disable=1 ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ <enter>", "initrd /casper/initrd <enter>", "boot <enter>"]
boot_wait            = "1s"
disk_additional_size = ["150000"]
disk_size            = "70000"
http_directory       = "./templates/http/ubuntu/24.04"
guest_os_type_vbox   = "Ubuntu_64"
guest_os_type_vmware = "ubuntu-64"
iso_checksum         = "c3514bf0056180d09376462a7a1b4f213c1d6e8ea67fae5c25099c6fd3d8274b"
iso_url              = "https://releases.ubuntu.com/noble/ubuntu-24.04.3-live-server-amd64.iso"
ssh_password         = "ubuntu"
ssh_username         = "ubuntu"
switch_name          = "Default Switch"
vlan_id              = ""
vm_name              = "packer-ubuntu2404-g2"
memory               = "2048"
cpu                  = "2"
headless             = false
