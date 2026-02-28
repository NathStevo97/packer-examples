boot_command         = ["<wait20>c<wait20>", "linux <wait> /casper/vmlinuz quiet <wait> autoinstall net.ifnames=0 biosdevname=0 ip=dhcp ipv6.disable=1 <wait> ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ <enter>", "initrd /casper/initrd <enter>", "boot <enter>"]
boot_wait            = "1s"
disk_additional_size = ["150000"]
disk_size            = "70000"
http_directory       = "./templates/http/ubuntu/22.04"
guest_os_type_vbox   = "Ubuntu_64"
guest_os_type_vmware = "ubuntu-64"
iso_checksum         = "9bc6028870aef3f74f4e16b900008179e78b130e6b0b9a140635434a46aa98b0"
iso_url              = "https://releases.ubuntu.com/jammy/ubuntu-22.04.5-live-server-amd64.iso"
headless             = false
#output_vagrant="./vbox/packer-ubuntu2204-g2.box"
ssh_password = "ubuntu"
ssh_username = "ubuntu"
switch_name  = "Default Switch"
#vagrantfile_template="./vagrant/hv_ubuntu2204_g2.template"
vlan_id = ""
vm_name = "packer-ubuntu2204-g2"
