{ nixpkgs ? import <nixpkgs> {} }:
let
  usd-core = nixpkgs.callPackage ./usd-core.nix {};
  maya-devkit = nixpkgs.callPackage ./maya-devkit.nix {};
in
  with nixpkgs;
  (overrideCC stdenv gcc6).mkDerivation {
    name = "maya-usd";
    nativeBuildInputs = [
      cmake
      git
      cacert
    ];

    buildInputs = [
      libGL
      usd-core
      python27
      maya-devkit
      python27Packages.jinja2
      python27Packages.pyopengl
      python27Packages.pyside2
      xorg.libX11
    ];

    src = fetchFromGitHub {
      owner = "goodbyekansas";
      repo = "maya-usd";
      rev = "master";
      sha256 = "0idwxim4hfgkjv22rdikpbjzrm8zr7s6rfhlbp95ai4xb59zp0p0";
    };

    

    phases = [ "unpackPhase" "buildPhase" ];

    buildPhase = ''
        ls ${usd-core}/bin
        export PATH=${usd-core}/bin:$PATH
        ${python27}/bin/python build.py --pxrusd-location ${usd-core} --maya-location /usr/autodesk/maya2019 --build-args="-DSKIP_USDMAYA_TESTS=ON" --install-location $out /tmp/workspace
    '';
  }

