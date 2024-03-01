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
  
  users.users."hunter" = {
    isNormalUser = true;
    initialPassword = "1";     # change the password after install
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # enable sway and wayland 
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WL_ENABLE_SOFTWARE_RENDERING = "1";

  # set the default shell on os to zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    # status bar
    pkgs.sway
    pkgs.swayrbar
    pkgs.swaylock
    pkgs.swayidle

    # notification
    pkgs.mako
    pkgs.libnotify

    # web browser
    pkgs.brave

    # text editior
    pkgs.neovim

    # terminals
    pkgs.foot

    # screenshot tool
    pkgs.grim

    # wayland xrandr 
    pkgs.wlr-randr

    # used to manage dotfiles    
    # per user basis
    pkgs.home-manager
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
