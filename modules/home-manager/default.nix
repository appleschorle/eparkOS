{...}: {
  imports = [
    ./desktop/app
  ];
  config = {
    programs.home-manager.enable = true;
  };
}
