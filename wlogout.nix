{ config, pkgs, home, nix-colors, ... }:
{
  imports = [
  ];

	programs.wlogout = {
		enable = true;
		layout = [
			{
			    label = "suspend";
			    action = "systemctl suspend";
			    text = "";
			    keybind = "u";

			}
						{
			    label = "hibernate";
			    action = "systemctl hibernate";
			    text = "";
			    keybind = "h";
			}
			{
			    label = "logout";
			    action = "kill -9 -1"; #"loginctl terminate-user $USER",
			    text = "";
			    keybind = "e";
			}
			{
			    label = "lock";
			    text = "";
			    action = "swaylock";
			    keybind = "l";
			}
			{
			    label = "reboot";
			    action = "systemctl reboot";
			    text = "";
			    keybind = "r";
			}
			{
			    label = "shutdown";
			    action = "systemctl poweroff";
			    text = "";
			    keybind = "s";
			}
		];
		style =
			''
			* {
			    font-family: "JetBrains Mono";
			    font-size: 12px;
			    font-weight: bold;
			}
			window {
				background-color: rgba(40,42,54,0.8);
			}
			button {
				background-color: #${config.colorScheme.colors.base00};
			    color: #${config.colorScheme.colors.base07};
				border: 0px solid #000000;
				border-radius: 10px;
				background-repeat: no-repeat;
				background-position: center;
				background-size: 30%;
				margin: 60px;
			}
			button:focus, button:active, button:hover {
				background-color: #${config.colorScheme.colors.base09};
				color: #${config.colorScheme.colors.base07};
				outline-style: none;
			}
			#lock {
			    background-image: image(url("/etc/nixos/icons/lock.png"));
			}
			#logout {
			    background-image: image(url("/etc/nixos/icons/logout.png"));
			}
			#suspend {
			    background-image: image(url("/etc/nixos/icons/suspend.png"));
			}
			#hibernate {
			    background-image: image(url("/etc/nixos/icons/hibernate.png"));
			}
			#shutdown {
			    background-image: image(url("/etc/nixos/icons/shutdown.png"));
			}
			#reboot {
			    background-image: image(url("/etc/nixos/icons/reboot.png"));
			}
			'';
	};
}


