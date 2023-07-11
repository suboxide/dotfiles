{ config, pkgs, nix-colors, ... }:
{
  imports = [
 # 	(fetchGit { url = "https://github.com/Exaltia/shadow-nix"; ref = "master"; rev = "b0ceabc3febadc9184e3c50ede8261ddbfdc1808"; } + "/import/home-manager.nix")
	./sway.nix
	./swaylock.nix
	./wlogout.nix
	./btop.nix
	./fish.nix
	./kitty.nix
	./rofi.nix
	./waybar.nix
	./wayvnc.nix
	./wob.nix
	./swaync.nix
    nix-colors.homeManagerModules.default
  ];

  colorScheme = nix-colors.colorSchemes.dracula;
  gtk = {
	enable = true;
	cursorTheme.name = "phinger-cursors-light";
	cursorTheme.size = 24;
	font.name = "JetBrains Mono Nerd";
	font.size = 10;
	iconTheme.name = "Dracula";
	theme.name = "Dracula";
  };

  home = {
	username = "sub";
	homeDirectory = "/home/sub";
	packages = with pkgs; [
    	htop
    	cmatrix
  	];
  };

  services = {
  	caffeine.enable = true;
  	#copyq.enable = true;
  	home-manager.autoUpgrade.enable = true;
  	home-manager.autoUpgrade.frequency = "weekly";
  	unclutter.enable = true;
  	unclutter.timeout = 1;
  	};

  programs = {
  	home-manager.enable = true;
  	git = {
    	enable = true;
    	userName = "Sebastien Brouwers";
    	userEmail = "suboxide@gmail.com";
  	};
  	gh = {
  		enable = true;
  		# To figure out
  	};
  	/*
  	autojump = {
  		enable = true;
  		enableBashIntegration = true;
  		enableFishIntegration = true;
  	};
  	*/
  	pazi = {
  		enable = true;
  		enableBashIntegration = true;
  		enableFishIntegration = true;
  	};
  	broot = {
  		enable = true;
  		enableBashIntegration = true;
  		enableFishIntegration = true;
  		settings = {};
  	};
  	exa = {
  		enable = true;
  		enableAliases = true;
  		extraOptions = [
  		  "--group-directories-first"
  		  "--header"
  		];
  		git = true;
  		icons = true;
  	};
  	feh = {
  		enable = true;	
  	};
  	fzf = {
  		enable = true;
  		enableBashIntegration = true;
  		enableFishIntegration = true;
  	};
  	imv = {
  		enable = true;
  		settings = {
	  		options.background = "ffffff";
			aliases.x = "close";
		};
  	};
  	micro = {
  		enable = true;
  		settings = {
  			autosu = true;
  			clipboard = "terminal";
  			cursorline = false;
  			colorscheme = "simple";
  			
  		};
  	};
  	navi = {
  		enable = true;
  		enableBashIntegration = true;
  		enableFishIntegration = true;
  	};
  	nix-index = {
  		enable = true;
  		enableBashIntegration = true;
  		enableFishIntegration = true;
  	};
  	nnn = {
  		enable = true;
  		bookmarks = {
  			d = "~/Documents";
  			D = "~/Downloads";
  			p = "~/Pictures";
  		};
  		extraPackages = with pkgs; [ ffmpegthumbnailer mediainfo sxiv ];
  	};
  };
       	
  home.stateVersion = "23.05";
}
