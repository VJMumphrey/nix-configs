{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in
{

  imports = [
    (import "${home-manager}/nixos")
    ./hardware-configuration.nix
    ./home.nix
  ];

  # for UEFI
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  # for non-uefi systems 
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "/dev/vda" ];
  boot.loader.grub.useOSProber = true;

  system.stateVersion = "23.11"; # Did you read the comment?

  networking.networkmanager.enable = true;
  #services.openssh.enable = true;
  
  # needed for home-manager 
  security.polkit.enable = true;

  # enable dwm 
  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;
  
  users.users."hunter" = {
    isNormalUser = true;
    initialPassword = "1";     # change the password after install
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # set the default shell on os to zsh
  users.defaultUserShell = pkgs.bash;

  environment.systemPackages = with pkgs; [
    pkgs.dmenu
    pkgs.dwmbar

    # web browser
    pkgs.brave

    # text editior
    pkgs.neovim

    # terminals
    pkgs.st

    pkgs.xorg.xrandr
    pkgs.xorg.xdm
    pkgs.xorg.xinit

    # used to manage dotfiles    
    # per user basis
    pkgs.home-manager
  ];
    
  # pipewire is used for screen sharing
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}
