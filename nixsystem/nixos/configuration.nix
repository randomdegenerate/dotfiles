{ inputs, lib, config, pkgs, ... }:
with lib; let
  hyprPluginPkgs = inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system};
  hypr-plugin-dir = pkgs.symlinkJoin {
    name = "hyprland-plugins";
    paths = with hyprPluginPkgs; [
        inputs.hy3.packages.${pkgs.stdenv.hostPlatform.system}.hy3
    ];
  };
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports =
    [
      ./hardware-configuration.nix
      ./system-packages.nix
      ./users.nix
      ./fish.nix
      inputs.noctalia.nixosModules.default
      inputs.noctalia-greeter.nixosModules.default
    ];
    # enable experimentla features for dev stuff

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  hardware.graphics = {
    package = pkgs-unstable.mesa;

    # if you also want 32-bit support (e.g for Steam)
    enable32Bit = true;
    package32 = pkgs-unstable.pkgsi686Linux.mesa;
  };

  # Use the systemd-boot EFI boot loader.
  boot = {
	  loader.systemd-boot.enable = true;
	  loader.efi.canTouchEfiVariables = true;
	  kernelModules = [ "v4l2loopback" "uinput" ];
	  extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
	  extraModprobeConfig = ''
	    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
	  '';
  };

  environment.sessionVariables = {
    HYPR_PLUGIN_DIR = hypr-plugin-dir;
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
          config = {
            common.default = ["gtk"];
            hyprland.default = ["gtk" "hyprland"];
          };
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
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

   #hyprland desktop environment

   programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

   programs.noctalia = {

    enable = true;
    recommendedServices.enable = true;
   };

   programs.noctalia-greeter = {
    enable = true;
    greeter-args = "";
    settings = {
        cursor = {
            theme = "catppuccin-mocha-mauve-cursors";
            size = 24;
            path = "${pkgs.catppuccin-cursors.mochaMauve}/share/icons";
        };
    };
  };

  programs.hyprlock.enable = true;

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

