{inputs}: {
  imports = [
    ./browser
    ./development
    ./terminal
    (import ./ide {nixvim = inputs.nixvim.nixosModules.nixvim;})
  ];
}
