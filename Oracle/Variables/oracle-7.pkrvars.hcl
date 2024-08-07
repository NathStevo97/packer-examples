boot_command      = ["<up><wait2m><tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-7.cfg fsck.mode=skip net.ifnames=0 biosdevname=0 <enter><wait>"]
boot_wait         = "5s"
box_basename      = "oracle-7.9"
build_directory   = "../builds"
cpus              = "2"
disk_size         = "65536"
headless          = false
http_directory    = "./http"
hyperv_generation = "1"
hyperv_switch     = "default"
iso_checksum      = "975a9b6530f3a3b6b485ca022ce0d7f4"
iso_path          = "../../ISOs/Oracle/OracleLinux-R7-U9-Server-x86_64-dvd.iso"
iso_url           = "https://yum.oracle.com/ISOS/OracleLinux/OL7/u9/x86_64/OracleLinux-R7-U9-Server-x86_64-dvd.iso"
memory            = "1024"
name              = "oracle-7.9"
ssh_password      = "vagrant"
ssh_timeout       = "10000s"
ssh_username      = "vagrant"
template          = "oracle-7.9-x86_64"
version           = "TIMESTAMP"
