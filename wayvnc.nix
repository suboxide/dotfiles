{ config, pkgs, home, nix-colors, ... }:
{
  imports = [
  ];

xdg.configFile."wayvnc/config".text = '' 
address=0.0.0.0
enable_auth=false
username=sub
password=surf
'';
}
