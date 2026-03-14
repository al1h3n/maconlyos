# Dotfiles for all the apps.
{ ... }:
let
  path = ./dots;
  dots = [
    "firefox"
    "zsh"
    "qbittorrent"

  ];
in {
  imports = map (name: path + "/${name}.nix") dots;
}