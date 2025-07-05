{ pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
			general = {
				hide_cursor = true;
			};
			background = {
				path = "screenshot";
				blur_passes = 2;
				blur_size = 6;
			};
    };
  };
}
