boot_wait            = "10s"
boot_command         = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux9-kickstart.cfg<leftCtrlOn>x<leftCtrlOff>"]
cpu                  = "2"
disk_size            = "70000"
guest_os_type_vmware = "centos-64"
guest_os_type_vbox   = "RedHat_64"
headless             = "false"
http_directory       = "./http"
iso_checksum         = "sha256:f501de55f92e59a3fcf4ad252fdfc4e02ee2ad013d2e1ec818bb38052bcb3c32"
iso_url              = "https://repo.almalinux.org/almalinux/9.2/isos/x86_64/AlmaLinux-9.2-x86_64-boot.iso"
name                 = "almalinux-9"
ram                  = "4096"
ssh_password         = "vagrant"
ssh_username         = "vagrant"
version              = "9"