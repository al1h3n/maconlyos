{ pkgs, variables, ... }: {
  home = {
    username = variables.username;
    homeDirectory = "/Users/${variables.username}";
    packages = with pkgs; [
      # Multimedia
      mpv songrec obs-studio
      ffmpeg-headless imagemagick_light
      # Utilities
      cava
      # Studying
      (anki.withAddons [
        ankiAddons.passfail2
        ankiAddons.anki-connect
      ])
      # Coding
      vscodium
      # Gaming
      prismlauncher
      # Social
      vesktop _64gram
      # Notes
      obsidian notion-app
      # Music
      spotify
      # Shell
      eza yazi fzf kitty
    ];
  };
}