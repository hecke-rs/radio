let
  pkgs = import <nixpkgs> {};
  inherit (pkgs) stdenv;
in
  {
    frontend = stdenv.mkDerivation {
      name = "web-0.1";
      src = ./frontend;
      buildInputs = with pkgs.elmPackages; [ elm elm-make ];
      # default build phase will call make for us; we don't need to do that.
      installPhase = ''
        mkdir -p $out/
        cp -r $src/index.html $src/app.js $src/assets $out/
      '';
    };
  }

