{ ... }:
let radioPkgs = import ../../deploy/default.nix; in {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
  ];

  networking.hostName = "backend";
  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.openssh.enable = true;

  services.nginx.enable = true;
  services.nginx.recommendedOptimisation = true;
  services.nginx.recommendedTlsSettings = true;
  services.nginx.recommendedGzipSettings = true;
  services.nginx.virtualHosts."radio.hecke.rs" = {
    enableACME = true;
    forceSSL = true;
    root = "${radioPkgs.frontend}/";
  };

  users.mutableUsers = true;
  users.extraUsers.admin = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    group = "users";
    initialPassword = "funkitup";

    # wow such pubkey
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC7prX4rZ9sn3viP67UOCfFp53ApkcrkcEqI2ml5FPg1iqRPUevd5y7Oyyvl99dFFgf0PslPBuWQuVPVQRYTxjssUVRjTOH76wy3Vyd4D2KF+6h6RC6i/2cqhQudf3DoFFitbRe7hUGcDD9s0soJ5J6e1qp072NK8nDta9h1wU4+Y6YAjHQIlcm8p99pIxxPcFkvDYVeBdTXDhbky+sI049TVWUfCG6pclbw5aMwDTH1N9pG7Ul8YHBWt3CUoYeUQhWvtrfpEo1T0hVN1f1JuIJuem/dYPJiAKOVZD2u+S7FCh+q4vJ03c3NwNzoJHKrYaVrJAq1GiF2Ejs1fkR3E5ok4iSfcGPA+MOrSUcEorTBXEGG+ya+uiyW6bmmbKMgbGxgKc411I5zVyeBwGjbhFGSyH+kIPA097LHdUEuT5g8Wbv/JyhNKL0kts5e39+lVmEY9+PeymDU2BXoJhtosJn7IF1I8jtKNHY0d7fts2qGsUcCqi2WAor3bjYcaFFqq6NdVezoE9kiE57edF0xVOqM5rXrCDFVdwG2wHc0VopDvh8K7m6pqgB+slWKBGbuMNNXKFY0gRbVyx7VdlGgDlT9s0jFrFEL0mlwiy2dS6arz8IbY9b6vhI2Ksus7S7xiGmtGb2wXZTXc+GQfMUu/TCSrOkQfgzWCpfw3JQqp2OUw=="
    ];
  };

  boot.cleanTmpDir = true;
}
