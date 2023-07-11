{ config, pkgs, home, nix-colors, ... }:
{
  imports = [
  ];
	programs = {
	  fish = {
		enable = true;
		shellAbbrs = {
  			l = "less";	
		};
		shellAliases = {
			nano = "micro";
			m = "sudo micro";
			reboot = "sudo reboot";
			".." = "cd ..";
			x = "chmod a+x";
            #ls = "exa -l --icons";
			matrix = "cmatrix -abfs";
			nixswitch = "sudo nixos-rebuild switch";
			nixboot = "sudo nixos-rebuild boot";
			nixclean = "sudo nix-collect-garbage --delete-older-than 1d";
			nixflakeup = "sudo nix flake update";
		};
		shellInit = ''
			#starship init fish | source
			set -U fish_greeting
			'';
	  };
	  /*
	  oh-my-posh = {
	  	enable = true;
	  	enableBashIntegration = true;
  	    enableFishIntegration = true;
  	    useTheme = "dracula";
  	    
	  };
	  */
	  starship = {
  	    enable = true;
  	    enableBashIntegration = true;
  	    enableFishIntegration = true;
  	    enableTransience = false;
  	    settings = {
     	  "$schema" = "https://starship.rs/config-schema.json";
  	      add_newline = true;
  	      scan_timeout = 10;
  	      format = "$all";
  	      character = {
			success_symbol = "[](bold red)[](bold green)[](bold yellow)";
			error_symbol = "[](bold red)[](bold green)[](bold yellow)";
			#success_symbol = "[🐟](bold green)"
			#success_symbol = "[ ](bold blue)"
  	      };
  	      package = {
  	    	disabled = true;
  	      };
  	      sudo = {
  	    	style = "bold green";
  	    	symbol = "🧙 ";
  	    	disabled = true;
  	      };
  	      nix_shell = {
  	    	disabled = false;
			symbol = " ";
  	    	impure_msg = "[impure shell](bold red)";
  	    	pure_msg = "[pure shell](bold green)";
  	    	unknown_msg = "[unknown shell](bold yellow)";
  	    	format = "via [☃️ $state( \($name\))](bold blue) ";
  	      };
  	  };
  };
};
}


