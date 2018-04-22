{ ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [
      "67.207.67.2"
      "67.207.67.3"
    ];
    defaultGateway = "206.189.160.1";
    defaultGateway6 = "";
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="206.189.160.23"; prefixLength=20; }
{ address="10.46.0.5"; prefixLength=16; }
        ];
        ipv6.addresses = [
          { address="2604:a880:2:d0::2090:b001"; prefixLength=64; }
{ address="fe80::6894:80ff:fe67:91ab"; prefixLength=64; }
        ];
      };

    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="6a:94:80:67:91:ab", NAME="eth0"
    ATTR{address}=="ca:73:86:f4:83:5a", NAME="eth0"
  '';
}
