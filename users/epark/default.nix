{ ... }: {
  imports = [
    ../../modules/home-manager
  ];

  config = {
    home = {
      username = "epark";
      homeDirectory = "/home/epark";
      stateVersion = "25.05";
    };
  };
}
