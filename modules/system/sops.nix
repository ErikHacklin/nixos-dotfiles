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

    # Default sops file. Individual secrets can override `sops.secrets.<name>.sopsFile`.
    # Point this at a checked-out path of the secrets repo once it is cloned on
    # athena, e.g. "/home/erik/Repositories/nixos-secrets/secrets/athena.yaml".
    #
    # defaultSopsFile = /home/erik/Repositories/nixos-secrets/secrets/athena.yaml;

    # Declare secrets here as you add them. Example (commented until you have a
    # real secret and athena is enrolled as a recipient):
    #
    # secrets."example_token" = {
    #   sopsFile = /home/erik/Repositories/nixos-secrets/secrets/example.yaml;
    #   # owner = "erik";
    #   # mode = "0400";
    # };
  };
}
