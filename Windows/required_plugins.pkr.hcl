packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.7"
      source  = "github.com/hashicorp/vmware"
    }

    virtualbox = {
      version = ">= 1.0.4"
      source  = "github.com/hashicorp/virtualbox"
    }

    hyperv = {
      version = ">= 1.1.3"
      source  = "github.com/hashicorp/hyperv"
    }
  }
}