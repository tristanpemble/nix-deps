self: super:

{
  nix-deps = (import ./.).defaultPackage.${self.system};
}
