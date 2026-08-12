{ config, pkgs, ... }:

{
	environment.systemPackages = [ pkgs.pure-prompt ];
	programs.zsh = {
	  enable = true;
	  enableCompletion = true;
	  autosuggestions.enable = true;
	  syntaxHighlighting.enable = true;

	  shellAliases = {
	    update = "sudo nixos-rebuild switch";
	  };

	  histSize = 10000;
	  histFile = "$HOME/.zsh_history";
	  setOptions = [
	    "HIST_IGNORE_ALL_DUPS"
	  ];
	  promptInit = ''
	  autoload -U promptinit
	  promptinit
	  prompt pure
	  '';
	};
}
