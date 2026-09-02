{ ... }:
{
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/epark/.config/sops/age/keys.txt";
}
