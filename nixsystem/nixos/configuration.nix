{ inputs, lib, config, pkgs, ... }:
with lib; let
  hyprPluginPkgs = inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system};
  hypr-plugin-dir = pkgs.symlinkJoin {
    name = "hyprland-plugins";
    paths = with hyprPluginPkgs; [
        inputs.hy3.packages.${pkgs.stdenv.hostPlatform.system}.hy3
    ];
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      #nix paths(local)
      ./hardware-configuration.nix
      ./fish.nix
      ./zsh.nix

      # modules
      inputs.noctalia.nixosModules.default
      inputs.noctalia-greeter.nixosModules.default
    ];
  # enable experimentla features for dev stuff

  nix.settings = {
    # enable experimental features
    experimental-features = [ "nix-command" "flakes" ];
    # nix-gaming cachix bins
    substituters = ["https://nix-gaming.cachix.org" "https://noctalia.cachix.org" "https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
  };

  # automatic generation garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;

  services.udev.extraRules = ''
    # Mchose Ace68/60
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="41e4", MODE="0660", TAG+="uaccess"
    SUBSYSTEMS=="usb*", ATTRS{idVendor}=="41e4", MODE="0660", TAG+="uaccess"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="320f", ATTRS{idProduct}=="5088", MODE="0666", TAG+="uaccess"
    SUBSYSTEMS=="usb*", ATTRS{idVendor}=="320f", MODE="0660", TAG+="uaccess"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="320f", ATTRS{idProduct}=="5055", MODE="0666", TAG+="uaccess"
  '';

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
  services.tuned.enable = true;
  services.upower.enable = true;

  hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
            General = {
              # Shows battery charge of connected devices on supported
              # Bluetooth adapters. Defaults to 'false'.
              Experimental = true;
              # When enabled other devices can connect faster to us, however
              # the tradeoff is increased power consumption. Defaults to
              # 'false'.
              FastConnectable = true;
            };
            Policy = {
              # Enable all controllers when they are found. This includes
              # adapters present on start as well as adapters that are plugged
              # in later on. Defaults to 'true'.
              AutoEnable = true;
            };
        };
    };
  services.blueman.enable = true;

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
  xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
  };

  xdg.mime = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "thunar.desktop"; # replace with your file explorer
        "text/html" = "firefox.desktop"; # Replace with your browser
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
      };
  };


 # Configure keymap in X11
 services.xserver.xkb = {
    layout = "us";
    variant = "";
 };


 programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
 };

 programs.noctalia = {
    enable = true;
    # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
    recommendedServices.enable = true;
 };
 programs.noctalia-greeter = {
  enable = true;
  # Optional: extra flags after `--` on noctalia-greeter-session
  greeter-args = "";
  # Full declarative greeter.toml (overwritten each activation). See examples/greeter.toml.
  settings = {
    cursor = {
      theme = "catppuccin-mocha-mauve-cursors";
      size = 24;
      path = "${pkgs.catppuccin-cursors.mochaMauve}/share/icons";
    };
  };
};

programs.hyprlock.enable = true;

 environment.sessionVariables = {
    HYPR_PLUGIN_DIR = hypr-plugin-dir;
    NIXOS_OZONE_WL = "1";
    TSSDK = "${pkgs.typescript}/lib/node_modules/typescript/lib";
 };
 console.keyMap = "us";
 # desktop environment
 # services.xserver.enable = true;
 # services.displayManager.sddm = {
 #   enable = true;
 #   theme = "catppuccin-mocha-mauve";
 # };
 # services.xserver.displayManager.defaultSession = "none+i3";
 # services.xserver.windowManager.i3 = {
 #   enable = true;
 #   extraPackages = with pkgs; [
 #   	dmenu
 #   	i3status
 #   	feh
 #   	xclip
 #       xsel
 #   	maim
 #   	slop
 #       xdotool
 #   	rofi
 #   	polybar
 #       picom
 #   ];
 # };

  #enable sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment the following
    #jack.enable = true;
  };

  services.dunst = {
    enable = true;
    enableX11 = true;
  };

  services.flatpak.enable = true;

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sandil = {
   	isNormalUser = true;
	extraGroups = [ "wheel" "networkmanager" "docker" "audio" ]; # Enable ‘sudo’ for the user.
    packages =
        with pkgs;
        [
            inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable
            osu-lazer-bin
            mysql-workbench
            obsidian
            ungoogled-chromium
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
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "sandil" ];
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
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  services.gnome.gnome-keyring.enable = true; # save passwords
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    yazi
    wofi # rofi
    # waybar # polybar
    grim # xclip
    slurp # maim
    wl-clipboard # xsel
    nwg-look
    #hyprland plugins
    hyprland-protocols
    #cursors
    hyprcursor
    catppuccin-cursors

    evtest
    btop
    cava
    tmux
    onlyoffice-desktopeditors
    pavucontrol
    ani-cli
    krita
    vesktop
    easyeffects
    zenity
    xdg-utils
    vscodium
    spotify
    vim
    ghostty
    fzf
    libsecret
    playerctl
    mpd
    rmpc
    mpv
    zellij
    psmisc
    gh
    rustcat

    #languages and lsp
    clang
    jdk21
    nodejs_24
    lua
    python3
    typescript
    zig
    rustc

    astro-language-server
    pyright
    lua-language-server
    yaml-language-server
    typescript-language-server
    kotlin-language-server
    jdt-language-server
    vscode-langservers-extracted
    vscode-css-languageserver
    nixd
  ];

  fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-cjk-sans
  noto-fonts-color-emoji
  liberation_ttf
  lato
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
  corefonts
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
  # system.copySystemConfiguration = true;

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

