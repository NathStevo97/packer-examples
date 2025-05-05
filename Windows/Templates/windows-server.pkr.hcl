#################################################################
#                           Variables                           #
#################################################################
variable "boot_command" {
  type    = list(string)
  default = []
}

variable "boot_wait" {
  type    = string
  default = ""
}

variable "boot_wait_hyperv" {
  type    = string
  default = ""
}

variable "disk_size" {
  type    = string
  default = ""
}

variable "floppy_files" {
  type    = list(string)
  default = []
}

variable "guest_os_type_virtualbox" {
  type    = string
  default = ""
}

variable "guest_os_type_vmware" {
  type    = string
  default = ""
}

variable "headless" {
  type    = bool
  default = false
}

variable "http_directory" {
  type    = string
  default = ""
}

variable "iso_checksum" {
  type    = string
  default = ""
}

variable "iso_path" {
  type    = string
  default = ""
}

variable "iso_url" {
  type    = string
  default = ""
}

variable "memsize" {
  type    = string
  default = ""
}

variable "numvcpus" {
  type    = string
  default = ""
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
  default = ""
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
  default = ""
}

variable "winrm_password" {
  type    = string
  default = ""
}

variable "winrm_timeout" {
  type    = string
  default = ""
}

variable "winrm_username" {
  type    = string
  default = ""
}

#################################################################
#                           VMware-ISO Builder                  #
#################################################################
source "vmware-iso" "windows-server" {
  boot_wait        = "${var.boot_wait}"
  communicator     = "winrm"
  cpus             = "${var.numvcpus}"
  disk_size        = "${var.disk_size}"
  disk_type_id     = "0"
  floppy_files     = "${var.floppy_files}"
  guest_os_type    = "${var.guest_os_type_vmware}"
  headless         = var.headless
  http_directory   = "${var.http_directory}"
  iso_checksum     = "${var.iso_checksum}"
  iso_urls         = ["${var.iso_path}", "${var.iso_url}"]
  memory           = "${var.memsize}"
  output_directory = "${var.output_directory}-vmware"
  shutdown_command = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout = "30m"
  skip_compaction  = false
  version         = "14"
  vm_name          = "${var.vm_name}-vmware"
  winrm_insecure = true
  winrm_password = "${var.winrm_password}"
  winrm_timeout  = "${var.winrm_timeout}"
  winrm_use_ssl  = true
  winrm_username = "${var.winrm_username}"
}

#################################################################
#                        Gen-2 Hyper-V Builder                  #
#################################################################
source "hyperv-iso" "hv2-windows-server" {
  boot_command          = "${var.boot_command}"
  boot_wait             = "${var.boot_wait_hyperv}"
  communicator          = "winrm"
  cpus                  = "${var.numvcpus}"
  disk_size             = "${var.disk_size}"
  enable_dynamic_memory = "true"
  enable_secure_boot    = false
  generation            = 2
  guest_additions_mode  = "disable"
  headless              = var.headless
  http_directory        = "${var.http_directory}"
  iso_checksum          = "${var.iso_checksum}"
  iso_urls              = ["${var.iso_path}", "${var.iso_url}"]
  memory                = "${var.memsize}"
  output_directory      = "${var.output_directory}-hv2"
  secondary_iso_images  = ["${var.secondary_iso_image}"]
  shutdown_timeout      = "2h"
  skip_export           = true
  switch_name           = "${var.switch_name}"
  temp_path             = "."
  vlan_id               = "${var.vlan_id}"
  vm_name               = "${var.vm_name}-hv2"
  winrm_password        = "${var.winrm_password}"
  winrm_timeout         = "${var.winrm_timeout}"
  winrm_username        = "${var.winrm_username}"
}

#################################################################
#                    Virtualbox-ISO Builder                     #
#################################################################

source "virtualbox-iso" "windows-server" {
  communicator         = "winrm"
  disk_size            = "${var.disk_size}"
  floppy_files         = "${var.floppy_files}"
  guest_additions_mode = "disable"
  #guest_additions_path = "c:/Windows/Temp/windows.iso"
  guest_os_type        = "${var.guest_os_type_virtualbox}"
  hard_drive_interface = "sata"
  headless             = var.headless
  http_directory       = "${var.http_directory}"
  iso_checksum         = "${var.iso_checksum}"
  iso_interface        = "sata"
  iso_urls             = ["${var.iso_path}", "${var.iso_url}"]
  output_directory     = "${var.output_directory}-vbox"
  shutdown_command     = "shutdown /s /t 0 /f /d p:4:1 /c \"Packer Shutdown\""
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"],
    ["modifyvm", "{{ .Name }}", "--vram", "32"],
    ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]
  ]
  winrm_insecure = true
  winrm_password = "${var.winrm_password}"
  winrm_timeout  = "${var.winrm_timeout}"
  winrm_username = "${var.winrm_username}"
}

#################################################################
#                           Builders                            #
#################################################################

build {
  sources = ["source.vmware-iso.windows-server", "source.hyperv-iso.hv2-windows-server", "source.virtualbox-iso.windows-server"]

  /*
  provisioner "powershell" {
    elevated_password = "packer"
    elevated_user     = "Administrator"
    only              = ["vmware-iso.windows-server"] # this provisioner will only run for the vmware-iso build
    scripts           = ["./Files/scripts/vmware-tools.ps1"]
  }

  provisioner "powershell" {
    elevated_password = "packer"
    elevated_user     = "Administrator"
    scripts           = ["./Files/scripts/setup.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }*/
  /*
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