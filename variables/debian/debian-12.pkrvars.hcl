boot_wait            = "10s"
boot_command         = ["e<down><down><down><end> ", "auto=true priority=critical url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/debian/12/preseed.cfg<f10>"]
cpu                  = "4"
disk_size            = "70000"
guest_os_type_vmware = "debian-64"
guest_os_type_vbox   = "Debian_64"
http_directory       = "./templates/http"
headless             = false
iso_checksum         = "1c8f5ee61b0bc1da1ee2e32cf9c60f4c381523a468b0ae82170a17592979a783"
iso_url              = "https://ftp.debian.org/debian/dists/bookworm/main/installer-amd64/current/images/netboot/mini.iso"
name                 = "debian-12"
ram                  = "4096"
ssh_password         = "packer"
ssh_username         = "packer"