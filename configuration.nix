{ config, pkgs, lib, ... }:

{
    imports = [
        # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    networking.hostName = "workstation";
    time.timeZone = "America/Chicago";

    environment.systemPackages = with pkgs; [
        # default tools
        vim
        curl 
        htop 
        git
        brave 

        # -- useful languages --
        python312
        go
        libgcc

        # swaywm and some tools to use it 
        sway
        demu
        swaylock   
        swayrbar   
        alacritty  
        mako 

        # reversing tools
        rizin
        cutter 
        ghidra 
        python312Packages.ropper 
        python312Packages.ropgadget
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.initrd.checkJournalingFS = false;

    users.users = {
        hunter = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
            home = "/home/hunter";
            shell = pkgs.zsh;
        };
    };

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

    system.autoUpgrade.enable = true;
    system.autoUpgrade.allowReboot = true;

    # Enable the OpenSSH server.
    services.sshd.enable = true;
}

