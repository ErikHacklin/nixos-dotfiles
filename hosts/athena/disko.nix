# /etc/nixos/hosts/athena/disko.nix
{ ... }:

{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        # VERIFY with `lsblk` in the installer — NVMe is typically /dev/nvme0n1
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              size = "1G";              # 1 GiB — lanzaboote stores signed generations here
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";        # → /dev/mapper/crypted
                settings = {
                  allowDiscards = true;  # TRIM passthrough for the NVMe SSD
                };
                # No keyFile here → disko prompts for a passphrase interactively
                # at format time. That passphrase becomes the permanent fallback keyslot.
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
          };
        };
      };
    };

    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          # Swap first, fixed size; btrfs takes the rest.
          swap = {
            size = "20G";               # 16 GiB RAM + headroom for hibernation
            content = {
              type = "swap";
              resumeDevice = true;       # wires boot.resumeDevice for hibernation
              discardPolicy = "both";
            };
          };

          root = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
              };
            };
          };
        };
      };
    };
  };
}
