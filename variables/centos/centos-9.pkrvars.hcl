boot_command = [
  "e<down><down><end><bs><bs><bs><bs><bs>inst.text rd.live.check=0 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos/ks-9-stream.cfg<leftCtrlOn>x<leftCtrlOff>"
]
boot_command_hyperv = [
  "e<down><down><end><bs><bs><bs><bs><bs>inst.text rd.live.check=0 inst.repo=https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/ inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos/ks-9-stream.cfg<leftCtrlOn>x<leftCtrlOff>"
]
boot_wait                = "5s"
disk_size                = "40960"
guest_os_type_virtualbox = "RedHat_64"
guest_os_type_vmware     = "centos-64"
headless                 = false
http_directory           = "./templates/http"
iso_path                 = "https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-20250512.0-x86_64-boot.iso"
iso_url                  = "https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-boot.iso"
iso_checksum             = "ea4ab5be784fe8ca1512be19a4eb90eb830266e18d35a899bdd91ef548205349"
memsize                  = "4096"
numvcpus                 = "2"
ssh_password             = "vagrant"
ssh_timeout              = "2h"
ssh_username             = "vagrant"
switch_name              = "Default Switch"
vlan_id                  = ""
vm_name                  = "centos-stream-9-x86_64"