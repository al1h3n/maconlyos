# macos.nix - all related to macOS settings.
# nix-darwin.github.io/nix-darwin/manual
{ config, pkgs } :{
  system = {
    defaults = {
      dock = {
        autohide = true;
        orientation = "bottom"; # left.

        show-recents = false;
        minimize-to-application = true;

        persistent-apps = [
          "/Applications/Firefox.app"
          "/Applications/Nix Apps/VSCodium.app"
          "/Applications/Nix Apps/Obsidian.app"
          "/Applications/Nix Apps/Vesktop.app"
          "/Applications/Nix Apps/Spotify.app"
          "/Applications/Nix Apps/kitty.app"
          "/Applications/Nix Apps/OBS.app"
        ];
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        FXEnableExtensionChangeWarning = false;
        ShowExternalHardDrivesOnDesktop = true; # false
        ShowPathbar = true;

        FXDefaultSearchScope = "SCcf";
      };

      iCal._first_day_of_week_ = “Monday”;
      screencapture.type = "jpg";
      loginwindow.GuestEnabled = false;

      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleIconAppearanceTheme = “RegularDark”;
        AppleInterfaceStyle = “Dark”;
        AppleMeasurementUnits = “Centimeters”;
        AppleMetricUnits = 1;
        AppleShowAllExtensions = true;
        AppleShowScrollBars = “Always”;
        AppleTemperatureUnit = “Celsius”;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        AutomaticallyInstallMacOSUpdates = false;

        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        ApplePressAndHoldEnabled = false;
      };
      
      keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true; # Equivalent of kb_options = ctrl:nocaps.
      };
    };

    activationScripts.applications.text =
    let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';
  };
}