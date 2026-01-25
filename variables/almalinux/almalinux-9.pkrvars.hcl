boot_wait            = "30s"
boot_command         = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text rd.live.check=0 inst.waitfornetwork=10 inst.ks.retry=20 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux/almalinux9-kickstart.cfg<leftCtrlOn>x<leftCtrlOff>"]
boot_command_hyperv  = ["c  setparams 'kickstart' <enter> linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=AlmaLinux-9-7-x86_64-dvd inst.repo=https://repo.almalinux.org/almalinux/9/BaseOS/x86_64/os/ rd.live.check=0 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux/almalinux9-kickstart.cfg<enter> initrdefi /images/pxeboot/initrd.img<enter> boot<enter>"]
boot_command_qemu    = ["<tab> inst.text rd.live.check=0 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux/almalinux9-kickstart.cfg<enter>"]
cpu                  = "2"
disk_size            = "70000"
guest_os_type_vmware = "centos-64"
guest_os_type_vbox   = "RedHat_64"
headless             = false
http_directory       = "./templates/http/"
http_port_min        = "8000"
http_port_max        = "8000"
iso_checksum         = "sha256:d51ed22cf272a0f30fcf55579d2748ff6ee1fddd6e36ba728cb386b933ceb7fc"
iso_url              = "https://repo.almalinux.org/almalinux/9/isos/x86_64/AlmaLinux-9.7-x86_64-minimal.iso"
name                 = "almalinux-9"
ram                  = "4096"
ssh_password         = "vagrant"
ssh_username         = "vagrant"
switch_name          = "Default Switch"
vlan_id              = ""
version              = "9"
