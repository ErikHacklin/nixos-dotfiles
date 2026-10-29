# /etc/nixos/modules/system/sops.nix
#
# sops-nix integration. Secrets live in a SEPARATE repo
# (~/Repositories/nixos-secrets, remote git.erikhacklin.fi). This module only
# tells sops-nix where athena's decryption identity is and installs the CLI.
#
# Decryption identity: athena derives an age key from its SSH host key
# (/etc/ssh/ssh_host_ed25519_key). That key's PUBLIC recipient must be enrolled
# in the secrets repo's .sops.yaml before any secret can be decrypted here:
#
#     ssh-to-age < /etc/ssh/ssh_host_ed25519_key.pub   # run on athena
#
# Add that age1... value to .sops.yaml, `sops updatekeys secrets/*.yaml`, commit.
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sops          # edit/encrypt/decrypt secrets
    age           # age keygen / primitives
    ssh-to-age    # derive an age recipient from an SSH key
  ];

  sops = {
    # Use athena's SSH host key as the age identity. sops-nix converts it to an
    # age key automatically; no separate private key to manage on the box.
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    # Do NOT generate a standalone age key — the SSH host key is the identity.
    age.generateKey = false;

    # Secrets live outside the Nix store (string sopsFile paths, see below), so
    # the default eval-time validation — which only works for in-store files —
    # must be disabled. sops-nix reads and validates the file at activation
    # instead, on athena where the secrets repo is checked out.
    validateSopsFiles = false;

    # erik's login password HASH (not plaintext). Stored in the secrets repo and
    # consumed by users.users.erik.hashedPasswordFile in users.nix.
    #
    # neededForUsers = true: user accounts are created very early in activation,
    # before normal secrets are mounted. This flag makes the secret available in
    # time, decrypting it to /run/secrets-for-users/. Such secrets are root-only
    # by design, so no owner/mode is set here.
    #
    # sopsFile is a STRING (not a Nix path), so the encrypted file is NOT copied
    # into the nix store and is read at activation time on athena. This requires
    # the secrets repo to be checked out at this path on the machine.
    secrets."erik/hashedPassword" = {
      sopsFile = "/home/erik/Repositories/nixos-secrets/secrets/users.yaml";
      neededForUsers = true;
    };
  };
}
