
boot_command=["<wait3>c<wait3>","linux /casper/vmlinuz quiet autoinstall net.ifnames=0 biosdevname=0 ip=dhcp ipv6.disable=1 ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ <enter>","initrd /casper/initrd <enter>","boot <enter>"]
disk_additional_size=["150000"]
disk_size="70000"
http_directory="./http/24.04"
guest_os_type_vbox   = "Ubuntu_64"
guest_os_type_vmware = "ubuntu-64"
iso_checksum="8762f7e74e4d64d72fceb5f70682e6b069932deedb4949c6975d0f0fe0a91be3"
iso_url="https://mirroronet.pl/pub/mirrors/ubuntu-releases/24.04/ubuntu-24.04-live-server-amd64.iso"
ssh_password="password"
ssh_username="ubuntu"
switch_name="Default Switch"
vlan_id=""
vm_name="packer-ubuntu2404-g2"
memory = "2048"
cpu = "4"
