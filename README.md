# Packer Examples

## Alma Linux Builds

| OS   | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu    | Avg Build Time | Date Last Reviewed |
|------|--------------------|---------------|------------|---------|----------------|--------------------|
| 10.1 | Pending            | Pending       | Pending    | Pending | N/A            | N/A                |
| 9.7  | Working            | Working       | Working    | Working | 15 - 30 mins   | 08/06/2025         |
| 8.10 | Working            | Working       | Working    | Working | 15 - 30 mins   | 08/06/2025         |

```powershell
.\build.ps1 -Action build -Version 9 -Template almalinux -Provider virtualbox-iso
```

```powershell
.\build.ps1 -Action build -Version 9 -Template almalinux -Provider vmware-iso
```

---

## CentOS Builds

| OS        | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu    | Avg Build Time | Date Last Reviewed |
|-----------|--------------------|---------------|------------|---------|----------------|--------------------|
| Stream 10 | Pending            | Pending       | Pending    | Pending | N/A            | N/A                |
| Stream 9  | Working            | Working       | Working    | Working | 10 - 15 mins   | 17/05/2025         |

```powershell
.\build.ps1 -Action build -Version 9 -Template centos -Provider virtualbox-iso
```

---

## Debian Builds

| OS | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu    | Avg Build Time | Date Last Reviewed |
|----|--------------------|---------------|------------|---------|----------------|--------------------|
| 13 | Pending            | Pending       | Pending    | Pending | N/A            | N/A                |
| 12 | Working            | Working       | Working    | Working | 15-30 mins     | 05/07/2025         |

```powershell
.\build.ps1 -Action build -Version 12 -Template debian -Provider virtualbox-iso
```

---

## Fedora Builds

| OS | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu    | Avg Build Time | Date Last Reviewed |
|----|--------------------|---------------|------------|---------|----------------|--------------------|
| 43 | Pending            | Pending       | Pending    | Pending | N/A            | N/A                |
| 42 | Working            | Failing       | Failing    | TBD     | 10-30 mins     | 27/7/2025          |

```powershell
.\build.ps1 -Action build -Version 42 -Template fedora -Provider virtualbox-iso
```

- Need to update boot_command for hyper-v and virtualbox boot command usage

---

## OpenSUSE Builds

| OS      | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu    | Avg Build Time | Date Last Reviewed |
|---------|--------------------|---------------|------------|---------|----------------|--------------------|
| Leap 16 | Pending            | Pending       | Pending    | Pending | N/A            | N/A                |
| Leap 15 | Working            | TBD           | Working    | TBD     | 17 mins        | 27/07/2025         |

```powershell
.\build.ps1 -Action build -Version 15 -Template opensuse -Provider virtualbox-iso
```

---

## Oracle Builds

| OS  | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu    | Avg Build Time | Date Last Reviewed |
|-----|--------------------|---------------|------------|---------|----------------|--------------------|
| 10  | Pending            | Pending       | Pending    | Pending | N/A            | N/A                |
| 9.4 | Working            | Failing       | Working    | Failing | 20 mins        | 06/08/2025         |
| 8.6 | Working            | Working       | Working    | Working |                | 27/07/2025         |

```powershell
.\build.ps1 -Action build -Version 8 -Template oracle -Provider vmware-iso
```

### Oracle Notes

