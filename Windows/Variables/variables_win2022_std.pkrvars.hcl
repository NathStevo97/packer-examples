boot_command             = ["<tab><wait><enter><wait>", "a<wait>a<wait>a<wait>a<wait>a<wait>a<wait>"]
boot_wait                = "5s"
boot_wait_hyperv         = "120s"
disk_size                = "40960"
floppy_files             = ["./Files/bios/win2022/std/autounattend.xml", "./Files/scripts/winrmConfig.ps1"]
guest_os_type_virtualbox = " Windows2019_64"
guest_os_type_vmware     = "windows2019srv-64"
headless                 = true
http_directory           = "../http/Agent_Installations"
iso_checksum             = "4f1457c4fe14ce48c9b2324924f33ca4f0470475e6da851b39ccbf98f44e7852"
iso_path                 = "../../ISOs/Windows Server/2022/20348.169.210806-2348.fe_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso"
iso_url                  = "https://software-download.microsoft.com/download/sg/20348.169.210806-2348.fe_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso"
memsize                  = "4096"
numvcpus                 = "2"
output_directory         = "../builds/output-packer-win2022-std"
secondary_iso_image      = "./Files/bios/win2022/std/secondary.iso"
switch_name              = "Default Switch"
upgrade_timeout          = ""
vlan_id                  = ""
vm_name                  = "Win2022_datacenter"
winrm_password           = "packer"
winrm_timeout            = "4h"
winrm_username           = "Administrator"