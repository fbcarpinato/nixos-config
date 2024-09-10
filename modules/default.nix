{ config, pkgs, lib, ... }:

let
  pkgs-unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{

  imports = [

    # Enable memory optimization
    ./memory-optimization.nix

    # Nvidia drivers
    ./nvidia.nix

    # Set up users
    ./users.nix
  ];

  # PACKAGES ------------------------------------------------

  # List packages installed in system profile, common to all users.
  # To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor
    home-manager
  ];

  # Virtualbox
  users.extraGroups.vboxusers.members = [ "fabio" ];
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;

  # Obsidian needs electron, which is considered insecure
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Open Tablet Driver
  hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
  };

  boot.kernelModules = [ "uinput" ];
}
