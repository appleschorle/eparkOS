{
  config,
  lib,
  ...
}:
with lib; {
  options.myAudio.enable = mkEnableOption "System Audio";

  config = mkIf config.myAudio.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    services.blueman.enable = true;
  };
}
