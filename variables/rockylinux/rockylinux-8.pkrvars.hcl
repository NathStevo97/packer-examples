boot_command         = ["e<down><down><end><bs><bs><bs><bs><bs>text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<leftCtrlOn>x<leftCtrlOff>"]
boot_command_hyperv  = ["c  setparams 'kickstart' <enter> linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=Rocky-8-8-x86_64-dvd inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter> initrdefi /images/pxeboot/initrd.img<enter> boot<enter>"]
boot_wait            = "5s"
config_file          = "ks.cfg"
disk_size            = "40960"
headless             = false
guest_os_type_vbox   = "RedHat_64"
guest_os_type_vmware = "centos-64"
http_directory       = "./http"
iso_checksum         = "96c9d96c33ebacc8e909dcf8abf067b6bb30588c0c940a9c21bb9b83f3c99868"
iso_url              = "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.8-x86_64-boot.iso"
memsize              = "2048"
numvcpus             = "2"
ssh_password         = "packer"
ssh_username         = "packer"
switch_name          = "Default Switch"
vlan_id              = ""
vm_name              = "Rocky-8.8-x86_64"