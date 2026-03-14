# updates.nix - Updates, maintenance and performance (MaconlyOS).
{ ... }: {
  # Auto upgrade - nix-darwin equivalent.
  services.nix-daemon.enable = true;

  nix = {
    # Garbage collection - uses interval instead of dates.
    gc = {
      automatic = true;
      interval = { Day = 1; }; # Daily, equivalent of "daily".
      options = "--delete-older-than 10d";
    };

    # Store optimisation.
    optimise.automatic = true; # Replaces auto-optimise-store on macOS.

    settings = {
      max-jobs = "auto";
      cores = 0;
      # Binary caches - macOS relevant ones only.
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}