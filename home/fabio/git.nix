{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "Fabio Carpinato";
    userEmail = "fabiocarpinato@outlook.it";

    signing.key = "CFCFAA7433D62D92";
    signing.signByDefault = true;
  };
}

