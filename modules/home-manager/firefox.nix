{ pkgs, ... }:
{
	programs.firefox = {
		enable = true;
		policies = {
			ExtensionSettings = {
				# Keeper Password Manager
				"KeeperFFStoreExtension@KeeperSecurityInc" = {
					installation_mode = "force_installed";
					install_url = "https://addons.mozilla.org/firefox/downloads/latest/keeper-password-manager/latest.xpi";
				};
			};
		};
		profiles = {
			default = {
				bookmarks = {
					force = true;
					settings = [
						{
							name = "Nix sites";
							toolbar = true;
							bookmarks = [
								{
									name = "NixOS Search";
									url = "https://search.nixos.org/options?";
								}
								{
									name = "Home Manager Options";
									tags = [ "wiki" "nix" ];
									url = "https://home-manager-options.extranix.com/?query=&release=master";
								}
							];
						}
					];
				};
			};
		};
	};
	stylix.targets.firefox.profileNames = [ "default" ];
}
