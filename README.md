# Packer Examples

| OS                      | VMWare Workstation | Hyper-V Gen 1 | Hyper-V Gen 2 | VirtualBox | Qemu    | Date Last Tested |
|-------------------------|--------------------|---------------|---------------|------------|---------|------------------|
| Alma Linux 9            | Working            | TBD           | TBD           | Working    | TBD     | 14/09/2023       |
| CentOS 7                | Working            | TBD           | TBD           | Working    | TBD     | 15/09/2023       |
| CentOS Stream 8         | Working            | TBD           | TBD           | Working    | TBD     | 16/09/2023       |
| CentOS Stream 9         | Working            | TBD           | TBD           | Working    | TBD     | 16/09/2023       |
| Debian 12               | Working            | TBD           | TBD           | Working    | TBD     | 14/09/2023       |
| Kali Linux 2023         | Failing            | TBD           | TBD           | Failing    | TBD     | 15/09/2023       |
| OpenSUSE 15             | TBD                | TBD           | TBD           | Working    | TBD     | 15/09/2023       |
| Oracle 7.9              | Working            | TBD           | TBD           | TBD        | TBD     | 15/09/2023       |
| Oracle 8.6              | Working            | TBD           | TBD           | TBD        | TBD     | 15/09/2023       |
| Oracle 9.0              | Working            | TBD           | TBD           | TBD        | TBD     | 15/09/2023       |
| RHEL 7.9                | Working            | TBD           | TBD           | Working    | Working | 16/09/2023       |
| RHEL 8.1                | Working            | TBD           | TBD           | Working    | Working | 16/09/2023       |
| Rocky Linux 8.6         | Working            | TBD           | TBD           | Working    | TBD     | 15/09/2023       |
| Ubuntu 22               | TBD                | TBD           | TBD           | Working    | TBD     | 15/09/2023       |
| Windows 10              | Working            | TBD           | TBD           | Working    | TBD     | 12/02/2023       |
| Windows 11              | Working            | TBD           | TBD           | Working    | TBD     | 12/02/2023       |
| Windows 2022 Standard   | Working            | TBD           | TBD           | Working    | TBD     | 12/02/2023       |
| Windows 2022 Datacenter | Working            | TBD           | TBD           | Working    | TBD     | 12/02/2023       |
| Windows 2019 Standard   | Working            | TBD           | TBD           | Working    | TBD     | 12/02/2023       |
| Windows 2019 Datacenter | Working            | TBD           | TBD           | Working    | TBD     | 12/02/2023       |
| Windows 2016 Standard   | Working            | TBD           | TBD           | Working    | TBD     | 12/02/2023       |
| Windows 2016 Datacenter | Working            | TBD           | TBD           | Working    | TBD     | 12/02/2023       |

---

## ToDos & Notes

- Kali Linux builds failing during base OS software install, likely an ISO upgrade needed and/or ensuring a secure connection during installation.
- RHEL Builds showing a lot of undeclared / unused variables.
- Re-check Windows Hyper-V Builds as the plugins have recently been upgraded
- Point all build output directories to root "builds" directory in repo
- Make headless a variable across all builds with default value of true
- Try to reworl CentOS builds to use boot isos for ease