- Oracle 9.4 failing on QEMU due to known lack of support - [GH Issue](https://github.com/hashicorp/packer-plugin-qemu/issues/76)
- Boot command needs updating for Oracle 9

---

## RHEL Builds

| OS        | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu    | Avg Build Time | Date Last Reviewed |
|-----------|--------------------|---------------|------------|---------|----------------|--------------------|
| RHEL 10.0 | TBD                | TBD           | TBD        | TBD     | 45 mins        |                    |
| RHEL 9.6  | TBD                | TBD           | TBD        | TBD     | 45 mins        |                    |
| RHEL 8.10 | Working            | TBD           | Working    | Working | 45 mins        | 22/08/2025         |

```powershell
.\build.ps1 -Action build -Version 8 -Template rhel -Provider vmware-iso
```

```powershell
.\build.ps1 -Action build -Version 8 -Template rhel -Provider virtualbox-iso
```

---

## RockyLinux Builds

| OS  | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Qemu    | Avg Build Time | Date Last Reviewed |
|-----|--------------------|---------------|------------|---------|----------------|--------------------|
| 10  | Pending            | Pending       | Pending    | Pending | N/A            | N/A                |
| 9   | Pending            | Pending       | Pending    | Pending | N/A            | N/A                |
| 8.8 | Working            | Working       | Working    | TBD     | 15-25 mins     | 17/08/2025         |

```powershell
.\build.ps1 -Action build -Version 8 -Template rockylinux -Provider vmware-iso
```

```powershell
.\build.ps1 -Action build -Version 8 -Template rockylinux -Provider hyperv-iso
```

```powershell
.\build.ps1 -Action build -Version 8 -Template rockylinux -Provider virtualbox-iso
```

---

## Ubuntu Builds

| OS           | Hyper-V Gen 2 | VirtualBox | Qemu    | Avg Build Time | Date Last Reviewed |
|--------------|---------------|------------|---------|----------------|--------------------|
| Ubuntu 24.04 | Testing       | Testing    | Testing | 20 mins        |                    |
| Ubuntu 22.04 | Testing       | Testing    | Testing | 20 mins        |                    |

```powershell
.\build.ps1 -Action build -Version 22 -Template ubuntu -Provider hyperv-iso
```

```powershell
.\build.ps1 -Action build -Version 22 -Template ubuntu -Provider virtualbox-iso
```

```powershell
.\build.ps1 -Action build -Version 22 -Template ubuntu -Provider qemu
```

---

## Windows Builds

| OS | Firmware Type | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Avg Build Time | Date Last Reviewed |
|----|---------------|--------------------|---------------|------------|----------------|--------------------|
| 11 | UEFI          | Failing            | Working       | Failing    | 12 - 45 mins   | 26/12/2025         |
| 10 | UEFI          | Working            | Working       | Working    | 45mins - 1hr   | 10/01/2026         |
| 10 | BIOS          | Working            | N/A           | Working    | 45mins - 1hr   | 17/01/2026         |

```powershell
.\build.ps1 -Action build -Version 11 -Template windows -Provider vmware-iso
```

```powershell
.\build.ps1 -Action build -Version 11 -Template windows -Provider hyperv-iso -Generation 2
```

## Windows Notes

- Windows 10 and 11 failing on VMware (Server builds incl.) and Virtualbox due to DiskConfiguration in autounattend, need to investigate

## Windows-Server Builds

| OS              | Firmware Type | VMWare Workstation | Hyper-V Gen 2 | VirtualBox | Avg Build Time | Date Last Reviewed |
|-----------------|---------------|--------------------|---------------|------------|----------------|--------------------|
| 2025 Standard   | UEFI          | Pending            | Pending       | Pending    | N/A            | N/A                |
| 2025 Datacenter | UEFI          | Pending            | Pending       | Pending    | N/A            | N/A                |
| 2022 Standard   | UEFI          | Testing            | Testing       | Testing    | 10 - 20 mins   | 26/12/2025         |
| 2022 Datacenter | UEFI          | Testing            | Testing       | Testing    | 10 - 20 mins   | 26/12/2025         |
| 2019 Standard   | UEFI          | Testing            | Testing       | Testing    | 10 - 20 mins   | 26/12/2025         |
| 2019 Datacenter | UEFI          | Testing            | Testing       | Testing    | 10 - 20 mins   | 26/12/2025         |
| 2019 Standard   | BIOS          | Working            | N/A           | Testing    | 10 - 20 mins   | 26/12/2025         |
| 2019 Datacenter | BIOS          | Testing            | N/A           | Testing    | 10 - 20 mins   | 26/12/2025         |

```powershell
.\build.ps1 -Action build -Version 2022 -Type std -Template windows-server -Provider vmware-iso
```

```powershell
.\build.ps1 -Action build -Version 2022 -Type std -Template windows-server -Provider hyperv-iso -Generation 2
```
