packer {
  required_plugins {
    vmware = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/vmware"
    }
    virtualbox = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/virtualbox"
    }
    hyperv = {
      version = ">= 1.1.4"
      source  = "github.com/hashicorp/hyperv"
    }
    qemu = {
      version = ">= 1.1.3"
      source  = "github.com/hashicorp/qemu"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.1.3"
    }
    docker = {
      source  = "github.com/hashicorp/docker"
      version = ">= 1.1.1"
    }
  }
}
