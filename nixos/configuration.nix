# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fish.nix
    ];
  # enable experimentla features for dev stuff
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  # Use the systemd-boot EFI boot loader.
  boot = {
	  loader.systemd-boot.enable = true;
	  loader.efi.canTouchEfiVariables = true;
	  kernelModules = [ "v4l2loopback" ];
	  extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
	  extraModprobeConfig = ''
	    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
	  '';
  };

  networking.hostName = "GumiTeto"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Dublin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # desktop environment
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha-mauve";
  };
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.windowManager.i3 = {
	enable = true;
	extraPackages = with pkgs; [
		dmenu
		i3status
		feh
		xclip
		maim
		slop
		rofi
		polybar
	];
  };
  programs.i3lock.enable = true; #default i3 screen locker
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  #enable sound
  services.pipewire = {
   	enable = true;
   	pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sandil = {
   	isNormalUser = true;
	extraGroups = [ "wheel" "networkmanager" "docker" "audio" ]; # Enable ‘sudo’ for the user.
  	packages = with pkgs; [
        vscodium
		spotify
		osu-lazer-bin
		vesktop
		clang
		typescript
		typescript-language-server
		lua
		lua-language-server
		jdk21
		jdt-language-server
		(prismlauncher.override {
		    # Add binary required by some mod
		    additionalPrograms = [ ffmpeg ];

		    # Change Java runtimes available to Prism Launcher
		    jdks = [
		      graalvmPackages.graalvm-ce
		      zulu8
		      zulu17
		      zulu
		    ];
	    	})
	];
	shell = pkgs.fish;
  };
  virtualisation.docker = {
  	enable = true;
  };
  hardware.opentabletdriver.enable = true;
  programs.firefox.enable = true;
  programs.thunar.enable = true;
  programs.steam = {
	enable = true;
  };
  programs.neovim = {
	enable = true;
	defaultEditor = true;
  };
  programs.git = {
	  enable = true;
	  package = pkgs.git.override { withLibsecret = true; };
	  config = {
	    	credential.helper = "libsecret";
	  };
  };
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };
  services.picom.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  services.gnome.gnome-keyring.enable = true; # save passwords

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
    })
  	xdotool
  	vim
	ghostty
	fzf
	libsecret
	playerctl
	mpd
	rmpc
	mpv

  ];
  fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-cjk-sans
  noto-fonts-color-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  mplus-outline-fonts.githubRelease
  dina-font
  proggyfonts
  nerd-fonts.symbols-only
  nerd-fonts.jetbrains-mono
  nerd-fonts.iosevka-term
  iosevka
  font-awesome
];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
   enable = true;
   enableSSHSupport = true;
  };

  # List services that you want to enable:


  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}

