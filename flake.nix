{
  description = "A very basic flake";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.gomod2nix.url = "github:tweag/gomod2nix";

  outputs = { self, flake-utils, gomod2nix, nixpkgs }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          gomod2nix.overlay
        ];
      };
    in rec {
      defaultApp = {
        type = "app";
        program = "${defaultPackage}/bin/nix-deps";
      };
      defaultPackage = pkgs.callPackage ./default.nix {};
      devShell = pkgs.callPackage ./shell.nix {};
      overlay = import ./overlay.nix;
    }
  );
}
