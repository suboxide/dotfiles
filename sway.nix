{ config, pkgs, home, nix-colors, ... }:
#with import <nixpkgs> {};
#with lib;
{
  imports = [
  ];
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    config = rec {
      modifier = "Mod4"; 
      terminal = "kitty";
      menu = "rofi -show drun";
		#menu = "rofi -show drun -theme ~/.config/rofi/config.rasi xargs swaymsg exec --";
      bars = [];
      output = {
      	DP-3 = {
      		mode = "2560x1080@75Hz";
      		pos = "1280 0";
      		scale = "1";
      		bg = "/etc/nixos/wall.png fill";
      	};
      	eDP-1 = {
      		mode = "800x1280@60Hz";
      		pos = "0 1000";
      		scale = "1";
      		transform = "90";
      		bg = "/etc/nixos/wall.png fill";
      	};
      };
      workspaceOutputAssign = [
             { workspace = "1"; output = "DP-3"; }
             { workspace = "2"; output = "DP-3"; }
             { workspace = "3"; output = "DP-3"; }
             { workspace = "4"; output = "DP-3"; }
             { workspace = "5"; output = "DP-3"; }
             { workspace = "6"; output = "DP-3"; }
             { workspace = "7"; output = "DP-3"; }
             { workspace = "8"; output = "eDP-1"; }
             { workspace = "9"; output = "eDP-1"; }
             { workspace = "10"; output = "eDP-1"; }
        ];
      workspaceAutoBackAndForth = true; 
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_numlock = "enabled";
        };
      };
      window = {
      	titlebar = false;
      	border = 1;
      };
      window.commands = [
        {
          command = "floating enable, sticky enable";
          criteria = {
            title = "^Picture-in-Picture$";
          };
        }
      ];
      gaps = {
        inner = 10;
        outer = 0;
        smartGaps = false;
        smartBorders = "on";
      };
      floating.criteria = [{ class = "^Steam$"; } { class = "^Wine$"; }];
	  keybindings =
	    let
	      mod = config.wayland.windowManager.sway.config.modifier;
	      inherit (config.wayland.windowManager.sway.config)
	          left down up right menu terminal;
	    in
	    {
          "${mod}+Return" = "exec ${terminal}";
          "${mod}+q" = "kill";
          "${mod}+d" = "exec ${menu}";

          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+r" = "restart";

          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";

          "${mod}+h" = "split h";
          "${mod}+v" = "split v";
          "${mod}+f" = "fullscreen toggle";

          "${mod}+comma" = "layout stacking";
          "${mod}+period" = "layout tabbed";
          "${mod}+slash" = "layout toggle split";          

          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";

          "${mod}+a" = "focus parent";
          "${mod}+s" = "focus child";

          "${mod}+r" = "mode resize";

		  "${mod}+l" = "exec swaylock -c '$HOME/.config/swaylock/config'";

          "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioRaiseVolume" = "exec pamixer -ui 2 && pamixer --get-volume > $WOBSOCK";
          "XF86AudioLowerVolume" = "exec pamixer -ud 2 && pamixer --get-volume > $WOBSOCK";

          "${mod}+minus" = "scratchpad show";
          "${mod}+underscore" = "move container to scratchpad";
          
          "${mod}+p" =
            "exec ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g- $(xdg-user-dir PICTURES)/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png";
	    };
	    modes = {
          resize = {
            Left = "resize shrink width";
            Right = "resize grow width";
            Down = "resize shrink height";
            Up = "resize grow height";
            Return = "mode default";
            Escape = "mode default";
          };
        };
        colors = {
          focused = {
            border = "#${config.colorScheme.colors.base00}";
            background = "#${config.colorScheme.colors.base00}";
            text = "#${config.colorScheme.colors.base05}";
            indicator = "#${config.colorScheme.colors.base01}";
            childBorder = "#${config.colorScheme.colors.base00}";
          };
          focusedInactive = {
            border = "#${config.colorScheme.colors.base01}";
            background = "#${config.colorScheme.colors.base01}";
            text = "#${config.colorScheme.colors.base05}";
            indicator = "#${config.colorScheme.colors.base01}";
            childBorder = "#${config.colorScheme.colors.base01}";
          };
          unfocused = {
            border = "#${config.colorScheme.colors.base01}";
            background = "#${config.colorScheme.colors.base01}";
            text = "#${config.colorScheme.colors.base05}";
            indicator = "#${config.colorScheme.colors.base01}";
            childBorder = "#${config.colorScheme.colors.base01}";
          };
          urgent = {
            border = "#${config.colorScheme.colors.base08}";
            background = "#${config.colorScheme.colors.base08}";
            text = "#${config.colorScheme.colors.base05}";
            indicator = "#${config.colorScheme.colors.base08}";
            childBorder = "#${config.colorScheme.colors.base08}";
          };
        };
      startup = [
        { command = "systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK"; }
        { command = "dbus-sway-environment"; }
        { command = "configure-gtk"; }      
        { command = "waybar"; }
        { command = "autotiling"; }
        { command = "swaync"; }
        { command = "wl-paste --watch cliphist store"; }
        #{ command = "unclutter -idle 1"; }
        { command = "/nix/store/$(ls -la /nix/store | grep 'mate-polkit' | grep '4096' | awk '{print $9}' | sed -n '$p')/libexec/polkit-mate-authentication-agent-1"; }
      ];
    };
    extraConfig = ''
   		focus output DP-3
   		seat seat0 xcursor_theme phinger-cursors-light
   		corner_radius 10
   		blur enable
   		blur_xray off
   		blur_passes 2
   		blur_radius 5
   		shadows on
   		shadows_on_csd off
   		shadow_blur_radius 20
		shadow_color #0000007f
		default_dim_inactive 0.1
		dim_inactive_colors.unfocused #000000FF
		dim_inactive_colors.urgent #900000FF
		layer_effects 'waybar' blur enable; shadows enable
		layer_effects 'rofi' blur enable
		layer_effects 'wlogout' blur enable; shadows enable
		set $WOBSOCK $XDG_RUNTIME_DIR/wob.sock
		exec rm -f $WOBSOCK && mkfifo $WOBSOCK && tail -f $WOBSOCK | wob
		'';
    extraSessionCommands = ''
		export SDL_VIDEODRIVER=wayland
		export QT_QPA_PLATFORM=wayland
		export QT_WAYLAND_DISABLE_WINDOWDECORATION='1'
		export _JAVA_AWT_WM_NONREPARENTING=1
		export MOZ_ENABLE_WAYLAND=1
		'';
  };
}

