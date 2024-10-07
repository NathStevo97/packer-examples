# Packer Examples

## Alma Linux Builds

| OS           | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox | Qemu | Avg Build Time |
|--------------|--------------------|---------------|---------------|------------|------|----------------|
| Alma Linux 9 | Working            | TBD           | TBD           | Working    | TBD  | 15 - 30 mins   |

```powershell
.\almalinux.ps1 -Action build -Version 9 -Template almalinux -Provider virtualbox-iso
```

```powershell
.\almalinux.ps1 -Action build -Version 9 -Template almalinux -Provider vmware-iso
```

### Todos

- Boot command not getting passed correctly / installation src + software selection unchecked

---

## CentOS Builds

| OS              | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox | Qemu | Avg Build Time |
|-----------------|--------------------|---------------|---------------|------------|------|----------------|
| CentOS Stream 9 | Working            | TBD           | TBD           | Working    | TBD  |                |

```powershell
.\centos.ps1 -Action build -Version 9 -Template centos -Provider virtualbox-iso
```

---

## Debian Builds

| OS        | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox | Qemu | Avg Build Time |
|-----------|--------------------|---------------|---------------|------------|------|----------------|
| Debian 12 | Working            | TBD           | TBD           | Working    | TBD  |                |

### Debian Notes

- Platforms getting stuck at boot - `No Kernel Module Found`
- Fix: Get the Latest `mini.iso` from Debian.

## OpenSUSE Builds

| OS          | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox | Qemu | Avg Build Time |
|-------------|--------------------|---------------|---------------|------------|------|----------------|
| OpenSUSE 15 | TBD                | TBD           | TBD           | Working    | TBD  | 17 mins        |

```powershell
.\opensuse.ps1 -Action build -Version 15 -Template opensuse -Provider virtualbox-iso
```

## Oracle Builds

| OS         | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu | Avg Build Time |
|------------|--------------------|---------------|------------|------|----------------|
| Oracle 8.6 | Working            | Working       | TBD        | TBD  |                |
| Oracle 9.0 | Working            | Working       | TBD        | TBD  | 20 mins        |

```powershell
.\oracle.ps1 -Action build -Version 8 -Template oracle -Provider vmware-iso
```

## RHEL Builds

| OS       | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox | Qemu    | Avg Build Time |
|----------|--------------------|---------------|---------------|------------|---------|----------------|
| RHEL 7.9 | Working            | TBD           | TBD           | Working    | Working |                |
| RHEL 8.1 | Working            | TBD           | TBD           | Working    | Working | 45 mins        |

```powershell
.\rhel.ps1 -Action build -Version 7 -Template rhel -Provider vmware-iso
```

```powershell
.\rhel.ps1 -Action build -Version 7 -Template rhel -Provider virtualbox-iso
```

### RHEL ToDos

- RHEL 7 and RHEL 8 Needs ISO predownloaded - want to see if I can do something with the boot iso rather than full dvd(?)
- Add note about downloading ISOs from RHEL

## RockyLinux Builds

| OS              | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox | Qemu | Avg Build Time |
|-----------------|--------------------|---------------|---------------|------------|------|----------------|
| Rocky Linux 8.6 | Working            | TBD           | TBD           | Working    | TBD  | 15-25 mins     |

```powershell
.\rockylinux.ps1 -Action build -Version 8 -Template rockylinux -Provider virtualbox-iso
```

## Ubuntu Builds

| OS           | Hyper-V Gen 2 | VirtualBox | Qemu    | Avg Build Time |
|--------------|---------------|------------|---------|----------------|
| Ubuntu 20.04 | Working       | TBD        | TBD     | 15 mins        |
| Ubuntu 22.04 | Working       | Working    | Working | 20 mins        |
| Ubuntu 24.04 | Working       | Working    | Working | 20 mins        |

```powershell
.\ubuntu.ps1 -Action build -Version 22 -Template ubuntu -Provider hyperv-iso
```

```powershell
.\ubuntu.ps1 -Action build -Version 22 -Template ubuntu -Provider virtualbox-iso
```

```powershell
.\ubuntu.ps1 -Action build -Version 22 -Template ubuntu -Provider qemu
```

## Windows Builds

| OS                      | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox | Avg Build Time |
|-------------------------|--------------------|---------------|---------------|------------|----------------|
| Windows 10              | Working            | Working       | Working       | Working    | 45mins - 1hr   |
| Windows 11              | Working            | N/A           | Working       | Working    | 12 - 45 mins   |
| Windows 2022 Standard   | Working            | Working       | Working       | Working    | 10 - 20 mins   |
| Windows 2022 Datacenter | Working            | Working       | Working       | Working    | 10 - 20 mins   |
| Windows 2019 Standard   | Working            | Working       | Working       | Working    | 10 - 20 mins   |
| Windows 2019 Datacenter | Working            | Working       | Working       | Working    | 10 - 20 mins   |
| Windows 2016 Standard   | Working            | Working       | Working       | Working    | 10 - 20 mins   |
| Windows 2016 Datacenter | Working            | Working       | Working       | Working    | 10 - 20 mins   |

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
