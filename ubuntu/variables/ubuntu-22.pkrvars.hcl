boot_command         = ["<wait20>c<wait20>", "linux <wait> /casper/vmlinuz quiet <wait> autoinstall net.ifnames=0 biosdevname=0 ip=dhcp ipv6.disable=1 <wait> ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ <enter>", "initrd /casper/initrd <enter>", "boot <enter>"]
boot_wait           = "1s"
disk_additional_size = ["150000"]
disk_size            = "70000"
http_directory       = "./http/22.04"
guest_os_type_vbox   = "Ubuntu_64"
guest_os_type_vmware = "ubuntu-64"
iso_checksum         = "a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"
iso_url              = "https://releases.ubuntu.com/jammy/ubuntu-22.04.3-live-server-amd64.iso"
headless              = false
#output_vagrant="./vbox/packer-ubuntu2204-g2.box"
ssh_password = "password"
ssh_username = "ubuntu"
switch_name  = "Default Switch"
#vagrantfile_template="./vagrant/hv_ubuntu2204_g2.template"
vlan_id = ""
vm_name = "packer-ubuntu2204-g2"