{ config, pkgs, lib, ... }:
let
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;
    text = ''
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      '';
  };
  configure-gtk = pkgs.writeTextFile {
      name = "configure-gtk";
      destination = "/bin/configure-gtk";
      executable = true;
      text = let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Dracula'
     	gsettings set $gnome_schema icon-theme 'Dracula'
	    gsettings set $gnome_schema cursor-theme 'Phinger-cursors-light'
	    gsettings set $gnome_schema font-name 'JetBrains Nerd Font 11'
	    gsettings set $gnome_schema font 'JetBrains Nerd Font 11'
        '';
  };
in
{
  imports = [
	./hardware-configuration.nix
     (
      let revision = "7b85bd1de57ee685535029c0aead77050fa734c4"; in
      builtins.fetchTarball {
        url = "https://github.com/Jovian-Experiments/Jovian-NixOS/archive/${revision}.tar.gz";
        sha256 = "sha256:0h50il3gc90hz29qqryx7wvzh5dmq2kn3byxkz2rxa6b9yl4lw0z";
      } + "/modules"
     )
    ];

  # EXPERIMENTAL / clean and update
  system.autoUpgrade.enable = true;
  nix = {
  	settings.substituters = [
	"https://nix-community.cachix.org"
  	"https://hyprland.cachix.org"
	"https://nix-gaming.cachix.org"
  	];
  	settings.trusted-public-keys = [
  	    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  		"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  		"nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
  		];
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
  };

  # Steamdeck
    jovian = {
      devices.steamdeck ={
        enable = true;
       };
       steam = {
         enable = true;
       };
     }; 

  # Flatpak
  services.flatpak.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.systemd-networkd-wait-online.enable =  false;
  
  # enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_BE.UTF-8";
    LC_IDENTIFICATION = "nl_BE.UTF-8";
    LC_MEASUREMENT = "nl_BE.UTF-8";
    LC_MONETARY = "nl_BE.UTF-8";
    LC_NAME = "nl_BE.UTF-8";
    LC_NUMERIC = "nl_BE.UTF-8";
    LC_PAPER = "nl_BE.UTF-8";
    LC_TELEPHONE = "nl_BE.UTF-8";
    LC_TIME = "nl_BE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  #services.xserver.windowManager.bspwm.enable = true;
  
  programs.hyprland.enable = true;
  qt.platformTheme = "qt5ct";

  #gnome shit
  programs.dconf.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # SWAY PORTAL STUFFS
  security.polkit.enable = true;
  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "euro";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # shadow https://github.com/cornerman/shadow-nix & https://shadow-codex.com/shadow-linux-known-issues/
  users.groups.shadow-input.gid = 1000;
    # Hardware drivers
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sub = {
    isNormalUser = true;
    description = "Sebastien Brouwers";
    extraGroups = [ "networkmanager" "wheel" "input" "shadow-input" "video" ];
    packages = with pkgs; [
    ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.defaultSession = "steam-wayland";
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "sub";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
                "electron-12.2.3"
              ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	appimage-run
	autoconf
	autotiling
	base16-schemes
	binutils
	blueman
	bluez
	caffeine-ng
	clang
	cliphist
	cmake
	configure-gtk
	copyq
	coreutils
	curl
	dbus-sway-environment
	direnv
	discord
	dracula-icon-theme
	dracula-theme
	dwarfs
	etcher
	fd
	ffmpeg
	file
	file
	firefox-devedition
	fishPlugins.done
	fishPlugins.forgit
	fishPlugins.fzf-fish
	fishPlugins.grc
	font-awesome
	freeglut
	fuse-overlayfs
	gawk
	gcc
	gh
	gimp
	git
	git-lfs
	gitAndTools.gitFull
	glib
	gnome.adwaita-icon-theme
	gnome.gnome-tweaks
	gnome.gpaste
	gnomeExtensions.appindicator
	gnumake
	gnupg
	gnutar
	gqview
	grc
	grim
	gruvbox-dark-gtk
	gruvbox-dark-icons-gtk
	gsettings-desktop-schemas
	gvfs
	home-manager
	hyprland
	iftop
	image-roll
	jdk
	killall
	libGL
	libGLU 
	libclang
	libsForQt5.kmenuedit
	libsForQt5.qt5.qtwayland
	libtool
	libva-utils
	libvterm
	light
	llvm
	lshw
	lsof
	lxappearance
	man
	mate.mate-polkit
	microsoft-edge-dev
	mkpasswd
	mlocate
	nano
	ncurses5
	neofetch
	nerdfonts
	nixpkgs-lint
	noto-fonts-emoji
	p7zip
	pamixer
	pandoc
	parsec-bin
	pavucontrol
	pciutils
	pcmanfm
	phinger-cursors
	polkit
	protonup-qt
	protonvpn-gui
	psmisc
	pulsar
	pw-volume
	python311Packages.pip
	rofi-wayland
	sc-controller
	seatd
	slurp
	speedtest-cli
	starship
	stdenv.cc
	steam
	steamdeck-firmware
	sway-contrib.grimshot
	swaybg
	swayfx
	swaylock-effects
	swaynotificationcenter
	tailscale
	thefuck
	tldr
	tree
	unclutter
	unrar
	unzip
	vim
	waybar
	wayland
	wayvnc
	wget
	which
	wlogout
	wlsunset
	wob
	woeusb-ng
	xarchiver
	xdg-utils
	xfce.thunar
	xfce.thunar-archive-plugin
	xfce.thunar-media-tags-plugin
	xfce.thunar-volman
	xorg.libX11 
	xorg.libXext 
	xorg.libXi 
	xorg.libXmu 
	xorg.libXrandr zlib
	xorg.libXv 
	xwayland
	xz
	zip
	zlib
	zstd
   	gdb
   	nixfmt
   	nixpkgs-fmt
   	nodejs
   	openjdk
   	python3Full
   	rustup
   	wl-clipboard
	gnused
  ];

fonts.fonts = with pkgs; [
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  mplus-outline-fonts.githubRelease
  dina-font
  proggyfonts
  font-awesome
  nerdfonts
];

  # enable programs
  services.tailscale.enable = true;
  programs.light.enable = true;
  programs.fish.enable = true;
  programs.partition-manager.enable = true;
	  users.defaultUserShell = pkgs.fish;
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;
   networking.firewall.enable = false;

  system.stateVersion = "23.05"; # Did you read the comment?

#SWITCH TEST > pkill -9 gnome-shell
  systemd.services.gamescope-switcher = {
    wantedBy = [ "graphical.target" ];
    serviceConfig = {
      User = 1000;
      PAMName = "login";
      WorkingDirectory = "~";

      TTYPath = "/dev/tty7";
      TTYReset = "yes";
      TTYVHangup = "yes";
      TTYVTDisallocate = "yes";

      StandardInput = "tty-fail";
      StandardOutput = "journal";
      StandardError = "journal";

      UtmpIdentifier = "tty7";
      UtmpMode = "user";

      Restart = "always";
    };

    script = ''
      set-session () {
        mkdir -p ~/.local/state
        >~/.local/state/steamos-session-select echo "$1"
      }
      consume-session () {
        if [[ -e ~/.local/state/steamos-session-select ]]; then
          cat ~/.local/state/steamos-session-select
          rm ~/.local/state/steamos-session-select
        else
          echo "gamescope"
        fi
      }
      while :; do
        session=$(consume-session)
        case "$session" in
          plasma)
            dbus-run-session sway
	    #dbus-run-session gnome-shell
            #dbus-run-session startplasma-wayland    
	;;
          gamescope)
            steam-session
            ;;
        esac
      done
    '';
  };

}
