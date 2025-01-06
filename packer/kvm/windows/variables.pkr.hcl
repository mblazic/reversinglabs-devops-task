variable "iso_url" {
  type    = string
  default = "images/win10-base.iso" #http://download.microsoft.com/download/C/3/9/C399EEA8-135D-4207-92C9-6AAB3259F6EF/10240.16384.150709-1700.TH1_CLIENTENTERPRISEEVAL_OEMRET_X64FRE_EN-US.ISO
}

variable "iso_checksum" {
  type    = string
  default = "none" #sha256:a6f470ca6d331eb353b815c043e327a347f594f37ff525f17764738fe812852e
}

variable "output_directory" {
  type    = string
  default = "win10-kvm"
}

variable "disk_size" {
  type    = string
  default = "30720"
}

variable "disk_compression" {
  type    = string
  default = "true"
}

variable "disk_interface" {
  type    = string
  default = "virtio"
}

variable "memory_size" {
  type    = string
  default = "4096"
}

variable "cpus" {
  type    = string
  default = "1"
}

variable "net_device" {
  type    = string
  default = "virtio-net"
}

variable "headless" {
  type    = string
  default = "true"
}

variable "format" {
  type    = string
  default = "qcow2"
}

variable "accelerator" {
  type    = string
  default = "kvm"
}

variable "shutdown_command" {
  type    = string
  default = "%WINDIR%/system32/sysprep/sysprep.exe /generalize /oobe /shutdown /unattend:C:/Windows/Temp/Autounattend.xml"
}

variable "communicator" {
  type    = string
  default = "winrm"
}

variable "winrm_insecure" {
  type    = string
  default = "true"
}

variable "winrm_password" {
  type    = string
  default = "winrm"
}

variable "winrm_timeout" {
  type    = string
  default = "120m"
}

variable "winrm_use_ssl" {
  type    = string
  default = "true"
}

variable "winrm_username" {
  type    = string
  default = "winrm"
}

variable "boot_wait" {
  type    = string
  default = "20s"
}

variable "autounattend" {
  type    = string
  default = "./answer_files/10/Autounattend.xml"
}
