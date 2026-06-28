{ config, pkgs, ... }:

{
  # Define a user account.
  users.users."erik" = {
    isNormalUser = true;
    description = "Erik Hacklin";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
    openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIGSm/ZwTLPoU3F4m1Ig0kqdjX7OI+khCnajjkzWL6BX9AAAABHNzaDo="
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILou6AeHGjiUdp6jFjBUrYBJC5g/5p8lOlDGyIMip0FN"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCQRgiTYMda0TSwVjV/5GY5KnFh4wbIwxm6BSpLchSI4s9akMWks8y/QWxRvMMFhkU9t63GU0sSXNm9ZojXTKU+CLC1cZ18wbvrq0+2KhS6yR3ALQ2uXPSY+qrfxxcqMg6R2gCFN9AIH/9u+HICham3WoIWsp/vqaAaIgodvtQJHRgEr6EiRrnHihKoupqSxCB6Od0Cc1mZu1vcB1GRe2OvYuwgxEJDy0IgDnRPos/N5/UYjp+ZoJ66y+DmJu7xolAky1HwdMNtKwuDmDxF6a9SFExN1Du2UhZw5gZDx1U+nJ4Qk3Oj0s01X6kfiDwIJ8kJJUWjPKLDhhQ2qdvLXwdCu/ufAFIkYp6GgPB61kavbF1fQrBR7k/0f+f+U0E96UbFUMqSOtikCaMzi+cTVbWoQHW4O33BUMSu098ovc29Tm7u22TFTX1shFL/YYBXxVAOGOkxSJqzJgb2eS0HmgXXA75474NINNWASl/dcOxckZmbRxlp99utoi+ZWCOv0sU="
    ];
  };
}
