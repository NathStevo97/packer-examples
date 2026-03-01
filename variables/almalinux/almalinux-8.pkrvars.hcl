boot_wait            = "10s"
boot_command         = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text rd.live.check=0 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux/almalinux8-kickstart.cfg<leftCtrlOn>x<leftCtrlOff>"]
boot_command_qemu    = ["<tab> inst.text rd.live.check=0 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux/almalinux8-kickstart.cfg<enter>"]
cpus                 = "2"
disk_size            = "70000"
guest_os_type_vmware = "centos-64"
headless             = false
http_directory       = "./templates/http"
http_port_min        = "9000"
http_port_max        = "9000"
iso_checksum         = "file:https://repo.almalinux.org/almalinux/8/isos/x86_64/CHECKSUM"
iso_url              = "https://repo.almalinux.org/almalinux/8/isos/x86_64/AlmaLinux-8.10-x86_64-minimal.iso"
memory               = "4096"
ssh_password         = "vagrant"
ssh_username         = "vagrant"
version              = "8"
vm_name              = "almalinux-8"

#
# Deprecated Vars
#

# boot_command_hyperv  = ["c  setparams 'kickstart' <enter> linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=AlmaLinux-8-10-x86_64-dvd inst.repo=https://repo.almalinux.org/almalinux/8.10/BaseOS/x86_64/os/ rd.live.check=0 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux/almalinux8-kickstart.cfg<enter> initrdefi /images/pxeboot/initrd.img<enter> boot<enter>"]
# guest_os_type_vbox   = "RedHat_64"
# switch_name          = "Default Switch"
# vlan_id              = ""
