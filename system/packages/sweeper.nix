# sweeper.nix - MaconlyOS
{ pkgs, variables, ... }:
let
  sweeperScript = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/Alihan1ai9595/sweeper/unobfusticated/sweeper.sh";
  };
in {
  # Makes script available system-wide as a package.
  environment.systemPackages = [
    (pkgs.writeScriptBin "sweeper" (builtins.readFile sweeperScript))
  ];

  # launchd user agent — macOS equivalent of systemd user service.
  launchd.user.agents.sweeper = {
    serviceConfig = {
      Label = "com.molnios.sweeper";
      ProgramArguments = [
        "${pkgs.bash}/bin/bash"
        "${sweeperScript}"
      ];
      # Equivalent of wantedBy default.target — runs on login.
      RunAtLoad = true;
      # Equivalent of oneshot + RemainAfterExit.
      KeepAlive = false;
    };
  };
}