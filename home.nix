{ config, pkgs, ...}:
{
  home.username = "jordon";
  home.homeDirectory = "/home/jordon";

  # Add programs
  home.packages = with pkgs; [
    chromium
    thunderbird
    meld
    bitwarden
    bitwarden-cli
    oh-my-zsh
  ];

  # Set home-manager version
  home.stateVersion = "24.05";

  # Let home manager install and manage itself
  programs.home-manager.enable = true;

  # Configure zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "python" "man" ];
      theme = "agnoster";
    };
  };

  # Git 
  programs.git = {
    enable = true;
    userName = "Jordon Davidson";
    userEmail = "jodavidson@mta.ca";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  home.file.".zshrc".text = ''
    # Lines configured by zsh-newuser-install
    HISTFILE=~/.zsh_histfile
    HISTSIZE=1000
    SAVEHIST=10000
    bindkey -e
    # End of lines configured by zsh-newuser-install
    # The following lines were added by compinstall
    zstyle :compinstall filename '/home/jordon/.zshrc'

    autoload -Uz compinit
    compinit
    # End of lines added by compinstall
  '';

}
