boot_command = [
  "<tab><wait30s> inst.text rd.live.check=0 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-9.cfg inst.repo=https://yum.oracle.com/repo/OracleLinux/OL9/baseos/latest/x86_64/ <enter><wait>"
]
boot_command_hv = [
  "c  setparams 'kickstart' <enter> rd.live.check=0 linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=OL-9-7-0-BaseOS-x86_64 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-9.cfg<enter> initrdefi /images/pxeboot/initrd.img<enter> boot<enter>"
]
boot_wait            = "5s"
box_basename         = "oracle-9.7"
build_directory      = "./builds"
cpus                 = "2"
disk_size            = "65536"
guest_os_type_vmware = "oraclelinux-64"
headless             = false
http_directory       = "./templates/http/oracle"
hyperv_generation    = "1"
hyperv_switch        = "default"
iso_checksum         = "8b756a95da40d70fabb784fb7d5484494720e97cccf9b5bdc51aed184bedc099"
iso_path             = "../../ISOs/Oracle/OracleLinux-R9-U7-x86_64-boot.iso"
iso_url              = "https://yum.oracle.com/ISOS/OracleLinux/OL9/u7/x86_64/OracleLinux-R9-U7-x86_64-boot.iso"
memory               = "2048"
name                 = "oracle-9.7"
ssh_password         = "vagrant"
ssh_timeout          = "10000s"
ssh_username         = "vagrant"
switch_name          = "Default Switch"
vlan_id              = ""
template             = "oracle-9.7-x86_64"
version              = "TIMESTAMP"
