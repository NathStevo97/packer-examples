boot_wait            = "10s"
boot_command         = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text rd.live.check=0 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux/almalinux9-kickstart.cfg<leftCtrlOn>x<leftCtrlOff>"]
boot_command_hyperv  = ["c  setparams 'kickstart' <enter> linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=AlmaLinux-9-5-x86_64-dvd inst.repo=https://repo.almalinux.org/almalinux/9/BaseOS/x86_64/os/ rd.live.check=0 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux/almalinux9-kickstart.cfg<enter> initrdefi /images/pxeboot/initrd.img<enter> boot<enter>"]
cpu                  = "2"
disk_size            = "70000"
guest_os_type_vmware = "centos-64"
guest_os_type_vbox   = "RedHat_64"
headless             = false
http_directory       = "./templates/http/"
iso_checksum         = "sha256:3038fb71a29d33c3c93117bd8f4c3f612cb152dce057c666b6b11dfa793fb65c"
iso_url              = "https://repo.almalinux.org/almalinux/9.5/isos/x86_64/AlmaLinux-9.5-x86_64-boot.iso"
name                 = "almalinux-9"
ram                  = "4096"
ssh_password         = "vagrant"
ssh_username         = "vagrant"
switch_name          = "Default Switch"
vlan_id              = ""
version              = "9"