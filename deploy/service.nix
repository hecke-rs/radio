{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.radio;
in {
  options = {
    services.radio = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {
    services.postgresql.enable = true;

    systemd.services.radio = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" "postgresql.service" ];
    };

    users.extraUsers.radio = {
      group = "radio";
      uid = 1111;
    };
    users.extraGroups.radio.gid = 1111;
  };
}
