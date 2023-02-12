| OS                      | VMWare Workstation | Hyper-V Gen 1* | Hyper-V Gen 2* | VirtualBox      | Date Last Tested |
|-------------------------|--------------------|----------------|----------------|-----------------|------------------|
| Windows 11              | Working            | TBD            | TBD            | Pending Testing | 12/02/2023       |
| Windows 10              | Working            | TBD            | TBD            | Pending Testing | 12/02/2023       |
| Windows 2022 Standard   | Working            | TBD            | TBD            | Pending Testing | 12/02/2023       |
| Windows 2022 Datacenter | Working            | TBD            | TBD            | Pending Testing | 12/02/2023       |
| Windows 2019 Standard   | Working            | TBD            | TBD            | Pending Testing | 12/02/2023       |
| Windows 2019 Datacenter | Working            | TBD            | TBD            | Pending Testing | 12/02/2023       |
| Windows 2016 Standard   | Working            | TBD            | TBD            | Pending Testing | 12/02/2023       |
| Windows 2016 Datacenter | Working            | TBD            | TBD            | Pending Testing | 12/02/2023       |


* Hyper-V As of Packer 1.8.5 and Hyper-V plugin version 1.0.4, builds are being extremely temperamental - producing errors "failing to get host adapter IP addresses" - Noted to be a wider issue with hidden network adapters not getting picked up by Packer 
  - aiming to either provide guidance on how to run from the base plugin code as it doesn't appear a new release of the plugin is due any time soon.
