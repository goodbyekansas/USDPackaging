{ nixpkgs ? import <nixpkgs> {} }:
with nixpkgs;
stdenv.mkDerivation {
    name = "maya-devkit";
    src = fetchurl {
      url = "https://autodesk-adn-transfer.s3-us-west-2.amazonaws.com/ADN+Extranet/M%26E/Maya/devkit+2019/Autodesk_Maya_2019_2_Update_DEVKIT_Linux.tgz";
      sha256 = "11v7hi1n01j7p7wkqabdjllndkic96mv6nq83rqh845psc684hs1";
    };

    phases = [ "unpackPhase" "buildPhase" ];

    buildPhase = ''
        cp -r . $out
    '';
}

