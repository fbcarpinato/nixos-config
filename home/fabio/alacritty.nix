{ config, pkgs, ... }:

{

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 18;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };
}
