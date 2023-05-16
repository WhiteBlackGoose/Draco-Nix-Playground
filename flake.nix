{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.my-nix.url = "github:WhiteBlackGoose/my-nix/master";
  outputs = { nixpkgs, my-nix, ... }:
  let 
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ]; in
  {
    devShells = nixpkgs.lib.genAttrs systems (arch: {
      default = my-nix.dotnetShell 
        nixpkgs.legacyPackages.${arch}
          (p: [ p.sdk_7_0 ])
          (p: [ p.draco-langserver ])
          ;
    });
  };
}
