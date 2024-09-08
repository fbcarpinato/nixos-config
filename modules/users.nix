{ pkgs, ... }:

{
  users.users.fabio = {
    isNormalUser = true;
    description = "fabio";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
       # Define packages here
    ];
  };
}

