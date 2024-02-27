{ config, pkgs, ... }:
let
    home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
    imports = [
        (import "${home-manager}/nixos")
    ];

    home-manager.users.my_username = {
        /* The home.stateVersion option does not have a default and must be set */
        home.stateVersion = "18.09";

        # packages for the hunter user are defined here along with some configs
        home.packages = [
            pkgs.neovim
            pkgs.git 
            pkgs.brave

            # all-in-one re tool framework
            pkgs.rizin
            pkgs.rizinPackages.rzghidra
            pkgs.python312Packages.ropper

            pkgs.libgcc
            pkgs.python312
            pkgs.go
            pkgs.rustup

            # packages needed for swaywm
            pkgs.sway
            pkgs.swayrbar
            pkgs.swaylock

            # nice python packages to have
            pkgs.python312Packages.ropper
            pkgs.python312Packages.ropgadget
            pkgs.python312Packages.pwntools

        ];

        # can be used if we want to use git version control in the future
        #programs.git = {
        #    enable = true;
        #    userName  = "my_git_username";
        #    userEmail = "my_git_username@gmail.com";
        #};

        programs.neovim = {
          enable = true;
          extraConfig = ''
            set number relativenumber
          '';
        };

        programs.sway.enable = true;
        wayland.windowManager.sway = {
            enable = true;
            config = rec {
              modifier = "Mod4";
              # Use kitty as default terminal
              terminal = "alacritty"; 
            };
          };
    };
}
