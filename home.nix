{ config, pkgs, ... }:
{
    home-manager.users.hunter = {
        # packages for the hunter user are defined here along with some configs
        home.packages = [
            pkgs.git 

            # all-in-one re tool framework
            pkgs.rizin
            pkgs.rizinPlugins.rz-ghidra

            # some langs
            pkgs.libgcc
            pkgs.gcc
            pkgs.python312
            pkgs.go
            pkgs.rustup

            # nice python packages to have
            #pkgs.python312Packages.ropper
            #pkgs.python312Packages.ropgadget
            #pkgs.python312Packages.pwntools

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
              modifier = "Mod4"; # superkey

              gaps = rec {
                smartBorders = "on";
                smartGaps = true;
              };

              startup = [
                # Launch Firefox on start
                {command = "mako";}
              ];
            };
        };

        /* The home.stateVersion option does not have a default and must be set */
        home.stateVersion = "23.11";
    };
}
