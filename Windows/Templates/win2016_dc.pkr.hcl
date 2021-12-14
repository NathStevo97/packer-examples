#################################################################
#                           Variables                           #
#################################################################
variable "boot_wait" {
  type    = string
  default = "5s"
}

variable "disk_size" {
  type    = string
  default = "40960"
}

variable "iso_checksum" {
  type    = string
  default = "70721288bbcdfe3239d8f8c0fae55f1f"
}

variable "iso_path" {
  type    = string
  default = "../../ISOs/Windows Server/2016/Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO"
}

variable "iso_url" {
  type    = string
  default = "https://software-download.microsoft.com/download/pr/Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO"
}

variable "memsize" {
  type    = string
  default = "4096"
}

variable "numvcpus" {
  type    = string
  default = "2"
}

variable "output_directory" {
  type    = string
  default = ""
}

variable "secondary_iso_image" {
  type    = string
  default = ""
}

variable "switch_name" {
  type    = string
  default = "Default Switch"
}

variable "upgrade_timeout" {
  type    = string
  default = ""
}

variable "vlan_id" {
  type    = string
  default = ""
}

variable "vm_name" {
  type    = string
  default = "Win2016_Datacenter"
}

variable "winrm_password" {
  type    = string
  default = "packer"
}

variable "winrm_username" {
  type    = string
  default = "Administrator"
}



#################################################################
#                           VMware-ISO Builder                  #
#################################################################
source "vmware-iso" "vmware-win2016-datacenter" {
  boot_wait        = "${var.boot_wait}"
  communicator     = "winrm"
  disk_size        = "${var.disk_size}"
  disk_type_id     = "0"
  floppy_files     = ["./Files/bios/win2016/DC/autounattend.xml", "./Files/scripts/winrmConfig.ps1"]
  guest_os_type    = "windows8srv-64"
  headless         = true
  http_directory   = "../http/Agent_Installations"
  iso_checksum     = "${var.iso_checksum}"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  shutdown_command = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout = "30m"
  skip_compaction  = false
  vm_name          = "${var.vm_name}"
  vmx_data = {
    memsize             = "${var.memsize}"
    numvcpus            = "${var.numvcpus}"
    "scsi0.virtualDev"  = "lsisas1068"
    "virtualHW.version" = "14"
  }
  winrm_insecure = true
  winrm_password = "${var.winrm_password}"
  winrm_timeout  = "4h"
  winrm_use_ssl  = true
  winrm_username = "${var.winrm_username}"
}

#################################################################
#                        Gen-1 Hyper-V Builder                  #
#################################################################
source "hyperv-iso" "hv1-win2016-datacenter" {
  communicator         = "winrm"
  cpus                 = "${var.numvcpus}"
  disk_size            = "${var.disk_size}"
  floppy_files         = ["./Files/bios/win2016/DC/autounattend.xml", "./Files/scripts/winrmConfig.ps1"]
  headless             = true
  guest_additions_mode = "disable"
  http_directory       = "../http/Agent_Installations"
  iso_checksum         = "${var.iso_checksum}"
  iso_urls             = ["${var.iso_path}", "${var.iso_url}"]
  memory               = "${var.memsize}"
  shutdown_timeout     = "15m"
  switch_name          = "${var.switch_name}"
  vm_name              = "${var.vm_name}"
  winrm_password       = "${var.winrm_password}"
  winrm_timeout        = "4h"
  winrm_username       = "${var.winrm_username}"
}

