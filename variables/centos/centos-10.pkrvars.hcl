boot_command = [
  "e<down><down><end><bs><bs><bs><bs><bs>inst.text rd.live.check=0 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos/ks-10-stream.cfg<leftCtrlOn>x<leftCtrlOff>"
]
boot_command_hyperv = [
  "e<down><down><end><bs><bs><bs><bs><bs>inst.text rd.live.check=0 inst.repo=https://mirror.stream.centos.org/10-stream/BaseOS/x86_64/os/ inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos/ks-10-stream.cfg<leftCtrlOn>x<leftCtrlOff>"
]
boot_command_qemu = [
  "e<down><down><end><bs><bs><bs><bs><bs>inst.text rd.live.check=0 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos/ks-10-stream.cfg<leftCtrlOn>x<leftCtrlOff>"
]
boot_wait                = "5s"
disk_size                = "40960"
guest_os_type_virtualbox = "RedHat_64"
guest_os_type_vmware     = "centos-64"
headless                 = false
http_directory           = "./templates/http"
http_port_min            = "9000"
http_port_max            = "9000"
iso_path                 = "https://mirror.stream.centos.org/10-stream/BaseOS/x86_64/iso/CentOS-Stream-10-20260202.0-x86_64-boot.iso"
iso_url                  = "https://mirror.stream.centos.org/10-stream/BaseOS/x86_64/iso/CentOS-Stream-10-20260202.0-x86_64-boot.iso"
iso_checksum             = "file:https://mirror.stream.centos.org/10-stream/BaseOS/x86_64/iso/CentOS-Stream-10-20260202.0-x86_64-boot.iso.SHA256SUM"
memsize                  = "4096"
numvcpus                 = "2"
ssh_password             = "vagrant"
ssh_timeout              = "2h"
ssh_username             = "vagrant"
switch_name              = "Default Switch"
vlan_id                  = ""
vm_name                  = "centos-stream-10-x86_64"
