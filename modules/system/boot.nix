{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false; # Prevent boot entry editing from gaining root access
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Plymouth boot splash (also handles LUKS password prompt)
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true; # Required for plymouth to handle LUKS prompt

  # Silent boot — suppress kernel messages for a clean splash experience
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];

  # LUKS encrypted root partition (NVMe SSD)
  boot.initrd.luks.devices."luks-c634cc00-b728-43a2-9df7-cb6e0d0d6fc8".device = "/dev/disk/by-uuid/c634cc00-b728-43a2-9df7-cb6e0d0d6fc8";
}
