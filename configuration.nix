{ config, pkgs, ... }:

{ 
  imports =
    [
      ./hardware-configuration.nix
    ];

  # for UEFI
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  # for non-uefi systems 
  boot.loader.grub.enable = true;
  boot.loader.device = "/dev/vda";
  # boot.loader.grub.useOSProber = true;

  networking.networkmanager.enable = true;
  #services.openssh.enable = true;
  
  security.polkit.enable = true;
  
  system.stateVersion = "23.11"; # Did you read the comment?

  users.users."hunter" = {
    isNormalUser = true;
    initialPassword = "1";     # change the password after install
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.

    imports = [
        ./home.nix
    ];
  };

  programs.sway.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # set the default shell on os to zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  evniroment.systemPackages [
    # status bar
    pkgs.swayrbar
    pkgs.swaylock
    pkgs.swayidle

    # notification
    pkgs.mako
    libnotify

    pkgs.networkmanagerapplet

    # bg 
    swww

    # terminal
    alacritty

    # app launcher 
    rofi-wayland

    # web browser
    brave

    # text editior
    neovim

    # screenshot tool
    grim
  ];
    
  # this is for X compatibility 
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # pipwire is used for screen sharing
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipwire = {
    enable = true;
    alsa.enable = true;
    alsa.support32bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };
}
