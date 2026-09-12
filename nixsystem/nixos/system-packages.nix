{ pkgs, ... }:

{


    # sway
    programs.sway = {
        enable = true;
        package = pkgs.swayfx;
        xwayland.enable = true;
        wrapperFeatures.gtk = true;
        extraPackages = with pkgs; [
            wofi # rofi
            grim # xclip
            slurp # maim
            wl-clipboard #clipboard support for wayland
            sway-contrib.grimshot #screenshot tool
            i3status-rust
        ];
    };

    programs.firefox.enable = true;
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

    programs.thunar.enable = true;

    programs.thunar.plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
    ];
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images

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
          droidcam-obs
        ];
    };


    # --------------------------



    environment.systemPackages = with pkgs; [

            #cursors
            catppuccin-cursors
            # settings gui
            nwg-look pavucontrol easyeffects
            #tui tools
            btop fzf vim yazi mpv
            #utilities
            libsecret psmisc playerctl zenity mpd
            unzip zip usbutils stow curl xdg-utils
            sbctl
            # misc tui
            cava evtest ani-cli rmpc fastfetch

            #terminals
            ghostty

            #discord!
            vesktop
    ];

    # fonts
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
          font-awesome_6
    ];
}
