# KVM 

## DESCRIPTION

Install KVM Hypervisor on Ubuntu, Debian, CentOS or RHEL

## REQUIREMENTS

### OS

* Ubuntu (tested)
* Debian
* CentOS (tested host)
* RHEL

### Cookbooks

* sysctl: https://github.com/Youscribe/sysctl-cookbook
* modules: https://github.com/Youscribe/modules-cookbook
* sysfs: https://github.com/Youscribe/sysfs-cookbook
* cpu: https://github.com/Youscribe/cpu-cookbook

## USAGE

### Default recipe

Detect the server role from OHAI : host or guest. And install minimum packages.
For security, the default recipe doesn't install a kvm server, you need to install it with kvm::host

### host recipe

Install minimum packages and configuration to do kvm virtualization.

### guest recipe

Install minimum packages and configuration for a kvm guest.

### host-tuning recipe

Install packages and configuration to enhance your kvm host.

* Set vm.swappiness = 0 if the kernel < 3.5 and cpu has ept flag.
* Load vhost_net module on Ubuntu/debian to speed up networking.
* Avoid cpu frequency change to prevent potential clock drifting.
* Enable transparent huge pages

### guest-tuning recipe

Install packages and configuration to enhance your kvm guest.

* Change the block IO scheduler according to the attribute default["kvm"]["guest"]["tuning"]["io_scheduler"]. By the default the noop scheduler is used.
