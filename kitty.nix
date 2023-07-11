{ config, pkgs, home, nix-colors, ... }:
{
  imports = [
  ];
	programs.kitty = {
		enable = true;
		environment = {
			  "LS_COLORS" = "1";
		};
		settings = {
			term = "xterm-256color";
			background_opacity = "0.8";
		    scrollback_lines = 10000;
			bold_font = "auto";
			italic_font = "auto";
			bold_italic_font =  "auto";
			disable_ligatures = "never";
			confirm_os_window_close = 0;
			repaint_delay = 7;
			sync_to_monitor = "yes";
			window_padding_width = 16;
			tab_bar_edge = "bottom";
			tab_bar_align = "left";
			tab_bar_style = "powerline";
			tab_powerline_style = "round";
			active_tab_font_style = "bold";
			inactive_tab_font_style = "italic";
		};
		extraConfig = ''
		term xterm-256color
		'';
		keybindings = {
		  "ctrl+c" = "copy_or_interrupt";
		  "ctrl+shift+v" = "paste_from_clipboard";
		  "ctrl+shift+c" = "copy_to_clipboard";
		  "ctrl+v" = "paste_from_clipboard";
		  "ctrl+alt+q" = "goto_layout tall";
		  "ctrl+alt+w" = "goto_layout stack";
		  "ctrl+shift+left" = "neighboring_window left";
		  "ctrl+shift+right" = "neighboring_window right";
		  "ctrl+shift+up" = "neighboring_window up";
		  "ctrl+shift+down" = "neighboring_window down";
		  "ctrl+t" = "new_tab_with_cwd";
		  "ctrl+alt+j" = "change_font_size all -1";
		  "ctrl+alt+k" = "change_font_size all +1";
		  "ctrl+alt+up" = "change_font_size all +1";
		  "ctrl+alt+down" = "change_font_size all -1";
		};
		font.name = "JetBrainsMono Nerd Font ";
		font.size = 10;
		theme = "Dracula";
	};
}


