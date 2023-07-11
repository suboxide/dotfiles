{ config, pkgs, home, nix-colors, ... }:
{
  imports = [
  ];

xdg.configFile."wob/wob.ini".text = '' 
timeout = 1000
height = 32
#anchor = bottom 
border_offset = 0
border_size = 2
bar_padding = 2
border_color = ${config.colorScheme.colors.base0A}66
background_color = ${config.colorScheme.colors.base00}66
bar_color = ${config.colorScheme.colors.base0A}FF
overflow_border_color = ${config.colorScheme.colors.base08}66
overflow_background_color = ${config.colorScheme.colors.base00}66
overflow_bar_color = ${config.colorScheme.colors.base08}FF
'';
}
