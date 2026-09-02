{ inputs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
  home-manager.users.epark = ./epark.nix;
  home-manager.backupFileExtension = "backup";
}
