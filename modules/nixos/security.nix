{ ... }:
{
  # Enable security features.
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo = {
      execWheelOnly = true; # Only allow users in the wheel group to run sudo.
      wheelNeedsPassword = true;
    };
  };
}