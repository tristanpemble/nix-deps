self: super:

{
  nix-deps = self.callPackage ./. {};
}
