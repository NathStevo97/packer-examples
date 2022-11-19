| OS                      | VMWare Workstation | Hyper-V Gen 1* | Hyper-V Gen 2* | VirtualBox |
|-------------------------|--------------------|---------------|---------------|------------|
| Windows 11              | Working            | Working       | Pending       | Working    |
| Windows 10              | Working            | Working       | Working       | Working    |
| Windows 2022 Standard   | Working            | Working       | Working       | Working    |
| Windows 2022 Datacenter | Working            | Working       | Working       | Working    |
| Windows 2019 Standard   | Working            | Working       | Working       | Working    |
| Windows 2019 Datacenter | Working            | Working       | Working       | Working    |
| Windows 2016 Standard   | Working            | Working       | Working       | Working    |
| Windows 2016 Datacenter | Working            | Working       | Working       | Working    |

* Hyper-V As of Packer 1.8.4 and Hyper-V plugin version 1.0.4, builds are being extremely temperamental - producing errors "failing to get host adapter IP addresses" - attempted to self-resolve but I'm unsure if this is a wider issue.
