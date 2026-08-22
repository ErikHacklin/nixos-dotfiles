{ config, pkgs, ... }:

{
  # Intel GPU - hardware video acceleration (VA-API)
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # iHD driver for Kaby Lake+
      vpl-gpu-rt         # Intel Video Processing Library
    ];
  };

  # Intel thermal management - prevents excessive throttling on thin laptops
  services.thermald.enable = true;

  # Firmware updates via fwupd
  services.fwupd.enable = true;

  # Enable redistributable firmware (WiFi, Bluetooth, etc.)
  hardware.enableRedistributableFirmware = true;
}
