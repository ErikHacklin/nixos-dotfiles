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
	};
	stylix.targets.firefox.profileNames = [ "default" ];
}
