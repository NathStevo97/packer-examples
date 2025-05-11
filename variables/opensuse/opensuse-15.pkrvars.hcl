boot_wait            = "1s"
boot_command         = ["<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<esc><wait5><enter><wait5>", "linux netsetup=dhcp net.ifnames=0 biosdevname=0 systemd.unified_cgroup_hierarchy=0 lang=en_US kexec=3 <wait5>", "install=https://downloadcontent.opensuse.org/distribution/leap/15.4/repo/oss <wait5>", "autoyast=http://{{ .HTTPIP }}:{{ .HTTPPort }}/opensuse/15/autoinst.xml <wait5>", "<enter>"]
cpu                  = 2
disk_size            = 60000
guest_os_type_vmware = "opensuse-64"
guest_os_type_vbox   = "OpenSUSE_64"
headless             = false
http_directory       = "./templates/http"
iso_checksum         = "4683345f242397c7fd7d89a50731a120ffd60a24460e21d2634e783b3c169695"
iso_url              = "http://downloadcontent.opensuse.org/distribution/leap/15.4/iso/openSUSE-Leap-15.4-DVD-x86_64-Build243.2-Media.iso"
# https://download.opensuse.org/distribution/leap/15.4/iso/openSUSE-Leap-15.4-DVD-x86_64-Current.iso
name         = "opensuse-15"
ram          = 4096
ssh_password = "vagrant"
ssh_username = "vagrant"