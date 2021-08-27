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
  default = "3022424f777b66a698047ba1c37812026b9714c5"
}

variable "iso_url" {
  type    = string
  default = "../../../ISOs/Windows Server/2019/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
}

variable "memsize" {
  type    = string
  default = "2048"
}

variable "numvcpus" {
  type    = string
  default = "1"
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
  default = "Win2019_Standard"
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
#                           Source Blocks                       #
#################################################################

#################################################################
#                           VMware-ISO Builder                  #
#################################################################
source "vmware-iso" "vmware-win2019-standard" {
  boot_wait        = "${var.boot_wait}"
  communicator     = "winrm"
  disk_size        = "${var.disk_size}"
  disk_type_id     = "0"
  floppy_files     = ["./Files/bios/win2019/Std/autounattend.xml", "./Files/scripts/winrmConfig.ps1"]
  guest_os_type    = "windows9srv-64"
  headless         = false
  http_directory   = "../http/Agent_Installations"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
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
source "hyperv-iso" "hv1-win2019-standard" {
  communicator         = "winrm"
  cpus                 = "${var.numvcpus}"
  disk_size            = "${var.disk_size}"
  floppy_files         = ["./Files/bios/win2019/Std/autounattend.xml", "./Files/scripts/winrmConfig.ps1"]
  guest_additions_mode = "disable"
  http_directory       = "../http/Agent_Installations"
  iso_checksum         = "${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
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
source "hyperv-iso" "hv2-win2019-standard" {
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
  http_directory        = "../http/Agent_Installations"
  #iso_checksum          = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_checksum         = "${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
  #iso_checksum         = "md5:4d0943213b7a5f77917f7aa5baa92dcd"
  #iso_url              = "../../../ISOs/Windows Server/2019/SW_DVD9_Win_Server_STD_CORE_2019_1809.1_64Bit_English_DC_STD_MLF_X22-02970.iso"
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

source "virtualbox-iso" "vbox-win2019-standard" {
  communicator         = "winrm"
  disk_size            = 61440
  floppy_files         = ["./Files/bios/win2019/Std/autounattend.xml", "./Files/scripts/winrmConfig.ps1"]
  #guest_additions_mode = "upload"
  #guest_additions_path = "c:/Windows/Temp/windows.iso"
  guest_os_type        = " Windows2019_64"
  hard_drive_interface = "sata"
  headless             = false
  iso_checksum         = "${var.iso_checksum}"
  #iso_checksum_type    = "md5"
  iso_interface        = "sata"
  iso_url              = "${var.iso_url}"
  shutdown_command     = "shutdown /s /t 0 /f /d p:4:1 /c \"Packer Shutdown\""
  vboxmanage           = [["modifyvm", "{{ .Name }}", "--memory", "2048"], ["modifyvm", "{{ .Name }}", "--cpus", "1"], ["modifyvm", "{{ .Name }}", "--vram", "32"]]
  winrm_insecure       = true
  winrm_password       = "${var.winrm_password}"
  winrm_timeout        = "4h"
  winrm_username       = "${var.winrm_username}"
}

#################################################################
#                           Builders                            #
#################################################################

build {
  sources = ["source.vmware-iso.vmware-win2019-standard", "source.hyperv-iso.hv1-win2019-standard", "source.hyperv-iso.hv2-win2019-standard", "source.virtualbox-iso.vbox-win2019-standard"]

/*  
  provisioner "powershell" {
    elevated_password = "packer"
    elevated_user     = "Administrator"
    only              = ["vmware-iso.win2019-standard"] # this provisioner will only run for the vmware-iso build
    scripts           = ["./Files/scripts/vmware-tools.ps1"]
  }

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
  #provisioner "powershell" {
  #  scripts = ["scripts/cleanup.ps1"]
  #}
  */
}