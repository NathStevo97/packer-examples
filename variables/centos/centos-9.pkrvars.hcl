boot_command = [
  "e<down><down><end><bs><bs><bs><bs><bs>inst.text rd.live.check=0 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos/ks-9-stream.cfg<leftCtrlOn>x<leftCtrlOff>"
]
boot_command_qemu    = ["<tab> inst.text rd.live.check=0 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos/ks-9-stream.cfg<enter>"]
boot_wait            = "5s"
cpus                 = "2"
disk_size            = "40960"
guest_os_type_vmware = "centos-64"
headless             = false
http_directory       = "./templates/http"
http_port_min        = "9000"
http_port_max        = "9000"
iso_path             = "https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-20260127.1-x86_64-boot.iso"
iso_url              = "https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-20260127.1-x86_64-boot.iso"
iso_checksum         = "c23f8851fdf924761a80443e4cd347b119d15f76602ae957fe20a566ee650d18"
memory               = "4096"
ssh_password         = "vagrant"
ssh_timeout          = "2h"
ssh_username         = "vagrant"
vm_name              = "centos-stream-9-x86_64"

#
# Deprecated Vars
#

# boot_command_hyperv = [
#   "e<down><down><end><bs><bs><bs><bs><bs>inst.text rd.live.check=0 inst.repo=https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/ inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos/ks-9-stream.cfg<leftCtrlOn>x<leftCtrlOff>"
# ]
# guest_os_type_virtualbox = "RedHat_64"
# switch_name              = "Default Switch"
# vlan_id                  = ""
