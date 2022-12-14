{
  description = "Configurations for Ian's Darwin machines.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    igm = {
      url = "git+file:///Users/igm/dotfiles?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles-private-raw = {
      url = "git+file:///Users/igm/dotfiles-private";
    };
  };

  outputs = { igm, dotfiles-private-raw, nixpkgs, ... }:
    let
      private = igm.lib.mkPrivate {
        inherit (nixpkgs) lib;
        raw = import dotfiles-private-raw;
      };
      mkSystem = igm.lib.mkDarwinSystem;
    in
    {
      darwinConfigurations."ian-mbp-intel" = mkSystem {
        computerName = "Ian’s Macbook Pro Intel";
        hostName = "ian-mbp-intel";
        additionalOverlays = private.overlays;
        modules = private.modules;
      };
      darwinConfigurations."ian-mbp-2022" = mkSystem {
        isM1 = true;
        computerName = "Ian’s Macbook Pro 2022";
        hostName = "ian-mbp-2022";
        additionalOverlays = private.overlays;
        modules = private.modules;
      };
    };
}
