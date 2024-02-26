{ config, pkgs, lib, ... }:

{
    networking.hostName = "workstation";
    time.timeZone = "America/Chicago";

    environment.systemPackages = with pkgs; [
        # default tools
        vim
        curl 
        htop 
        firefox 

        # -- useful poc languages --
        python312
        go

        # swaywm and some tools to use it 
        sway
        swaylock   
        swayrbar   
        alacritty  
        mako 
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.version = 2;
    boot.loader.grub.device = "/dev/sda";

    users.users = {
        hunter = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
            home = "/home/hunter";
            shell = pkgs.zsh;
        };
    };

    users.users.hunter.packages = with pkgs; [
        rizin
        cutter 
        ghidra 
        python312Packages.ropper 
        python312Packages.ropgadget
    ];

    services = {
        networking = {
            networkmanager.enable = true;
            networkmanager.networks = {
                wired = {
                    dhcp4 = true;
                };
            };
        };
    };

    sway = {
            enable = true;
            extraPackages = with pkgs; [
                # Add additional packages for Sway configuration here
            ];
        };

        swaylock = {
            enable = true;
        };

        mako = {
            enable = true;
        };

        swayrbar = {
            enable = true;
        };
    };
}

