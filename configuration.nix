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
        zsh

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

        # TODO hyperland is better for keybinds

        # reversing tools
        rizin
        rizinPlugins.rz-ghidra

        # this might still work
        cutterPlugins.sigdb

        # python packages for ROP exploitation
        python312Packages.ropper 
        python312Packages.ropgadget

        # other plugins   
        python312Packages.pwntools
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/vda3";

    users.users = {
        hunter = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
            home = "/home/hunter";
            shell = pkgs.zsh;
        };
    };

    networking.firewall.enable = true;
    networkmanager.enable = true;
    networkmanager.networks.wired.dhcp4 = true;

    programs.sway.enable = true;
    programs.swaylock.enable = true;
    programs.mako.enable = true;
    programs.swayrbar.enable = true;

    system.autoUpgrade.enable = true;
    system.autoUpgrade.allowReboot = true;

    # Enable the OpenSSH server.
    services.sshd.enable = true;
}

