# dns.nix - Custom DNS using Quad9 (MaconlyOS).
{ ... }: {
  networking = {
    knownNetworkServices = [
      "Wi-Fi"
      "Ethernet"
      "Thunderbolt Ethernet"
    ];
    dns = [
      # IPv4
      "9.9.9.9"
      "149.112.112.112"
      # IPv6
      "2620:fe::fe"
      "2620:fe::9"
    ];
  };
}