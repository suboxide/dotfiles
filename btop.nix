{ config, pkgs, home, nix-colors, ... }:
{
  imports = [
  ];

	programs.btop = {
		enable = true;
		settings = {
			color_theme = "dracula";
			theme_background = false;
			rounded_corners = true;
		};
	};
}


