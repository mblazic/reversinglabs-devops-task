packer {
  required_plugins {
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }

    windows-update = {
      version = "0.16.8"
      source  = "github.com/rgl/windows-update"
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
  net_device         = var.net_device
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
  floppy_files       = ["${var.autounattend}", "./scripts/0-firstlogin.bat", "./scripts/1-fixnetwork.ps1", "./scripts/70-install-misc.bat", "./scripts/50-enable-winrm.ps1", "./answer_files/firstboot/Firstboot-Autounattend.xml", "./drivers/"]
  qemuargs           = [["-vga", "qxl"]]
}


build {
  sources = ["source.qemu.windows_10_kvm"]

  provisioner "windows-shell" {
    execute_command = "{{ .Vars }} cmd /c C:/Windows/Temp/script.bat"
    remote_path     = "c:/Windows/Temp/script.bat"
    scripts         = ["./scripts/70-install-misc.bat", "./scripts/80-compile-dotnet-assemblies.bat"]
  }

  # Reboot after doing our first stages
  # This is to give the windows-update provisioner a chance
  # As it will seemingly hang on TiWorker.exe siting around idling
  # (This is due to registry changes in the first stage seemignly not having
  # efect until a reboot has happened)
  provisioner "windows-restart" {
    restart_check_command = "powershell -command \"& {Write-Output 'restarted.'}\""
  }

  provisioner "windows-update" {
  }

  # Without this step, your images will be ~12-15GB
  # With this step, roughly ~8-9GB
  provisioner "windows-shell" {
    execute_command = "{{ .Vars }} cmd /c C:/Windows/Temp/script.bat"
    remote_path     = "c:/Windows/Temp/script.bat"
    scripts         = ["./scripts/90-compact.bat"]
  }
}
