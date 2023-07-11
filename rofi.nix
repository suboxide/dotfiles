{ config, pkgs, home, nix-colors, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in {
  imports = [
  ];

	programs.rofi = {
		enable = true;
		package = pkgs.rofi-wayland;
		cycle = true;
		font ="JetBrainsMono Nerd Font 11";
		extraConfig = {
        modi = "drun,emoji,calc,ssh,filebrowser,run,keys"; # custom mode <name>:<script>
        show-icons = true;
        location = 0;
        icon-theme= "Papirus"; #Papirus fluent-dark
        steal-focus = true;
        matching = "fuzzy"; # regex glob
        drun-match-fields = "name,generic,categories,keywords";
        drun-display-format = "{name}";
        threads = 0;
		scroll-method = 0;
		disable-history = false;
	    window-thumbnail =  true;
	    hover-select = true;
        sorting-method = "fzf"; # levenshtein
        drun-url-launcher = "xdg-open";
        click-to-exit = true;
        terminal = "kitty";
        };
        plugins = with pkgs; [
          rofi-calc
          rofi-emoji
        ];
        theme = {
          "*" = {
            trans = mkLiteral "#00000000";
            cur = mkLiteral "#${config.colorScheme.colors.base08}";
            bg = mkLiteral "#${config.colorScheme.colors.base00}36";
            bgw = mkLiteral "#${config.colorScheme.colors.base02}79";
            bgb = mkLiteral "#${config.colorScheme.colors.base00}59"; 
            fg = mkLiteral "#${config.colorScheme.colors.base07}";
            red = mkLiteral "#${config.colorScheme.colors.base08}";
            grn = mkLiteral "#${config.colorScheme.colors.base0A}";
            grntrans = mkLiteral "#${config.colorScheme.colors.base0A}4f";
            yel = mkLiteral "#${config.colorScheme.colors.base0B}";
            blu = mkLiteral "#${config.colorScheme.colors.base0D}";
            pur = mkLiteral "#${config.colorScheme.colors.base09}";
            cya = mkLiteral "#${config.colorScheme.colors.base0C}";
            ora = mkLiteral "#${config.colorScheme.colors.base05}";
            foreground = mkLiteral "@fg";
            background = mkLiteral "@bg";
            active-background = mkLiteral "@blu";
            urgent-background = mkLiteral "@red";
            selected-background = mkLiteral "@active-background";
            selected-urgent-background = mkLiteral "@urgent-background";
            selected-active-background = mkLiteral "@active-background";
            selected-foreground = mkLiteral "@bg";
            separatorcolor = mkLiteral "@active-background";
            bordercolor = mkLiteral "@pur";
            background-color = mkLiteral "@background";
          };
          "window" = {
            transparency = "real";
            background-color = mkLiteral "@trans";
            text-color = mkLiteral "@fg";
            location = mkLiteral "north";
			anchor = mkLiteral "northwest";
			fullscreen = mkLiteral "true";	
          };
          "prompt" = {
            enabled = mkLiteral "false";
          };
          "button" = {
          	action = "ok";
          	str = " ";
            margin = mkLiteral "1px 0px 8px 8px";
          	expand =  mkLiteral "false";
          	text-color = mkLiteral "@fg";
          	background-color =  mkLiteral "@trans";
          	vertical-align = mkLiteral "0.7";
          	horizontal-align = mkLiteral "0.5";
          };
          "entry" = {
          	background-color = mkLiteral "@trans";
          	text-color = mkLiteral "@fg";
          	expand = mkLiteral "true";
          	vertical-align = mkLiteral "0.55";
          	horizontal-align = mkLiteral "0.0";
          	placeholder = "Search";
          	placeholder-color = mkLiteral "@fg";
          	blink = mkLiteral "true";
          };
          "case-indicator" = {
          	background-color = mkLiteral "@trans";
          	text-color = mkLiteral "@fg";
          	vertical-align = mkLiteral "0.5";
          	horizontal-align = mkLiteral "0.5";
          };
          "entry-wrapper" = {
          	orientation = mkLiteral "horizontal";
          	vertical-align = mkLiteral "0.5";
          	spacing = mkLiteral "4px";
          	background-color = mkLiteral "@trans";
          	children = mkLiteral "[ button, entry, case-indicator ]";
          };
          "inputbar" = {
          	background-color = mkLiteral "@bgw";
          	text-color = mkLiteral "@fg";
          	expand = mkLiteral "false";
          	border-radius = mkLiteral "6px";
          	margin = mkLiteral "0px 20% 0px 20%";
          	padding = mkLiteral "10px 10px 10px 10px";
          	position = mkLiteral "north";
          	children = mkLiteral "[ entry-wrapper ]";
          };
          "listview" = {
          	background-color = mkLiteral "@trans";
          	columns = mkLiteral "7";
          	spacing = mkLiteral "2%";
          	cycle = mkLiteral "false";
          	dynamic = mkLiteral "true";
          	layout = mkLiteral "vertical";
          };
          "mainbox" = {
          	background-color = mkLiteral "@bgb";
          	children = mkLiteral "[ inputbar, listview ]";
          	spacing = mkLiteral "25px";
            padding = mkLiteral "70px 10% 0 10%";
          };
          "element" = {
          	background-color = mkLiteral "@trans";
          	text-color = mkLiteral "@fg";
          	orientation = mkLiteral "vertical";
          	border-radius = mkLiteral "12px";
          	padding = mkLiteral "25px 0 25px 0";
          };
          "element-icon" = {
          	background-color = mkLiteral "@trans";
          	horizontal-align = mkLiteral "0.5";
          	vertical-align = mkLiteral "0.5";
          	size = mkLiteral "72px";
          	border = mkLiteral "0";
          };
          "element-text" = {
          	background-color = mkLiteral "@trans";
          	text-color = mkLiteral "@fg";
          	expand = mkLiteral "true";
          	horizontal-align = mkLiteral "0.5";
          	vertical-align = mkLiteral "0.5";
          	margin = mkLiteral "0 10px 0 10px";
          };
          "element normal.urgent,element alternate.urgent" = {
          	background-color = mkLiteral "@trans";
          	text-color = mkLiteral "@fg";
          	border-radius = mkLiteral "9px";
          };
          "element normal.active, element alternate.active" = {
          	background-color = mkLiteral "@trans";
          	text-color = mkLiteral "@fg";
          };
          "element selected" = {
          	background-color = mkLiteral "@grntrans";
          	text-color = mkLiteral "@fg";
          };
          "element selected.urgent" = {
          	background-color = mkLiteral "@trans";
          	text-color = mkLiteral "@fg";
          };   
          "element selected.active" = {
          	background-color = mkLiteral "@trans";
         	color = mkLiteral "@trans";
          };         
        };
      };
}


