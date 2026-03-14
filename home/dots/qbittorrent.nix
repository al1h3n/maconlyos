# qbittorrent.nix - MaconlyOS
{ pkgs, config, variables, ... }:
let
  fetchCatpuccin = name: builtins.fetchurl "https://github.com/catppuccin/qbittorrent/releases/latest/download/catppuccin-${name}.qbtheme";
  frappe    = fetchCatpuccin "frappe";
  macchiato = fetchCatpuccin "macchiato";
  mocha     = fetchCatpuccin "mocha";
  fetchMica = name: builtins.fetchurl "https://github.com/witalihirsch/qBitTorrent-fluent-theme/releases/latest/download/defaulticons-fluent-${name}-no-mica.qbtheme";
  fluent-light = fetchMica "light";
  fluent-dark  = fetchMica "dark";

  qbDir = "Library/Application Support/qBittorrent";
in {
  home.packages = [ pkgs.qbittorrent ];

  # Config.
  home.file."${qbDir}/qBittorrent.conf" = {
    source = variables.qbittorrent;
    force  = true;
  };

  # Themes.
  home.file."${qbDir}/themes/catppuccin-frappe.qbtheme".source    = frappe;
  home.file."${qbDir}/themes/catppuccin-macchiato.qbtheme".source = macchiato;
  home.file."${qbDir}/themes/catppuccin-mocha.qbtheme".source     = mocha;
  home.file."${qbDir}/themes/fluent-light.qbtheme".source         = fluent-light;
  home.file."${qbDir}/themes/fluent-dark.qbtheme".source          = fluent-dark;
}