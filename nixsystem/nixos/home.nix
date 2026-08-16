{ config, pkgs, inputs, ...}:
{



    wayland.windowManager.hyprland = {
        systemd.enable = false;
        enable = true;
        plugins = [
            inputs.hy3.${pkgs.stdenv.hostPlatform.system}.hy3
        ];
    };

    home.packages = with pkgs; [
        # wayland stuff
        wofi # rofi
        # waybar # polybar
        grim # xclip
        slurp # maim
        wl-clipboard # xsel
        nwg-look
        #hyprland extras
        inputs.hyprmod.packages.${pkgs.stdenv.hostPlatform.system}.default
        hyprland-protocols
    ];

    home.stateVersion = "26.05";
}
