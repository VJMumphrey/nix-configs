{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{

  imports = [
    (import "${home-manager}/nixos")
    ./hardware-configuration.nix
  ];

  # for UEFI
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  # for non-uefi systems 
  boot.loader.grub.enable = true;
  #boot.loader.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.networkmanager.enable = true;
  #services.openssh.enable = true;
  
  security.polkit.enable = true;
  
  system.stateVersion = "23.11"; # Did you read the comment?

  users.users."hunter" = {
    isNormalUser = true;
    initialPassword = "1";     # change the password after install
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  programs.sway.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # set the default shell on os to zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    # status bar
    pkgs.swayrbar
    pkgs.swaylock
    pkgs.swayidle

    # notification
    pkgs.mako
    libnotify

    pkgs.networkmanagerapplet

    # bg 
    pkgs.swww

    # terminal
    pkgs.alacritty

    # app launcher 
    pkgs.rofi-wayland

    # web browser
    pkgs.brave

    # text editior
    pkgs.neovim

    # screenshot tool
    pkgs.grim
  ];
    
  # this is for X compatibility 
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # pipewire is used for screen sharing
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}
