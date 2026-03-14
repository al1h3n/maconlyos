# configuration.nix
{ config, pkgs, ... }:
let
  variables = import ./variables.nix;
in {
  # 1. Imports.
  imports = [
      # 1.1. Updating schedule.
      ./system/updates.nix

      # 1.2. System files.
      ./system/hosts.nix 
      ./system/autolaunch.nix
      ./system/dns.nix
      ./system/macos.nix
    ];

  # 1. Nix settings.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # 2. System identity.
  networking.hostName = variables.host;
  time.timeZone = variables.zone;

  # 3. User configuration. Use name = "x" to add multiple accounts.
  users.users.${variables.username} = {
    description = "User account created by MaconlyOS configuration.";
    home = "/Users/${variables.username}";
    shell = pkgs.zsh;
  };

  # 4. Shell.
  programs.zsh.enable = true;

  # 5. Packages available system-wide.
  environment = {
    variables = {
      L_PATH = variables.lshared;
      SHARED_MEDIA_PATH = variables.media;
      JAVA_HOME = "${pkgs.temurin-bin-21}";
      GTK_THEME = variables.theme_gtk;
    };
    systemPackages = with pkgs; [
      # Programming.
      gcc python3 pipx temurin-bin-8 temurin-bin-21 temurin-bin-25

      # Main tools.
      curl git openssh killall
      fastfetch countryfetch btop neovim

      # Activation
      mkalias
    ];
  };
  
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # 6. Services.
  services = {
    # Nix daemon - required on macOS.
    nix-daemon.enable = true;
  };

  # 7. Homebrew - for macOS-only apps not in nixpkgs.
  # Install brew first: brew.sh
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # Remove unlisted packages.
    };
    casks = [
      # Utilities
      "mounty" "the-unarchiver" "iina" "stats"

      # Gaming
      "steam" "whisky" "logi-g-hub"

      # Art.
      # fl-studio
    ];
    masApps = {
      "Yoink" = 457622435;
      "Xcode" = 497799835;
      "Word"       = 462054704;
      "Excel"      = 462058435;
      "PowerPoint" = 462062816;
    };
  };
}
