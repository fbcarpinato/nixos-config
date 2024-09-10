{ config, pkgs, hardware, lib, ... }:

{

  home.username = "fabio";
  home.homeDirectory = lib.mkForce  "/home/fabio";

  imports = [
    ./rofi.nix
    ./waybar.nix
    ./alacritty.nix
    ./zsh.nix
    ./tmux.nix
    ./git.nix
    ./nvim.nix
  ];

  home.file.".config/hypr/hyprland.conf" = {
    # Overwrite the file
    force = true;
    text = builtins.readFile ./hyprland.conf;
  };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # Applications
    firefox
    obsidian
    bitwarden

    # Developement
    strace
    gcc
    luarocks
    lua5_1
    nodejs

    # Utilities / Misc
    unzip
    ripgrep           # the cooler grep
    tree              # list files and folder in a tree structure
    cowsay            # For fun
    fzf

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
    hyprpaper         # wallpaper engine for hyprland

    # Fonts
    nerdfonts
  ];

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

}

