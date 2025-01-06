packer {
  required_plugins {
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "windows_10_kvm" {
  iso_url            = var.iso_url
  iso_checksum       = var.iso_checksum
  output_directory   = var.output_directory
  disk_size          = var.disk_size
  disk_compression   = var.disk_compression
  disk_interface     = var.disk_interface
  memory             = var.memory_size
  cpus               = var.cpus
  headless           = var.headless
  format             = var.format
  accelerator        = var.accelerator
  shutdown_command   = var.shutdown_command
  communicator       = var.communicator
  winrm_insecure     = var.winrm_insecure
  winrm_password     = var.winrm_password
  winrm_timeout      = var.winrm_timeout
  winrm_use_ssl      = var.winrm_use_ssl
  winrm_username     = var.winrm_username
  boot_wait          = var.boot_wait
  floppy_files       = ["./answer_files/10/Autounattend.xml", "./scripts/0-firstlogin.bat", "./scripts/1-fixnetwork.ps1", "./scripts/50-enable-winrm.ps1", "./answer_files/firstboot/Firstboot-Autounattend.xml", "./drivers/"]
  qemuargs           = [
                       ["-vga", "qxl"],
                       ["-netdev", "tap,id=net0,ifname=tap0,script=no,downscript=no"],
                       ["-device", "virtio-net-pci,netdev=net0"]
  ]
}

build {
  sources = ["source.qemu.windows_10_kvm"]

  provisioner "windows-shell" {
    execute_command = "{{ .Vars }} cmd /c C:/Windows/Temp/script.bat"
    remote_path     = "c:/Windows/Temp/script.bat"
    scripts         = ["./scripts/80-compile-dotnet-assemblies.bat"]
  }

  # Without this step, images will be ~12-15GB
  # With this step, roughly ~8-9GB
  provisioner "windows-shell" {
    execute_command = "{{ .Vars }} cmd /c C:/Windows/Temp/script.bat"
    remote_path     = "c:/Windows/Temp/script.bat"
    scripts         = ["./scripts/90-compact.bat"]
  }
}
