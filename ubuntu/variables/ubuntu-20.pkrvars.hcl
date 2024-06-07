boot_command=["<esc><wait500>","linux /casper/vmlinuz quiet autoinstall net.ifnames=0 biosdevname=0 ip=dhcp ipv6.disable=1 ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ <enter>","initrd /casper/initrd <enter>","boot <enter>"]
boot_command_vbox            = [" <wait>", " <wait>", " <wait>", " <wait>", " <wait>", "<esc><wait>", "<f6><wait>", "<esc><wait>", "<bs><bs><bs><bs><wait>", " autoinstall<wait5>", " ds=nocloud-net<wait5>", ";s=http://<wait5>{{ .HTTPIP }}<wait5>:{{ .HTTPPort }}/<wait5>", " ---<wait5>", "<enter><wait5>"]
disk_additional_size=["150000"]
disk_size="70000"
http_directory="./http/22.04"
guest_os_type_vbox   = "Ubuntu_64"
guest_os_type_vmware = "ubuntu-64"
iso_checksum="b8f31413336b9393ad5d8ef0282717b2ab19f007df2e9ed5196c13d8f9153c8b"
iso_url="https://releases.ubuntu.com/focal/ubuntu-20.04.6-live-server-amd64.iso"
non_gui = "false"
#output_vagrant="./vbox/packer-ubuntu2004-g2.box"
ssh_password="password"
ssh_username="ubuntu"
switch_name="Default Switch"
#vagrantfile_template="./vagrant/hv_ubuntu2004_g2.template"
vlan_id=""
vm_name="packer-ubuntu2004-g2"