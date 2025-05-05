boot_command             = ["<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-7.cfg<enter><wait>"]
boot_wait                = "10s"
boot_wait_virtualbox     = "45s"
box_basename             = "rhel-7.9"
build_directory          = "../builds"
numvcpus                 = "2"
disk_size                = "65536"
guest_os_type_virtualbox = "RedHat_64"
guest_os_type_vmware     = "rhel7-64"
headless                 = false
http_directory           = "./http"
hyperv_generation        = "1"
hyperv_switch            = "default"
iso_checksum             = "2cb36122a74be084c551bc7173d2d38a1cfb75c8ffbc1489c630c916d1b31b25"
iso_path                 = "../../ISOs/RHEL/rhel-server-7.9-x86_64-dvd.iso"
iso_url                  = "https://archive.org/download/rhel-server-7.9-x86_64-dvd/rhel-server-7.9-x86_64-dvd.iso"
# https://access.cdn.redhat.com/content/origin/files/sha256/2c/2cb36122a74be084c551bc7173d2d38a1cfb75c8ffbc1489c630c916d1b31b25/rhel-server-7.9-x86_64-dvd.iso
memsize      = 2048
ssh_password = "vagrant"
ssh_timeout  = "10000s"
ssh_username = "vagrant"
vm_name      = "rhel-7.9-x86_64"
