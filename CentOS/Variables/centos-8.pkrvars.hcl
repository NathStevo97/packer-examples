boot_command             = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text <wait10s> inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-8-stream.cfg <wait10s> <leftCtrlOn>x<leftCtrlOff>"]
boot_wait                = "5s"
disk_size                = "40960"
guest_os_type_virtualbox = "RedHat_64"
guest_os_type_vmware     = "centos-64"
headless                 = "true"
http_directory           = "./http/"
iso_checksum             = "8891c13744e0f4251ebd5b5f20be11c93db65e047aaa65b57dfc97de37420b0e"
iso_path                 = "../../ISOs/CentOS/CentOS-Stream-8-x86_64-latest-dvd1.iso"
iso_path                 = ""
iso_url                  = "https://mirrors.edge.kernel.org/centos/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-latest-dvd1.iso"
# https://mirrors.edge.kernel.org/centos/8-stream/isos/x86_64/CentOS-Stream-8-20240304.0-x86_64-boot.iso
memsize                  = "1024"
numvcpus                 = "2"
ssh_password             = "vagrant"
ssh_timeout              = "2h"
ssh_username             = "vagrant"
vm_name                  = "centos-stream-8-x86_64"
https://github.com/eaksel/packer-CentOS8/blob/master/http/ks.cfg