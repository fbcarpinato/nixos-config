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

    # Applications
    firefox
    obsidian

    # Developement
    neovim
    git
    strace
    zsh-autosuggestions
    zsh-syntax-highlighting
    tmux              # Terminal multiplexer

    # Utilities / Misc
    unzip
    ripgrep           # the cooler grep
    tree              # list files and folder in a tree structure
    cowsay            # For fun

    # Virtualisation
    docker
    docker-compose
    qemu
 
    # Networking
    wget
    curl
    
    # Wayland specific
    waybar            # Simple bar, configured with json and css
    dunst             # Notification manager
    libnotify         # Dependency of dunst
    rofi-wayland      # Wailand compatible rofi
    rofi-power-menu   # Rofi but for power menu
    grim              # Take screenshot
    slurp             # Select a region
    wl-clipboard      # Save on clipboard from terminal
    kitty             # Wayland terminal 
    hyprpaper         # wallpaper engine for hyprland
    wl-gammactl       # anage screen gamma and contrast
    greetd.wlgreet    # display / login manager
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
