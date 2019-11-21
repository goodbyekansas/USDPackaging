{ nixpkgs ? import <nixpkgs> {} }:
let
  pyenv = (nixpkgs.python27.withPackages (ps: with ps; [ pyside2 jinja2 pyopengl pyside2-tools ]));
in
with nixpkgs;
gcc6Stdenv.mkDerivation {
  name = "USD-Core";
  nativeBuildInputs = [
    cmake
    cacert
  ];

  buildInputs = [ 
    glew
    xorg.libXxf86vm
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXi
    zlib
  ];

  propagatedBuildInputs = [
    pyenv
  ];

  src = fetchFromGitHub {
    owner = "goodbyekansas";
    repo = "USD";
    rev = "gbk";
    sha256 = "0i9b42sncs7mbg60198x6xzm8zr93g3c0pk0iwwf2srmn4vfz5cz";
  };

  phases = [ "unpackPhase" "buildPhase" ];

  TBB_PLATFORM=linux;
  buildPhase = ''
    ${pyenv}/bin/python build_scripts/build_usd.py --build-args boost,"--with-date_time --with-thread --with-system --with-filesystem" --no-maya -v $out/
  '';
}
