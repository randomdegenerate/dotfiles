{ pkgs, ... }:

{
	programs.fish = {
		enable = true;
		shellAliases = {
            nixconfig="sudoedit /etc/nixos/configuration.nix";
			# developer aliases
			nix-shell="nix-shell --run $SHELL";
            "nix develop"="nix develope --command $SHELL";
			## Useful aliases
			# Replace ls with eza
			ls="eza -al --color=always --group-directories-first --icons=always"; # preferred listing
			la="eza -a --color=always --group-directories-first --icons=always";  # all files and dirs
			ll="eza -l --color=always --group-directories-first --icons=always";  # long format
			lt="eza -aT --color=always --group-directories-first --icons=always"; # tree listing
			"l."="eza -a | grep -e '^\.'";                                     # show only dotfiles
		};
	};

	environment.systemPackages = with pkgs; [
		  eza
		  fishPlugins.pure
		  fishPlugins.grc
		  grc
	  ];
}
