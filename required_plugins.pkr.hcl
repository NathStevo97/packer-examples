packer {
  required_plugins {
    vmware = {
      version = ">= 2.1.3"
      source  = "github.com/hashicorp/vmware"
    }
    virtualbox = {
      version = ">= 1.1.4"
      source  = "github.com/hashicorp/virtualbox"
    }
    hyperv = {
      version = ">= 1.1.5"
      source  = "github.com/hashicorp/hyperv"
    }
    qemu = {
      version = ">= 1.1.5"
      source  = "github.com/hashicorp/qemu"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.1.5"
    }
    docker = {
      source  = "github.com/hashicorp/docker"
      version = ">= 1.1.3"
    }
  }
}
