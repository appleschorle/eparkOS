{flakeRootPath, ...}: {
  imports = [
    "${flakeRootPath}/modules/home-manager/development/git.nix"
  ];

  epark.development.git = {
    enable = true;
    userEmail = "eugene.park@scania.com";
  };
}
