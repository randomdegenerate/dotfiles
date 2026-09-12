{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./system-packages.nix
      ./users.nix
      ./fish.nix
    ];

  catppuccin = {
        enable = true;
        accent = "mauve";
        flavor = "mocha";
        gtk.icon.enable = true;
        limine.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };


  # Use the systemd-boot EFI boot loader.
  boot = {
	  loader.limine.enable = true;
	  loader.efi.canTouchEfiVariables = true;
	  kernelModules = [ "v4l2loopback" "uinput" ];
	  extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
	  extraModprobeConfig = ''
	    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
	  '';
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL= "1";
    ELECTRON_OZONE_PLATFORM_HINT= "AUTO";
    TSSDK = "${pkgs.typescript}/lib/node_modules/typescript/lib";
  };

  networking.hostName = "GumiTeto"; # Define your hostname.
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  #bluetooth
  hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
            General = { Experimental = true; FastConnectable = true; };
            Policy = { AutoEnable = true; };
        };
  };

  # Configure network connections interactively with nmcli or nmtui.

  # Set your time zone.
  time.timeZone = "Europe/Dublin";
  i18n.defaultLocale = "en_US.UTF-8";
  #defualt keymap setting
  console.keyMap = "us";
  #xdg setup
  xdg = {
         portal = {
          enable = true;
          xdgOpenUsePortal = true;
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal-wlr
          ];
        };
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


  # power services
  services.tuned.enable = true;
  services.upower.enable = true;

  # sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment the following
    #jack.enable = true;
  };

  #notification daemon
  services.dunst = {
    enable = true;
    enableX11 = true;
  };

  services.flatpak.enable = true;


  services.gnome.gnome-keyring.enable = true;
  services.greetd = {
    enable = true;
    settings = {
        default_session = {
                command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
                user = "greeter";
            };
    };
  };

  virtualisation.docker = {
    enable = true;
  };
  virtualisation.virtualbox.host.enable = true;

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };


  #x11 keyboard specification
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.onedrive.enable = true;
  services.openssh.enable = true;

  # drawing tablet support
  hardware.opentabletdriver.enable = true;
  services.libinput.enable = true;
  services.udev.extraRules = ''
    # Mchose Ace68/60
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="41e4", MODE="0660", TAG+="uaccess"
    SUBSYSTEMS=="usb*", ATTRS{idVendor}=="41e4", MODE="0660", TAG+="uaccess"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="320f", ATTRS{idProduct}=="5088", MODE="0666", TAG+="uaccess"
    SUBSYSTEMS=="usb*", ATTRS{idVendor}=="320f", MODE="0660", TAG+="uaccess"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="320f", ATTRS{idProduct}=="5055", MODE="0666", TAG+="uaccess"
  '';

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}

