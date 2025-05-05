boot_command             = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-9-stream.cfg<leftCtrlOn>x<leftCtrlOff>"]
boot_command_hyperv      = ["c  setparams 'kickstart' <enter> linuxefi /images/pxeboot/vmlinuz inst.repo=http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/ inst.addrepo= inst.stage2=hd:LABEL=CentOS-9-x86_64-dvd inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-9-stream.cfg<enter> initrdefi /images/pxeboot/initrd.img<enter> boot<enter>"]
boot_wait                = "5s"
disk_size                = "40960"
guest_os_type_virtualbox = "RedHat_64"
guest_os_type_vmware     = "centos-64"
headless                 = false
http_directory           = "./http"
#iso_checksum             = "e16bc20fe7bfb6c768e2492842a5ec8b183ade5ee0dc41aaa5692a516e1e9cb7"
#iso_path                 = "../../ISOs/CentOS/CentOS-Stream-9-latest-x86_64-dvd1.iso"
#iso_url                  = "https://mirrors.centos.org/mirrorlist?path=/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-dvd1.iso&redirect=1&protocol=https"
# https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-20240703.1-x86_64-boot.iso
iso_checksum = "d244b592e56653f92e2a38acd831e289f96552a6f08555f5e8214117bbd4aa1d"
iso_path     = "https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-20240708.1-x86_64-boot.iso"
iso_url      = "../../ISOs/CentOS/CentOS-Stream-9-20240708.1-x86_64-boot.iso"
memsize      = "4096"
numvcpus     = "2"
ssh_password = "vagrant"
ssh_timeout  = "2h"
ssh_username = "vagrant"
switch_name  = "Default Switch"
vlan_id      = ""
vm_name      = "centos-stream-9-x86_64"