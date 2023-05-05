# Packer Examples

## A Note on Hyper-V:

- For whatever reason, there doesn't seem to be any plans for a release beyond version 1.0.4 for the [packer-hyperv-plugin](https://github.com/hashicorp/packer-plugin-hyperv). This is quite problematic as it contains a bug that prevents usage on Windows 11. This bug has been resolved in an unreleased commit.
- As a workaround, adhere to the following steps:
  1. Clone the repo linked above to a folder of your choice.
  1. Ensure you have [Go](https://go.dev/) installed.
  1. In the cloned plugin repository, run `go build`
  1. Copy the created `.exe` file to either the Packer working directory or the system's plugins folder - refer to the documentation for advice on where this should be.
     1. [Packer Home Directory](https://developer.hashicorp.com/packer/docs/configure#packer-s-home-directory)
     1. [Plugin Documentation](https://developer.hashicorp.com/packer/docs/plugins/install-plugins)

- Once a new release is available, simply add the hyper-v plugin to the `required_plugins.pkr.hcl` file as normal.


## ToDos
## P1

- Force-downgrade of Hyper-V plugin to version 1.0.1 to attempt to resolve regression issue noted [here](https://github.com/hashicorp/packer-plugin-hyperv/issues/65)
- Check if this resolves issues - dowgrade packer to around 1.7.0 if not or wait for Plugin update to fix (or try downloading and editing manually if it's just a case of hidden network adaptors not showing as another issue seemed to suggest?)

## P2

- Test out QEMU Usage
- Try get VirtualBox (amongst other providers) working for Linux-based images.

## P3

- Add more OSs (Fedora and Debian?)
