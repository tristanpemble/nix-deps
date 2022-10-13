{
  description = "A very basic flake";

  inputs.flake-compat.url = "github:edolstra/flake-compat";
  inputs.flake-compat.flake = false;
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.gomod2nix.url = "github:tweag/gomod2nix";

  outputs = { self, flake-utils, gomod2nix, nixpkgs, ... }:
    let
      mkPkgs = system: import nixpkgs {
        inherit system;
        overlays = [ gomod2nix.overlays.default ];
      };
    in
    {
      packages = flake-utils.lib.eachDefaultSystemMap (system: let pkgs = mkPkgs system; in {
        default = self.packages.${system}.nix-deps;
        nix-deps = pkgs.buildGoApplication {
          pname = "nix-deps";
          version = "0.4";
          src = ./.;
          modules = ./gomod2nix.toml;
          CGO_ENABLED = true;
          hardeningDisable = [ "format" ];
        };
      });

      devShells = flake-utils.lib.eachDefaultSystemMap (system: let pkgs = mkPkgs system; in {
        default = pkgs.mkShell {
          buildInputs = [ pkgs.go pkgs.gomod2nix ];
        };
      });

      apps.default = flake-utils.lib.eachDefaultSystemMap (system: {
        type = "app";
        program = "${self.packages.${system}.nix-deps}/bin/nix-deps";
      });

      overlays.default = final: prev: {
        nix-deps = self.packages.${final.system}.nix-deps;
      };
    };
}
