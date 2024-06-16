boot_command             = ["e<down><down><end><bs><bs><bs><bs><bs>text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-7.cfg<leftCtrlOn>x<leftCtrlOff>"]
boot_wait                = "5s"
disk_size                = "40960"
guest_os_type_virtualbox = "RedHat_64"
guest_os_type_vmware     = "centos-64"
headless                 = false
http_directory           = "./http"
iso_checksum             = "b79079ad71cc3c5ceb3561fff348a1b67ee37f71f4cddfec09480d4589c191d6"
iso_path                 = "../../ISOs/CentOS/CentOS-7-x86_64-NetInstall-2009.iso"
iso_url                  = "http://repo.uk.bigstepcloud.com/centos/7.9.2009/isos/x86_64/CentOS-7-x86_64-NetInstall-2009.iso"
memsize                  = "1024"
numvcpus                 = "2"
ssh_password             = "vagrant"
ssh_timeout              = "30m"
ssh_username             = "vagrant"
vm_name                  = "CentOS-7-x86_64-2009"