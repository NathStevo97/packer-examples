boot_command      = ["<tab><wait1m> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-8.cfg net.ifnames=0 biosdevname=0 <enter><wait>"]
boot_command_hv   = ["c  setparams 'kickstart' <enter> linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=OL-8-9-0-BaseOS-x86_64 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-8.cfg<enter> initrdefi /images/pxeboot/initrd.img<enter> boot<enter>"]
boot_wait         = "5s"
box_basename      = "oracle-8.9"
build_directory   = "./builds"
cpus              = "2"
disk_size         = "65536"
headless          = false
http_directory    = "./templates/http/oracle/8"
hyperv_generation = "1"
iso_checksum      = "ce90b598be2e9889fa880128fc53b3e9c1f95d9e31859759e5e180602312c181"
iso_path          = "../../ISOs/Oracle/OracleLinux-R8-U9-x86_64-dvd.iso"
iso_url           = "https://yum.oracle.com/ISOS/OracleLinux/OL8/u9/x86_64/OracleLinux-R8-U9-x86_64-dvd.iso"
memory            = "1024"
name              = "oracle-8.9"
ssh_password      = "vagrant"
ssh_timeout       = "10000s"
ssh_username      = "vagrant"
switch_name       = "Default Switch"
template          = "oracle-8.9-x86_64"
version           = "TIMESTAMP"
vlan_id           = ""
