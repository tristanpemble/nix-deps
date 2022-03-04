{ pkgs }:

pkgs.mkShell {
  buildInputs = [ pkgs.go pkgs.gomod2nix ];
}
