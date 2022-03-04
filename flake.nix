{
  description = "A very basic flake";

  inputs.flake-compat.url = "github:edolstra/flake-compat";
  inputs.flake-compat.flake = false;
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.gomod2nix.url = "github:tweag/gomod2nix";

  outputs = { self, flake-utils, gomod2nix, nixpkgs, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          gomod2nix.overlay
        ];
      };
    in rec {
      defaultPackage = pkgs.buildGoApplication {
        pname = "nix-deps";
        version = "0.4";
        src = ./.;
        modules = ./gomod2nix.toml;
        CGO_ENABLED = true;
        hardeningDisable = ["format"];
      };
      devShell = pkgs.mkShell {
        buildInputs = [ pkgs.go pkgs.gomod2nix ];
      };
      defaultApp = {
        type = "app";
        program = "${defaultPackage}/bin/nix-deps";
      };
      overlay = self: super: {
        nix-deps = defaultPackage;
      };
    }
  );
}
