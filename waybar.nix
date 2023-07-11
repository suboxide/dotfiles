{ config, pkgs, home, nix-colors, ... }:
{
  imports = [
  ];

	programs.waybar = {
		enable = true;
		settings = {
   		 mainBar = {
	     	id = "nixbar";
	     	layer=  "top";
	     	#mode = "dock";
	     	exclusive = true;
	     	passthrough = false;
	     	position = "right";
	     	#height = "";
	     	#width = "";
	     	spacing = 0;
	     	#margin = 0;
	     	margin-top = 0;
	     	margin-bottom = 0;
 	     	margin-left = 0;
  	     	margin-right = 0;
  	  	 	fixed-center = true;
    	 	gtk-layer-shell = true;
    	 	ipc = false;
    	 
    	 	modules-left = ["custom/menu" "sway/workspaces"];
    	 	modules-center = [];
    	 	modules-right = ["pulseaudio" "battery" "bluetooth" "backlight" "network" "custom/copy" "idle_inhibitor" "tray" "custom/notification" "clock" "clock#2" "custom/power"];

	    	"custom/menu" = {
	         	format =  "<span size='x-large' ></span>";
	         	tooltip = false;
	         	on-click = "GDK_BACKEND=wayland rofi -no-lazy-grab -show drun";
	    	};
			"sway/workspaces" = {
		  		all-outputs = false;
		  		disable-scroll = false;
		  		disable-click = false;
		  		disable-scroll-wraparound = true;
		  		enable-bar-scroll = true;
		  		persistent_workspaces = {
		     	 "1" = ["DP-3"];
        	 	 "2" = ["DP-3"];
        	 	 "3" = ["DP-3"];
        	 	 "4" = ["DP-3"];
        	 	 "5" = ["DP-3"];
        	 	 "6" = ["DP-3"];
        	 	 "7" = ["DP-3"];
        	 	 "8" = ["eDP-1"];
        	 	 "9" = ["eDP-1"];
        	 	 "10" = ["eDP-1"];
		  		};
 	 	  		format = "{icon}";
    	  		format-icons = {
        		 urgent = "";
        		 focused = "";
        		 default = "";
        		};
			};

		    "pulseaudio" = {
 		       format = "<span>{icon}</span>";
 		       format-muted = "<span>婢</span>";
 		       format-icons = {
    	        default = ["奄" "奔" "墳"];
    	 	    };
  			   scroll-step = 5.0;
		       on-click = "pw-volume mute toggle";
        	   on-click-right = "pavucontrol";
               tooltip = true;
        	   smooth-scrolling-threshold = 1;
    		};

 		   "battery" = {
			interval = 60;
			full-at = 93;
			design-capacity = false;
	        states = {
   	         good = 90;
   	         warning = 30;
   	         critical = 15;
	        };
	        format = "<span>{icon}</span>";
	        format-charging = "<span></span>";
	        format-plugged = "<span>ﮣ</span>";
	        format-full = "<span></span>";
	        format-icons = ["" "" "" "" "" "" "" "" ""];
	        format-time = "{H}h {M}min";
	        tooltip = true;
	        on-click = "kitty btop";
	        on-click-right = "kitty btop";
		   };
		   "bluetooth" = {
		   	format = "<span>󰂯</span>";
		   	format-connected = "<span>󰂱</span>";
		   	format-connected-battery = "<span>󰂱</span>";
		   	tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
		   	tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
		   	tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
		   	tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
		       on-click = "blueman-manager";
		       on-click-right = "blueman-manager";
		   };
		   "backlight" = {
			interval = 2;
        	device = "amdgpu_bl1";
        	format = "<span>{icon}</span>";
            format-icons = ["" "" "" "" "" "" ""];
        	on-scroll-up = "light -A 5%";
        	on-scroll-down = "light -U 5%";
        	smooth-scrolling-threshold = 1;
        	tooltip-format = "{percent}%";
        	on-click = "wlsunset -l 51.03333 -L 3.15";
        	on-click-right = "wlsunset -l 51.03333 -L 3.15";
        	tooltip = true;
		   };
		   "network" = {
			interval = 5;
	        format-wifi = "<span>直</span>";
	        format-ethernet = "<span></span>";
	        format-linked = "<span></span>";
	        format-disconnected = "<span>睊</span>";
	        format-disabled = "<span>睊</span>";
	        tooltip-format = "{essid} :  {bandwidthUpBits} |  {bandwidthDownBits}";
 		    on-click = "[[ ! `pidof nm-connection-editor` ]] && nm-connection-editor || pkill nm-connection-e";
 	        on-click-right = "kitty nmtui";
    	   };
    	   "custom/copy" = {
		     tooltip = "false";
		     on-click = "/etc/nixos/rofiCopy";
  		     format = "<span></span>";
		   };
		   "idle_inhibitor" = {
		       format = "{icon}";
		       start-activated = true;
		       format-icons = {
		           activated = "<span>󰅶</span>";
		           deactivated = "<span>󰾪</span>";
		       };
		   };
		   "tray" =  {
        	icon-size = 16;
        	spacing = 8;
    	   };
    	   "custom/notification" = {
		    tooltip = false;
		    format = "{icon}";
		    format-icons = {
	        	notification = "<span></span>";
     	    	none = "<span></span>";
     			dnd-notification = "<span>󰵙</span>";
      			dnd-none = "<span></span>";
    		};
    		return-type = "json";
    		exec-if = "which swaync-client";
    		exec = "swaync-client -swb";
    		on-click = "swaync-client -t -sw";
    		on-click-right = "swaync-client -d -sw";
    		escape = true;
  			};
  			"clock" = {
				interval = 60;
		        tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
 		        format = "<span size='x-large'>{:%H}</span>";
  		 	};
    		"clock#2" = {
				interval = 60;
        		tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
        		format = "<span size='x-large'>{:%M}</span>";
    		};
    		"custom/power" = {
        	 format = "<span></span>";
        	 tooltip = false;
           	 on-click = "wlogout -p layer-shell";
		    };

		};
	  };
	  style = ''
		* {
		    font-family: "JetBrains Mono Nerd", "Iosevka Nerd Font", "Font Awesome";
		    font-size: 16px;
			min-width: 22px;
		}
		window#waybar {
		   background: rgba(40, 41, 54, 0.8);
		   border-left: 1px solid #${config.colorScheme.colors.base01};
		   border-radius: 0px 0px 0px 0px;
		}
		#custom-menu {
    		background-color: #${config.colorScheme.colors.base01};
    		color : #${config.colorScheme.colors.base04};
    		border-radius: 6px 6px 6px 6px;
    		padding: 5px 8px 5px 0px;
    		margin-left: 5px;
    		margin-right: 5px;
    		margin-top: 8px;
    		margin-bottom: 8px;
		}
		button:hover {
			background: #${config.colorScheme.colors.base03};
		}
		#workspaces {
		    border-radius: 6px 6px 6px 6px;
		    padding: 10px 5px 10px 5px;
		    margin-left: 5px;
		    margin-right: 5px;
		    background-color: #${config.colorScheme.colors.base01};
		}
		#workspaces button {
			border: 0px solid rgba(255, 184, 108, 0.5);
		 	color: #${config.colorScheme.colors.base09};
      		padding: 5px 10px 5px 5px;
       		margin-right: 0px;
		}
		#workspaces button.focused {
			color: #${config.colorScheme.colors.base0A};
    		padding: 5px 10px 5px 5px;
    	    margin-right: 0px;
		}
		#workspaces button.persistent {
			color: #${config.colorScheme.colors.base02};
	    	padding: 5px 10px 5px 5px;    
	    	margin-right: 0px;
		}
		#pulseaudio {
		    color: #${config.colorScheme.colors.base0A};
		    background-color: #${config.colorScheme.colors.base01};
		    border-radius: 6px 6px 0px 0px;
		    padding: 10px 4px 5px 5px;
		    margin-left: 5px;
		    margin-right: 5px;
		}
		#pulseaudio.bluetooth {
		    color: #${config.colorScheme.colors.base0A};
		}
		#pulseaudio.muted {
		    color: #${config.colorScheme.colors.base08};
		}
		#battery {
		    color: #${config.colorScheme.colors.base09};
		    background-color: #${config.colorScheme.colors.base01};
		    border-radius: 0px 0px 0px 0px;
		    padding: 5px 4px 5px 5px;
		    margin-left: 5px;
		    margin-right: 5px;
		}
		#battery.charging {
		}
		#battery.plugged {
		}
		#bluetooth {
		    color: #${config.colorScheme.colors.base04};
		    background-color: #${config.colorScheme.colors.base01};
		    border-radius: 0px 0px 0px 0px;
		    padding: 5px 4px 5px 5px;
		    margin-left: 5px;
		    margin-right: 5px;
		}
		#backlight {
		    color: #${config.colorScheme.colors.base0B};
		    background-color: #${config.colorScheme.colors.base01};
		    border-radius: 0px 0px 0px 0px;
		    padding: 5px 4px 0px 5px;
		    margin-left: 5px;
		    margin-right: 5px;
		}
		#network {
		    color: #${config.colorScheme.colors.base0C};
		    background-color: #${config.colorScheme.colors.base01};
		    border-radius: 0px 0px 6px 6px;
		    padding: 5px 4px 10px 5px;
		    margin-left: 5px;
		    margin-right: 5px;
		    margin-bottom: 8px;
		}
		#network.disconnected {
		    color: #${config.colorScheme.colors.base08};
		}
		#network.disabled {
		    color: #${config.colorScheme.colors.base08};
		}
		#network.linked {
		}
		#network.ethernet {
		}
		#network.wifi {
		}
		#custom-copy {
		    background-color: #${config.colorScheme.colors.base01};
		    border-radius: 6px 6px 0px 0px;
		    padding: 10px 6px 5px 0px;
		    margin-left: 5px;
		    margin-right: 5px;
		    color: #${config.colorScheme.colors.base05};
		}
		#idle_inhibitor {
		    background-color: #${config.colorScheme.colors.base01};
		    border-radius: 0px 0px 0px 0px;
		    padding: 5px 5px 5px 1px;
		    margin-left: 5px;
		    margin-right: 5px;
		    color: #${config.colorScheme.colors.base0B};
		}
		#tray {
		    background-color: #${config.colorScheme.colors.base01};
		    border-radius: 0px 0px 0px 0px;
		    padding: 5px 4px 5px 5px;
		    margin-left: 5px;
		    margin-right: 5px;
		    }
		    
		#tray > .passive {
		    -gtk-icon-effect: dim;
		}
		#tray > .needs-attention {
		    -gtk-icon-effect: highlight;
		}
		#tray > .active {
		}
		#custom-notification {
		    background-color: #${config.colorScheme.colors.base01};
		    border-radius: 0px 0px 6px 6px;
		    padding: 5px 5px 10px 1px;
		    margin-left: 5px;
		    margin-right: 5px;
		    margin-bottom: 8px;
		    color: #${config.colorScheme.colors.base08};
		}
		#clock {
		    background-color: #${config.colorScheme.colors.base01};
		    color: #${config.colorScheme.colors.base07};
		    font-size: 16px;
		    font-weight: bold;
		    border-radius: 6px 6px 0px 0px;
		    padding: 5px 4px 0px 6px;
		    margin-left: 5px;
		    margin-right: 5px;
		}
		#clock.2 {
		    color: #${config.colorScheme.colors.base07};
		    border-radius: 0px 0px 6px 6px;
		    padding: 0px 4px 5px 6px;
		    margin-bottom: 8px;
		}
		#custom-power {
		    background-color: #FF6E67;
		    border-radius: 6px 6px 6px 6px;
		    padding: 5px 5px 5px 1px;
		    margin-left: 5px;
		    margin-right: 5px;
		    margin-bottom: 8px;
		    color: #${config.colorScheme.colors.base07};
		}		
	  '';
	};
}

