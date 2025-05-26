# Packer Examples

## Alma Linux Builds

| OS           | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu | Avg Build Time | Date Last Reviewed |
|--------------|--------------------|---------------|------------|------|----------------|--------------------|
| Alma Linux 8 | Working            | Working       | Working    | TBD  | 15 - 30 mins   | 17/05/2025         |
| Alma Linux 9 | Working            | Working       | Working    | TBD  | 15 - 30 mins   | 17/05/2025         |

```powershell
.\build.ps1 -Action build -Version 9 -Template almalinux -Provider virtualbox-iso
```

```powershell
.\build.ps1 -Action build -Version 9 -Template almalinux -Provider vmware-iso
```

---

## CentOS Builds

| OS              | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu | Avg Build Time | Date Last Reviewed |
|-----------------|--------------------|---------------|------------|------|----------------|--------------------|
| CentOS Stream 9 | Working            | Working       | Working    | TBD  | 10 - 15 mins   | 17/05/2025         |

```powershell
.\build.ps1 -Action build -Version 9 -Template centos -Provider virtualbox-iso
```

---

## Debian Builds

| OS        | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu | Avg Build Time | Date Last Reviewed |
|-----------|--------------------|---------------|------------|------|----------------|--------------------|
| Debian 12 | Working            | TBD           | Working    | TBD  |                |                    |

```powershell
.\build.ps1 -Action build -Version 12 -Template debian -Provider virtualbox-iso
```

## Fedora Builds

| OS        | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu | Avg Build Time | Date Last Reviewed |
|-----------|--------------------|---------------|------------|------|----------------|--------------------|
| Fedora 42 | Working            | Working       | Working    | TBD  | 10-30 mins     |                    |

```powershell
.\build.ps1 -Action build -Version 40 -Template fedora -Provider virtualbox-iso
```

## OpenSUSE Builds

| OS          | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu | Avg Build Time | Date Last Reviewed |
|-------------|--------------------|---------------|------------|------|----------------|--------------------|
| OpenSUSE 15 | Working            | TBD           | Working    | TBD  | 17 mins        |                    |

```powershell
.\build.ps1 -Action build -Version 15 -Template opensuse -Provider virtualbox-iso
```

## Oracle Builds

| OS         | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu    | Avg Build Time | Date Last Reviewed |
|------------|--------------------|---------------|------------|---------|----------------|--------------------|
| Oracle 8.6 | Working            | Working       | Working    | Working |                |                    |
| Oracle 9.4 | Working            | Working       | Working    | Failing | 20 mins        |                    |

```powershell
.\build.ps1 -Action build -Version 8 -Template oracle -Provider vmware-iso
```

### Oracle Notes

- Oracle 9.4 failing on QEMU due to known lack of support - [GH Issue](https://github.com/hashicorp/packer-plugin-qemu/issues/76)

## RHEL Builds

| OS       | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu    | Avg Build Time | Date Last Reviewed |
|----------|--------------------|---------------|------------|---------|----------------|--------------------|
| RHEL 7.9 | Working            | TBD           | Working    | Working |                |                    |
| RHEL 8.1 | Working            | TBD           | Working    | Working | 45 mins        |                    |

```powershell
.\build.ps1 -Action build -Version 7 -Template rhel -Provider vmware-iso
```

```powershell
.\build.ps1 -Action build -Version 7 -Template rhel -Provider virtualbox-iso
```

### RHEL ToDos

- RHEL 7 and RHEL 8 Needs ISO predownloaded - want to see if I can do something with the boot iso rather than full dvd(?)
- Add note about downloading ISOs from RHEL

## RockyLinux Builds

| OS              | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu | Avg Build Time | Date Last Reviewed |
|-----------------|--------------------|---------------|------------|------|----------------|--------------------|
| Rocky Linux 8.8 | Working            | Working       | Working    | TBD  | 15-25 mins     |                    |

```powershell
.\rockylinux.ps1 -Action build -Version 8 -Template rockylinux -Provider virtualbox-iso
```

## Ubuntu Builds

| OS           | Hyper-V Gen 2 | VirtualBox | Qemu    | Avg Build Time | Date Last Reviewed |
|--------------|---------------|------------|---------|----------------|--------------------|
| Ubuntu 22.04 | Working       | Working    | Working | 20 mins        |                    |
| Ubuntu 24.04 | Working       | Working    | Working | 20 mins        |                    |

```powershell
.\build.ps1 -Action build -Version 22 -Template ubuntu -Provider hyperv-iso
```

```powershell
.\build.ps1 -Action build -Version 22 -Template ubuntu -Provider virtualbox-iso
```

```powershell
.\build.ps1 -Action build -Version 22 -Template ubuntu -Provider qemu
```

## Windows Builds

| OS                      | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Avg Build Time | Date Last Reviewed |
|-------------------------|--------------------|---------------|------------|----------------|--------------------|
| Windows 10              | Working            | Working       | Working    | 45mins - 1hr   |                    |
| Windows 11              | Working            | Working       | Working    | 12 - 45 mins   |                    |
| Windows 2022 Standard   | Working            | Working       | Working    | 10 - 20 mins   |                    |
| Windows 2022 Datacenter | Working            | Working       | Working    | 10 - 20 mins   |                    |
| Windows 2019 Standard   | Working            | Working       | Working    | 10 - 20 mins   |                    |
| Windows 2019 Datacenter | Working            | Working       | Working    | 10 - 20 mins   |                    |

```powershell
.\build.ps1 -Action build -Version 2022 -Type std -Template windows-server -Provider vmware-iso
```

```powershell
.\build.ps1 -Action build -Version 2022 -Type std -Template windows-server -Provider hyperv-iso -Generation 2
```

```powershell
.\build.ps1 -Action build -Version 11 -Template windows -Provider vmware-iso
```

```powershell
.\build.ps1 -Action build -Version 11 -Template windows -Provider hyperv-iso -Generation 2
```
