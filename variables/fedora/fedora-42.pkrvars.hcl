boot_command = [
  "<wait1m><up>e<wait><down><down><end> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/fedora/ks-42.cfg<F10><wait>"
]
boot_command_hyperv = [
  "<wait1m>c  setparams 'kickstart' <enter> linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=Fedora-42-x86_64-dvd inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/fedora/ks-42.cfg<enter> initrdefi /images/pxeboot/initrd.img inst.repo=https://gb.mirrors.cicku.me/fedora/linux/releases/42/Server/x86_64/os/<enter> boot<enter>"
]
boot_wait            = "10s"
disk_size            = "40960"
headless             = false
guest_os_type_vbox   = "Fedora_64"
guest_os_type_vmware = "fedora-64"
http_directory       = "./templates/http"
iso_checksum         = "file:https://download.fedoraproject.org/pub/fedora/linux/releases/42/Server/x86_64/iso/Fedora-Server-42-1.1-x86_64-CHECKSUM"
iso_url              = "https://download.fedoraproject.org/pub/fedora/linux/releases/42/Server/x86_64/iso/Fedora-Server-dvd-x86_64-42-1.1.iso"
ram                  = "4096"
cpu                  = "2"
ssh_password         = "vagrant"
ssh_username         = "vagrant"
switch_name          = "Default Switch"
vlan_id              = ""
name                 = "Fedora-42-x86_64"
