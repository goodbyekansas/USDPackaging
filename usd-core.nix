{ nixpkgs ? import <nixpkgs> {} }:
let
nixpkgsa = import <nixpkgs> {
   overlays = [ (self: super: {
      glibc = super.glibc_multi.overrideAttrs (old: rec {
        src = super.fetchurl {
          url = "mirror://gnu/glibc/glibc-2.19.tar.gz";
          sha256 = "15n7x9mmzhd7w6s5hd9srx0h23b32gwb306x98k9ss940yvnvb8q";
        };
      });
   })];
  };
in
with nixpkgs;
(overrideCC stdenv gcc6).mkDerivation {
  name = "USD-Core";
  nativeBuildInputs = [
    cmake
    cacert
  ];

  buildInputs = [ 
    glew
    nixpkgsa.glibc
    xorg.libXxf86vm
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXi
    zlib
    python27
    python27Packages.jinja2
    python27Packages.pyside2
    python27Packages.pyside2-tools
    python27Packages.pyopengl
  ];

  src = fetchFromGitHub {
    owner = "goodbyekansas";
    repo = "USD";
    rev = "gbk";
    sha256 = "0i9b42sncs7mbg60198x6xzm8zr93g3c0pk0iwwf2srmn4vfz5cz";
  };

  phases = [ "unpackPhase" "buildPhase" ];

  buildPhase = ''
    export TBB_PLATFORM=linux
    ${python27}/bin/python build_scripts/build_usd.py --build-args boost,"--with-date_time --with-thread --with-system --with-filesystem" --no-maya -v $out/
  '';
}
