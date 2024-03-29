# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Moncton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable cosmic desktop.
  #services.xserver.desktopManager.system76cosmic.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jordon = {
    isNormalUser = true;
    description = "Jordon Davidson";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCww8wJQ3xF9pTEcemihXZazwQHPxG62S+3Gv7GtM9eNm0eWBnppvyierdCOwHJ7RHiMdyZvPXhnQ6qTNOc0+8mcIcWc02y9T3bhNfXljLnmaK/aTshioN0ZWDqglj6NveCGMNYBYM4bR6w+tctWbDP8D8UEupy8F8yOSBnWaYjSM2zY10RO7oR/8ZU/roATaeoVdt8fIZBPh/RDq4yem4LKWifyfbgrMIIqWKguR5P/oWYtXOq78LqlAl/NrjAmARyvKn9Tm/LjP6EXNl1QCp6+gaY7yzEB5ONFD0hTMM+GrZCIwN34K46hSmadK7VYsDnpa56fmfQbiqMe7j6OACWO0cb4HcmllMVvrbpp0lyHkpuBTJ9HuNdvXrmxcavZPU1u8XrDAiBIn1izc+SGCCekxFbQl+z1+lzEnYfdaKQQ4/lspLUbZcS7b3u9M4p5UycJVh1eDNRP+1jBG8C1lV/Hbrcmp5Liar2MvygJPguhgUhDBNVtrSAx87cxn6gyB0= jordondavidson@pop-os"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      brave
      thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    docker
    git
    meld
    python3
    vscode
    spice-vdagent
    zsh
    zsh-history
    zsh-git-prompt
    oh-my-zsh
    powerline-fonts
    bitwarden
    bitwarden-cli
    mkcert
  ];

  # Fonts
  # Adding fonts to the system that are nice to have.
  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [ "Meslo" ];
    })
    fira-code 
    fira-code-symbols 
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    # Oh My zsh
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "man" ];
      theme = "agnoster";
    };
  };

  # Security 
  # Additional trusted root ca certs.
  security.pki.certificateFiles = [
    /home/jordon/.local/share/mkcert/rootCA.pem
  ];


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
  # Enable spice virtual agent
  services.spice-vdagentd.enable = true;
  
  # Add docker
  virtualisation.docker.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
