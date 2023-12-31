# Packer Examples

| OS                      | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox      | Qemu    | Date Last Tested | Avg Build Time |
|-------------------------|--------------------|---------------|---------------|-----------------|---------|------------------|----------------|
| Alma Linux 9            | Working            | TBD           | TBD           | Working         | TBD     | 27/12/2023       | 15 - 30 mins   |
| CentOS 7                | Working            | TBD           | TBD           | Failing         | TBD     | 27/12/2023       | 22 mins        |
| CentOS Stream 8*        | Changes Pending    | TBD           | TBD           | Changes Pending | TBD     | 16/09/2023       |                |
| CentOS Stream 9*        | Changes Pending    | TBD           | TBD           | Changes Pending | TBD     | 16/09/2023       |                |
| Debian 12               | Failing            | TBD           | TBD           | Failing         | TBD     | 27/12/2023       |                |
| OpenSUSE 15             | TBD                | TBD           | TBD           | Working         | TBD     | 27/12/2023       | 17 mins        |
| Oracle 7.9              | Working            | TBD           | TBD           | TBD             | TBD     | 27/12/2023       | 25 mins        |
| Oracle 8.6              | Failing            | TBD           | TBD           | TBD             | TBD     | 27/12/2023       |                |
| Oracle 9.0              | Failing            | TBD           | TBD           | TBD             | TBD     | 27/12/2023       |                |
| RHEL 7.9                | Working            | TBD           | TBD           | Working         | Working | 16/09/2023       |                |
| RHEL 8.1                | Working            | TBD           | TBD           | Working         | Working | 16/09/2023       |                |
| Rocky Linux 8.6         | Failing            | TBD           | TBD           | Failing         | TBD     | 27/12/2023       |                |
| Ubuntu 22               | TBD                | TBD           | TBD           | Working         | TBD     | 27/12/2023       | 35 mins        |
| Windows 10              | Working            | Working       | Working       | Working         | TBD     | 28/12/2023       | 45mins - 1hr   |
| Windows 11              | Working            | Failing       | TBD           | Working         | TBD     | 28/12/2023       | 12 - 45 mins   |
| Windows 2022 Standard   | Working            | Working       | Working       | Working         | TBD     | 28/12/2023       | 10 - 20 mins   |
| Windows 2022 Datacenter | Working            | Working       | Working       | Working         | TBD     | 28/12/2023       | 10 - 20 mins   |
| Windows 2019 Standard   | Working            | Working       | Working       | Working         | TBD     | 28/12/2023       | 10 - 20 mins   |
| Windows 2019 Datacenter | Working            | Working       | Working       | Working         | TBD     | 28/12/2023       | 10 - 20 mins   |
| Windows 2016 Standard   | Working            | Working       | Working       | Working         | TBD     | 28/12/2023       | 10 - 20 mins   |
| Windows 2016 Datacenter | Working            | Working       | Working       | Working         | TBD     | 28/12/2023       | 10 - 20 mins   |

---

## ToDos & Notes

### CentOS

- *Try to rework CentOS builds to use boot isos for ease - saves storing the ~10Gb Net Install ISOs locally
- CentOS 7 Virtualbox Build Getting Stuck at Boot
- Stream 8 and 9 need ISO pre-downloaded currently

### Debian

- All platforms getting stuck at boot

### Oracle

- Oracle 8 - Line 24 Kickstart File - Unsupported hardware error
- Oracle 9 - Getting stuck at boot launch

### RHEL

- RHEL 7 and RHEL 8 Needs ISO predownloaded

- Fix up Windows 11 Build for Hyper-V

### Rocky Linux

- Getting Stuck at Boot Launch

### Windows

- Windows 10 Autounattend script needs to not include windows update script, only winRM.
- Windows 11 failing in Hyper-V  due to compatability issues