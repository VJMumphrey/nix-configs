{ config, pkgs, ... }:
{
    home-manager.users.hunter = { pkgs, ...}: {

        # packages for the hunter user are defined here along with some configs
        home.packages = [
            pkgs.git 

            # all-in-one re framework
            # install plugins seperatly
            pkgs.radare2

            # has better analysis than r2    
            pkgs.rizin

            # some langs
            pkgs.libgcc
            pkgs.gcc
            pkgs.python312
            pkgs.go
            pkgs.rustup

            # should contain most archs    
            pkgs.qemu

            # fonts
            pkgs.fira-mono

            # for the builds 
            pkgs.gnumake
            pkgs.pkg-config
            pkgs.unzip

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
          extraLuaConfig = ''
            vim.opt.guicursor = ""
            vim.opt.nu = true
            vim.opt.relativenumber = true
            vim.opt.tabstop = 4
            vim.opt.softtabstop = 4
            vim.opt.shiftwidth = 4
            vim.opt.expandtab = true
            vim.opt.smartindent = true
            vim.opt.wrap = false
            vim.opt.swapfile = false
            vim.opt.backup = false
            vim.opt.hlsearch = false
            vim.opt.incsearch = true
            vim.opt.termguicolors = true
            vim.opt.scrolloff = 8
            vim.opt.updatetime = 50
          '';
        };

        programs.foot = {
            enable = true;
            settings = {
                main = {
                    term = "foot";
                };
                mouse = {
                    hide-when-typing = "yes";
                };
            };
        };

        wayland.windowManager.sway = {
            enable = true;
            config = rec {
              modifier = "Mod4"; # superkey

              gaps = rec {
                smartBorders = "on";
                smartGaps = true;
              };

              # default terminal
              terminal = "foot -f 'monospace:size=12'";

              startup = [
                # Launch mako on start
                {command = "mako";}

                # resize screent to normal size 
                {command = "wlr-randr --output Virtual-1 --mode 1920x1080";}
              ];
            };
        };

        /* The home.stateVersion option does not have a default and must be set */
        home.stateVersion = "23.11";
    };
}
