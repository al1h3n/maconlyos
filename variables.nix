# variables.nix
# Change what you need.

rec {

  version = "25.11";
  channel = "unstable";

  username = "al1h3n";
  host = "ManiacPC";
  os_name = "nix";
  system = "aarch64-darwin"; # Change to x86_64-darwin for Intel Mac.
  os_name_custom = "MaconlyOS";

  zone = "Asia/Almaty";
  
  lshared = /Users/${username}/maconlyos/shared;
  shared = lshared + "/config"; # Source dotfiles folder.
  media = lshared + "/molnios-media/wallpapers";
  hosts = "${shared}/hosts";

  zsh = "${shared}/.zshrc";
  zsh_theme = "${shared}/.p10k.zsh";

  fastfetch = "${shared}/fastfetch.jsonc";
  fastfetch_ascii = "${shared}/fastfetch-ascii";

  kitty = "${shared}/kitty";
  kitty_style = "${shared}/kittystyle";

  qbittorrent = "${shared}/qbittorrent";

}