#################################################################
#                        Gen-2 Hyper-V Builder                  #
#################################################################
source "hyperv-iso" "hv2-win2016-datacenter" {
  boot_command = ["<tab><wait><enter><wait>",
  "a<wait>a<wait>a<wait>a<wait>a<wait>a<wait>"]
  boot_wait             = "120s"
  communicator          = "winrm"
  cpus                  = "${var.numvcpus}"
  disk_size             = "${var.disk_size}"
  enable_dynamic_memory = "true"
  enable_secure_boot    = false
  generation            = 2
  guest_additions_mode  = "disable"
  headless              = true
  http_directory        = "../http/Agent_Installations"
  #iso_checksum          = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_checksum         = "${var.iso_checksum}"
  iso_urls             = ["${var.iso_path}", "${var.iso_url}"]
  memory               = "${var.memsize}"
  output_directory     = "${var.output_directory}"
  secondary_iso_images = ["${var.secondary_iso_image}"]
  shutdown_timeout     = "2h"
  skip_export          = true
  switch_name          = "${var.switch_name}"
  temp_path            = "."
  vlan_id              = "${var.vlan_id}"
  vm_name              = "${var.vm_name}"
  winrm_password       = "${var.winrm_password}"
  winrm_timeout        = "4h"
  winrm_username       = "${var.winrm_username}"
}

#################################################################
#                    Virtualbox-ISO Builder                     #
#################################################################

source "virtualbox-iso" "vbox-win2016-dc" {
  communicator = "winrm"
  disk_size    = 61440
  floppy_files = ["./Files/bios/win2016/DC/autounattend.xml", "./Files/scripts/winrmConfig.ps1"]
  #guest_additions_mode = "upload"
  #guest_additions_path = "c:/Windows/Temp/windows.iso"
  guest_os_type        = " Windows2016_64"
  hard_drive_interface = "sata"
  headless             = true
  http_directory       = "../http/Agent_Installations"
  iso_checksum         = "${var.iso_checksum}"
  iso_interface        = "sata"
  iso_urls             = ["${var.iso_path}", "${var.iso_url}"]
  shutdown_command     = "shutdown /s /t 0 /f /d p:4:1 /c \"Packer Shutdown\""
  vboxmanage           = [["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"], ["modifyvm", "{{ .Name }}", "--vram", "32"]]
  winrm_insecure       = true
  winrm_password       = "${var.winrm_password}"
  winrm_timeout        = "4h"
  winrm_username       = "${var.winrm_username}"
}


#################################################################
#                           Builders                            #
#################################################################

build {
  sources = ["source.vmware-iso.vmware-win2016-datacenter", "source.hyperv-iso.hv1-win2016-datacenter", "source.hyperv-iso.hv2-win2016-datacenter", "source.virtualbox-iso.vbox-win2016-dc"]

  provisioner "powershell" {
    elevated_password = "packer"
    elevated_user     = "Administrator"
    only              = ["vmware-iso.win2016-datacenter"] # this provisioner will only run for the vmware-iso build
    scripts           = ["./Files/scripts/vmware-tools.ps1"]
  }
  /*
  provisioner "powershell" {
    elevated_password = "packer"
    elevated_user     = "Administrator"
    scripts           = ["./Files/scripts/setup.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    elevated_password = "packer"
    elevated_user     = "Administrator"
    scripts           = ["./Files/scripts/win-update.ps1"]
  }
  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    elevated_password = "packer"
    elevated_user     = "Administrator"
    scripts           = ["./Files/scripts/win-update.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

    
  provisioner "powershell" {
    elevated_password = "packer"
    elevated_user     = "Administrator"
    scripts           = ["./Files/scripts/illumio_install.ps1"]
  }

  provisioner "powershell" {
    elevated_password = "packer"
    elevated_user     = "Administrator"
    scripts           = ["./Files/scripts/qualys_install.ps1"]
  }

  provisioner "powershell" {
    elevated_password = "packer"
    elevated_user     = "Administrator"
    scripts           = ["./Files/scripts/mcafee_install.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    elevated_password = "packer"
    elevated_user     = "Administrator"
    scripts           = ["./Files/scripts/sccm_setup.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    elevated_password = "packer"
    elevated_user     = "Administrator"
    scripts           = ["./Files/scripts/sec_hardening_setup.ps1"]
  }
  provisioner "powershell" {
    scripts = ["scripts/cleanup.ps1"]
  }*/
}