{ pkgs, ... }:
{
    users.users.erik = {
        isNormalUser = true;
        description = "Erik Hacklin";
        extraGroups = [ "networkmanager" "wheel" ];
        openssh.authorizedKeys.keys = [
            "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCQRgiTYMda0TSwVjV/5GY5KnFh4wbIwxm6BSpLchSI4s9akMWks8y/QWxRvMMFhkU9t63GU0sSXNm9ZojXTKU+CLC1cZ18wbvrq0+2KhS6yR3ALQ2uXPSY+qrfxxcqMg6R2gCFN9AIH/9u+HICham3WoIWsp/vqaAaIgodvtQJHRgEr6EiRrnHihKoupqSxCB6Od0Cc1mZu1vcB1GRe2OvYuwgxEJDy0IgDnRPos/N5/UYjp+ZoJ66y+DmJu7xolAky1HwdMNtKwuDmDxF6a9SFExN1Du2UhZw5gZDx1U+nJ4Qk3Oj0s01X6kfiDwIJ8kJJUWjPKLDhhQ2qdvLXwdCu/ufAFIkYp6GgPB61kavbF1fQrBR7k/0f+f+U0E96UbFUMqSOtikCaMzi+cTVbWoQHW4O33BUMSu098ovc29Tm7u22TFTX1shFL/YYBXxVAOGOkxSJqzJgb2eS0HmgXXA75474NINNWASl/dcOxckZmbRxlp99utoi+ZWCOv0sU="
        ];
    };
}