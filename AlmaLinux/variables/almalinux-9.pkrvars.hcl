boot_wait            = "10s"
boot_command         = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux9-kickstart.cfg<leftCtrlOn>x<leftCtrlOff>"]
boot_command_hyperv         = ["c  setparams 'kickstart' <enter> linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=AlmaLinux-9-4-x86_64-dvd inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux9-kickstart.cfg<enter> initrdefi /images/pxeboot/initrd.img<enter> boot<enter>"]
cpu                  = "2"
disk_size            = "70000"
guest_os_type_vmware = "centos-64"
guest_os_type_vbox   = "RedHat_64"
headless             = false
http_directory       = "./http"
iso_checksum         = "sha256:1e5d7da3d84d5d9a5a1177858a5df21b868390bfccf7f0f419b1e59acc293160"
iso_url              = "https://repo.almalinux.org/almalinux/9.4/isos/x86_64/AlmaLinux-9.4-x86_64-boot.iso"
name                 = "almalinux-9"
ram                  = "4096"
ssh_password         = "vagrant"
ssh_username         = "vagrant"
switch_name          = "Default Switch"
vlan_id              = ""
version              = "9"