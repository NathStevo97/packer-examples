boot_command             = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-9-stream.cfg<leftCtrlOn>x<leftCtrlOff>"]
boot_wait                = "5s"
disk_size                = "40960"
guest_os_type_virtualbox = "RedHat_64"
guest_os_type_vmware     = "centos-64"
headless                 = false
http_directory           = "./http"
iso_checksum             = "e16bc20fe7bfb6c768e2492842a5ec8b183ade5ee0dc41aaa5692a516e1e9cb7"
iso_path                 = "../../ISOs/CentOS/CentOS-Stream-9-latest-x86_64-dvd1.iso"
iso_url                  = "https://mirrors.centos.org/mirrorlist?path=/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-dvd1.iso&redirect=1&protocol=https"
# https://mirror.transip.net/centos-stream/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-20240307.0-x86_64-boot.iso
memsize      = "4096"
numvcpus     = "2"
ssh_password = "vagrant"
ssh_timeout  = "2h"
ssh_username = "vagrant"
vm_name      = "centos-stream-9-x86_64"