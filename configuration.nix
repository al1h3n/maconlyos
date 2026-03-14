# configuration.nix
# run darwin-rebuild switch to reload
{ config, pkgs, ... }:
let
  variables = import ./variables.nix;
in {

  # 1. Nix settings.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # 2. System identity.
  networking.hostName = variables.host;
  time.timeZone = variables.zone;

  # 3. User configuration.
  users.users.${variables.username} = {
    description = "User account created by MolnixOS configuration.";
    home = "/Users/${variables.username}";
    shell = pkgs.zsh;
  };

  # 4. Shell.
  programs.zsh.enable = true;

  # 5. Packages available system-wide.
  environment = {
    variables = {
      SHARED_PATH   = variables.shared;
      SHARED_MEDIA_PATH = variables.media;
      L_PATH = variables.lshared;
      JAVA_HOME = "${pkgs.temurin-bin-21}";
      GTK_THEME = variables.theme_gtk;
    };
    systemPackages = with pkgs; [
      # Programming.
      gcc python3 pipx temurin-bin-8 temurin-bin-21 temurin-bin-25

      # Main tools.
      curl git openssh killall
      fastfetch countryfetch btop neovim
    ];
  };

  # 6. Fonts.
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # 7. macOS-specific system preferences (System Settings equivalent).
  system = {
    stateVersion = 5; # nix-darwin state version, not NixOS.

    defaults = {
      # Dock.
      dock = {
        autohide = true;
        show-recents = false;
        minimize-to-application = true;
      };
      # Finder.
      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        FXDefaultSearchScope = "SCcf"; # Search current folder.
      };
      # Keyboard.
      NSGlobalDomain = {
        InitialKeyRepeat = 15;   # Closest to autoRepeatDelay = 200ms.
        KeyRepeat = 2;           # Closest to autoRepeatInterval = 35ms.
        ApplePressAndHoldEnabled = false; # Allow key repeat.
      };
      # Screenshots.
      screencapture.location = "~/Pictures/Screenshots";
    };

    # Keyboard shortcut to switch input source (equivalent of hyprland space bind).
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true; # Equivalent of kb_options = ctrl:nocaps.
    };
  };

  # 8. Services.
  services = {
    # Nix daemon - required on macOS.
    nix-daemon.enable = true;
  };

  # 9. Homebrew - for macOS-only apps not in nixpkgs.
  # Install brew first: brew.sh
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # Remove unlisted packages.
    };
    casks = [
      "steam"
      "logi-options+"  # replaces piper/openrgb for Logitech
      "stats"          # replaces cpu-x
      "whisky"         # replaces wine stack
    ];
  };
}
