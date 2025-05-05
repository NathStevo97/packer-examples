boot_command         = ["<wait><up>e<wait><down><down><end> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-40.cfg<F10><wait>"]
boot_command_hyperv  = ["c  setparams 'kickstart' <enter> linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=Fedora-40-x86_64-dvd inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-40.cfg<enter> initrdefi /images/pxeboot/initrd.img inst.repo=https://gb.mirrors.cicku.me/fedora/linux/releases/40/Server/x86_64/os/<enter> boot<enter>"]
boot_wait            = "5s"
disk_size            = "40960"
headless             = false
guest_os_type_vbox   = "Fedora_64"
guest_os_type_vmware = "fedora-64"
http_directory       = "./http"
iso_checksum         = "file:https://download.fedoraproject.org/pub/fedora/linux/releases/40/Server/x86_64/iso/Fedora-Server-40-1.14-x86_64-CHECKSUM"
iso_url              = "https://download.fedoraproject.org/pub/fedora/linux/releases/40/Server/x86_64/iso/Fedora-Server-dvd-x86_64-40-1.14.iso"
ram                  = "4096"
cpu                  = "2"
ssh_password         = "vagrant"
ssh_username         = "vagrant"
switch_name          = "Default Switch"
vlan_id              = ""
name                 = "Fedora-40-x86_64"