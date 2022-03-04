{ buildGoApplication }:

buildGoApplication rec {
  pname = "nix-deps";
  version = "0.2";
  src = ./.;
  modules = ./gomod2nix.toml;
  CGO_ENABLED = true;
}
