{pkgs, inputs, ... }:
{
  # Users
  users.users.sandil = {
   	isNormalUser = true;
	extraGroups = [ "wheel" "networkmanager" "docker" "audio" "input" ]; # Enable ‘sudo’ for the user.
	shell = pkgs.fish;
  };

  users.extraGroups.vboxusers.members = [ "sandil" ];

  users.users.sandil.packages =
        with pkgs;
        [
            # languages
            clang
            jdk25
            nodejs
            jdk
            nodejs_24
            lua
            python3
            typescript
            zig
            rustc

            #language server (just for configuration)
            lua-language-server
            nixd

            # dev tools
            netcat-gnu
            tmux
            zellij
            gh
            rustcat

            # AI BULLSHIT
            opencode
            ollama
            llama-cpp-rocm

            # dev apps
            ungoogled-chromium
            mysql-workbench
            eclipses.eclipse-java

            # -----------------------------------

            # graphical apps and games
            inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable
            osu-lazer-bin
            obsidian
            onlyoffice-desktopeditors
            krita
            vscodium
            spotify
            planify
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
}
