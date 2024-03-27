# Packer Examples

## Alma Linux Builds

| OS           | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox | Qemu | Date Last Tested | Avg Build Time |
|--------------|--------------------|---------------|---------------|------------|------|------------------|----------------|
| Alma Linux 9 | Working            | TBD           | TBD           | Working    | TBD  | 04/03/2024       | 15 - 30 mins   |

```powershell
.\almalinux.ps1 -Action build -Version 9 -Template almalinux -Provider virtualbox-iso
```

```powershell
.\almalinux.ps1 -Action build -Version 9 -Template almalinux -Provider vmware-iso
```

---

## CentOS Builds

| OS               | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox      | Qemu | Date Last Tested | Avg Build Time |
|------------------|--------------------|---------------|---------------|-----------------|------|------------------|----------------|
| CentOS 7         | Working            | TBD           | TBD           | Working         | TBD  | 04/03/2024       | 22 mins        |
| CentOS Stream 8* | Changes Pending    | TBD           | TBD           | Changes Pending | TBD  | 16/09/2023       |                |
| CentOS Stream 9* | Changes Pending    | TBD           | TBD           | Changes Pending | TBD  | 16/09/2023       |                |

```powershell
.\centos.ps1 -Action build -Version 7 -Template centos -Provider virtualbox-iso
```

### CentOS ToDos

- *Try to rework CentOS builds to use boot isos for ease - saves storing the ~10Gb Net Install ISOs locally
- CentOS 7 Virtualbox Build Getting Stuck at Boot
- Stream 8 and 9 need ISO pre-downloaded currently

---

## Debian Builds

| OS        | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox | Qemu | Date Last Tested | Avg Build Time |
|-----------|--------------------|---------------|---------------|------------|------|------------------|----------------|
| Debian 12 | Working            | TBD           | TBD           | Working    | TBD  | 07/03/2024       |                |

### Debian ToDos

- All platforms getting stuck at boot - `No Kernel Module Found`
- Fix: Get the Latest `mini.iso` from Debian.

## OpenSUSE Builds

| OS          | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox | Qemu | Date Last Tested | Avg Build Time |
|-------------|--------------------|---------------|---------------|------------|------|------------------|----------------|
| OpenSUSE 15 | TBD                | TBD           | TBD           | Working    | TBD  | 04/03/2024       | 17 mins        |

```powershell
.\opensuse.ps1 -Action build -Version 15 -Template opensuse -Provider virtualbox-iso
```

## Oracle Builds

| OS         | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox | Qemu | Date Last Tested | Avg Build Time |
|------------|--------------------|---------------|---------------|------------|------|------------------|----------------|
| Oracle 7.9 | Working            | TBD           | TBD           | TBD        | TBD  | 04/03/2024       | 25 mins        |
| Oracle 8.6 | Working            | TBD           | TBD           | TBD        | TBD  | 04/03/2024       |                |
| Oracle 9.0 | Working            | TBD           | TBD           | TBD        | TBD  | 07/03/2024       |                |

```powershell
.\oracle.ps1 -Action build -Version 7 -Template oracle -Provider vmware-iso
```

## RHEL Builds

| OS       | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox | Qemu    | Date Last Tested | Avg Build Time |
|----------|--------------------|---------------|---------------|------------|---------|------------------|----------------|
| RHEL 7.9 | Working            | TBD           | TBD           | Working    | Working | 16/09/2023       |                |
| RHEL 8.1 | Working            | TBD           | TBD           | Working    | Working | 09/03/2024       | 45 mins        |

### RHEL ToDos

- RHEL 7 and RHEL 8 Needs ISO predownloaded - want to see if I can do something with the boot iso rather than full dvd(?)
- Add note about downloading ISOs from RHEL

## RockyLinux Builds

| OS              | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox | Qemu | Date Last Tested | Avg Build Time |
|-----------------|--------------------|---------------|---------------|------------|------|------------------|----------------|
| Rocky Linux 8.6 | Failing            | TBD           | TBD           | Working    | TBD  | 09/03/2024       |                |

### Rocky Linux ToDos

- Getting Stuck at Boot Launch for some reason (VMware)

## Ubuntu Builds

| OS        | Hyper-V Gen 2 | VirtualBox | Qemu    | Date Last Tested | Avg Build Time |
|-----------|---------------|------------|---------|------------------|----------------|
| Ubuntu 22 | Working       | Working    | Working | 09/03/2024       | 35 mins        |

```powershell
.\ubuntu.ps1 -Action build -Version 22 -Template ubuntu -Provider virtualbox-iso
```

## Windows Builds

| OS                      | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox | Qemu | Date Last Tested | Avg Build Time |
|-------------------------|--------------------|---------------|---------------|------------|------|------------------|----------------|
| Windows 10              | Working            | Working       | Working       | Working    | TBD  | 25/03/2024       | 45mins - 1hr   |
| Windows 11              | Working            | N/A           | TBD           | Working    | TBD  | 16/03/2024       | 12 - 45 mins   |
| Windows 2022 Standard   | Working            | Working       | Working       | Working    | TBD  | 16/03/2024       | 10 - 20 mins   |
| Windows 2022 Datacenter | Working            | Working       | Working       | Working    | TBD  | 16/03/2024       | 10 - 20 mins   |
| Windows 2019 Standard   | Working            | Working       | Working       | Working    | TBD  | 16/03/2024       | 10 - 20 mins   |
| Windows 2019 Datacenter | Working            | Working       | Working       | Working    | TBD  | 16/03/2024       | 10 - 20 mins   |
| Windows 2016 Standard   | Working            | Working       | Working       | Working    | TBD  | 16/03/2024       | 10 - 20 mins   |
| Windows 2016 Datacenter | Working            | Working       | Working       | Working    | TBD  | 16/03/2024       | 10 - 20 mins   |

```powershell
.\windows-server.ps1 -Action build -Version 2016 -Type std -Template windows-server -Provider vmware-iso
```

```powershell
.\windows-server.ps1 -Action build -Version 2016 -Type std -Template windows-server -Provider hyperv-iso -Generation 2
```

```powershell
.\windows.ps1 -Action build -Version 10 -Template windows -Provider vmware-iso
```

```powershell
.\windows.ps1 -Action build -Version 10 -Template windows -Provider hyperv-iso -Generation 2
```
