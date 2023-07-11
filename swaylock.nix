{ config, pkgs, home, nix-colors, ... }:
#with import <nixpkgs> {};
#with lib;
{
  imports = [
  ];

	programs.swaylock = {
		enable = true;
	    package = pkgs.swaylock-effects;
		settings = {
			image = "/etc/nixos/wall.png";
			hide-keyboard-layout = true;
			indicator-radius = 115; 
			indicator-thickness = 7; 
			ring-color = "#${config.colorScheme.colors.base05}";
			ring-ver-color = "#${config.colorScheme.colors.base0A}"; 
			ring-wrong-color = "#${config.colorScheme.colors.base08}"; 
			ring-clear-color = "#${config.colorScheme.colors.base0A}"; 
			key-hl-color = "#${config.colorScheme.colors.base00}"; 
			bs-hl-color = "#${config.colorScheme.colors.base00}"; 
			text-color = "#${config.colorScheme.colors.base00}"; 
			text-caps-lock-color = "#${config.colorScheme.colors.base00}"; 
			line-color = "#00000000";
			line-ver-color = "#00000000"; 
			line-wrong-color = "#00000000";  
			line-clear-color = "#00000000";  
			separator-color = "#00000000";  
			inside-color = "#${config.colorScheme.colors.base05}"; 
			inside-ver-color = "#${config.colorScheme.colors.base04}"; 
			inside-wrong-color = "#${config.colorScheme.colors.base08}"; 
			inside-clear-color = "#${config.colorScheme.colors.base0A}"; 
			color = "#00000000";  
			effect-pixelate = 40;
			effect-blur = "7x5";
			effect-vignette = "0.5:0.5"; 
			clock = true;
			indicator = true;
#			scaling = fill;
			font = "JetBrains Mono Nerd";
			font-size = 20;
		};
	};
}


