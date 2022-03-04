{ pkgs ? import <nixpkgs> {} }:

let
  mkDep = name: buildInputs: pkgs.stdenv.mkDerivation {
    inherit name buildInputs;
    unpackPhase = "true";
    buildPhase = "true";
    installPhase = "touch $out";
  };
in rec {
  z = mkDep "z" [a b c d e f g h];
  a = mkDep "a" [];
  b = mkDep "b" [a];
  c = mkDep "c" [a b];
  d = mkDep "d" [];
  e = mkDep "e" [c d];
  f = mkDep "f" [b];
  g = mkDep "g" [a];
  h = mkDep "h" [a e];
}
