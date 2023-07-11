{ config, pkgs, home, nix-colors, ... }:
{
  imports = [
  ];

	programs.xxx = {
		enable = true;
		settings = {
			color_theme = "dracula";
		};
	};

	xdg.configFile."some/config.yaml".text = ''
	  settings:
	    draw_bold_text_with_bright_colors: true
	    dynamic_title: true
	    live_config_reload: true
	    # comment
	    window:
	      dimensions:
	        columns: 0
	        lines: 0
	    scrolling:
	      history: 10000
	      multiplier: 3
	'';

	xdg.configFile."some/config.yaml".source = (pkgs.formats.yaml { }).generate "something" {
	  settings = {
	    draw_bold_text_with_bright_colors = true;
	    dynamic_title = true;
	    live_config_reload = true;
	    "#comment1" = "This is a comment!";
	    window.dimensions = {
	      columns = 0;
	      lines = 0;
	    };
	    scrolling = {
	      history = 10000;
	      multiplier = 3;
	    };
	  };
	};
}


