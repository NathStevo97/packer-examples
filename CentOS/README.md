# CentOS Packer Builds

| OS              | VMWare Workstation     | VirtualBox            | Date Last Tested |
|-----------------|------------------------|-----------------------|------------------|
| CentOS Stream 9 | Working  (~40 mins)    | Working (~24 minutes) | 17/05/2023       |
| CentOS Stream 8 | Working  (~1hr 5mins)  | Working (~45 minutes) | 17/05/2023       |
| CentOS 7        | Working  (~20 minutes) | Working  (~40 mins)   | 17/05/2023       |

## Notes

- The CentOS Stream 9 Build will not work for Virtualbox versions lower than 7.0.
  - [Reference](https://access.redhat.com/discussions/6960369)
- As of Virtualbox 7.0, an additional command is needed to the `vboxmanage` attribute to allow the HTTP directory to get picked up.
  - [Reference](https://github.com/hashicorp/packer/issues/12118)
