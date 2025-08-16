{ ... }:

{
  services.displayManager.gdm.enable = true;
  services.displayManager.autoLogin = {
    enable = true;
    user = "erik"; 
  };
}
