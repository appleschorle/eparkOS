{flakeRootPath, ...}: {
  imports = [
    "${flakeRootPath}/modules/home-manager/development/git.nix"
  ];

  epark.development.git = {
    enable = true;
    userEmail = "eugenepark2001@gmail.com";
  };
}
