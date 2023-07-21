
source "virtualbox-iso" "opensuse" {
  boot_command           = ["<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><wait>", "<esc><wait5><enter><wait5>", "linux netsetup=dhcp net.ifnames=0 biosdevname=0 systemd.unified_cgroup_hierarchy=0 lang=en_US kexec=3 <wait5>", "install=https://downloadcontent.opensuse.org/distribution/leap/15.4/repo/oss <wait5>", "autoyast=http://{{ .HTTPIP }}:{{ .HTTPPort }}/autoinst.xml <wait5>", "<enter>"]
  boot_wait              = "1s"
  cpus                   = 2
  disk_size              = 60000
  guest_os_type          = "OpenSUSE_64"
  headless               = false
  http_directory         = "./"
  iso_checksum           = "4683345f242397c7fd7d89a50731a120ffd60a24460e21d2634e783b3c169695"
  iso_url                = "http://downloadcontent.opensuse.org/distribution/leap/15.4/iso/openSUSE-Leap-15.4-DVD-x86_64-Build243.2-Media.iso"
  memory                 = 4096
  shutdown_command       = "sudo shutdown -h now"
  ssh_password           = "vagrant"
  ssh_port               = 22
  ssh_read_write_timeout = "600s"
  ssh_timeout            = "120m"
  ssh_username           = "vagrant"
  vboxmanage             = [["modifyvm", "{{ .Name }}", "--cpu-profile", "host"], ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"]]
  vrdp_bind_address      = "0.0.0.0"
  vrdp_port_max          = 6000
  vrdp_port_min          = 5900
}

build {
  sources = ["source.virtualbox-iso.opensuse"]

}
