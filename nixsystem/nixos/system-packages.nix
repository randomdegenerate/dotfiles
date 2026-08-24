{ pkgs, ... }:

{
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
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };
    hardware.opentabletdriver.enable = true;
    environment.systemPackages = with pkgs; [
            wofi # rofi
            grim # xclip
            slurp # maim
            wl-clipboard # xsel
            #hyprland plugins
            hyprland-protocols
            xdg-utils
            #cursors
            hyprcursor catppuccin-cursors
            # settings gui
            nwg-look pavucontrol easyeffects
            #iruin webcam
            #tui tools
            tmux btop zellij gh fzf vim yazi mpv
            #utilities
            libsecret psmisc playerctl zenity mpd # xdg-utils
            # misc tui
            cava evtest ani-cli rustcat rmpc fastfetch

            #terminals
            ghostty

            #graphical apps
            onlyoffice-desktopeditors
            krita
            vesktop
            vscodium
            spotify
            nautilus

            #compilers and sdk's
            clang jdk21 nodejs_24 lua python3 typescript zig rustc
            #language server protocols
            astro-language-server pyright lua-language-server yaml-language-server
            typescript-language-server kotlin-language-server jdt-language-server
            vscode-langservers-extracted vscode-css-languageserver nixd
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
    ];
}
