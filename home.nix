{ config, pkgs, ... }:
{
    home-manager.users.my_username = {
        /* The home.stateVersion option does not have a default and must be set */
        home.stateVersion = "20.03";

        # packages for the hunter user are defined here along with some configs
        home.packages = [
            pkgs.neovim
            pkgs.git 
            pkgs.brave

            # all-in-one re tool framework
            pkgs.rizin
            pkgs.rizinPlugins.rz-ghidra

            # some langs
            pkgs.libgcc
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
              modifier = "Mod1"; # left Alt
              # Use alacritty as default terminal
              terminal = "alacritty"; 
              startup = [
                # Launch Firefox on start
                {command = "mako";}
              ];
            };
        };
    };
}
