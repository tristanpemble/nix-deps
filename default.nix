{ buildGoApplication }:

buildGoApplication rec {
  pname = "nix-deps";
  version = "0.1";
  src = ./.;
  modules = ./gomod2nix.toml;
  CGO_ENABLED = true;
}
