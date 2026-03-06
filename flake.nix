{
  description = "Configurations for Ian's Darwin machines.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    igm = {
      url = "git+file:///Users/igm/dotfiles";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles-private-raw = {
      url = "git+file:///Users/igm/dotfiles-private";
    };
  };

  outputs =
    {
      igm,
      dotfiles-private-raw,
      ...
    }:
    let
      mkSystem = igm.lib.mkDarwinSystem;
    in
    {
      darwinConfigurations."ian-mbp-intel" = mkSystem {
        computerName = "Ian's Macbook Pro Intel";
        hostName = "ian-mbp-intel";
        modules = [ dotfiles-private-raw.darwinModules.default ];
      };
      darwinConfigurations."ian-mbp-2022" = mkSystem {
        isM1 = true;
        computerName = "Ian's Macbook Pro 2022";
        hostName = "ian-mbp-2022";
        modules = [ dotfiles-private-raw.darwinModules.default ];
      };
    };
}
