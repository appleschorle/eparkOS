{
  lib,
  pkgs,
  config,
  ...
}:
with lib; {
  imports = [];

  options = {
    myUsers = {
      names = mkOption {
        type = types.listOf types.str;
        default = [];
        example = ["user1" "user2"];
        description = "List of user-names to create on the system";
      };
    };
  };

  config = mkIf (config.myUsers.names != null || config.myUsers.names != []) {
    users = {
      # Set password manually after login using passwd
      # There were some issues with managing the password with nix which is why this approach is the most straightforward
      mutableUsers = true;

      users = builtins.listToAttrs (map (userName: {
          name = "${userName}";
          value = {
            isNormalUser = true;
            extraGroups = [
              "wheel" # sudo
              "networkmanager"
              "storage"
              "audio"
              "video"
              "camera"
              "lp" # printer devices
              "scanner"
            ];
            packages = [];
          };
        })
        config.myUsers.names);
    };
  };
}
