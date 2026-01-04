{...}: {
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    settings = [
      # Default outputs
      {
        # Built-In Display
        output.criteria = "eDP-1";
        output.status = "enable";
        output.mode = "1920x1200@60.00Hz";
        output.position = "0,1080";
      }
      {
        # Main Monitor
        output.criteria = "Dell Inc. DELL P2425HE CNQFD94";
        output.status = "enable";
        output.mode = "1920x1080@100.00Hz";
        output.position = "0,0";
      }
      {
        # Rotated Monitor
        output.criteria = "Dell Inc. DELL P2425HE FNQFD94";
        output.status = "enable";
        output.mode = "1920x1080@100.00Hz";
        output.position = "1920,0";
        output.transform = "90";
      }

      # Profiles
      {
        profile.name = "laptop";
        profile.outputs = [
          {criteria = "eDP-1";}
        ];
      }
      {
        profile.name = "laptop-main";
        profile.outputs = [
          {criteria = "eDP-1";}
          {criteria = "Dell Inc. DELL P2425HE CNQFD94";}
        ];
      }
      {
        profile.name = "laptop-vertical";
        profile.outputs = [
          {criteria = "eDP-1";}
          {
            criteria = "Dell Inc. DELL P2425HE FNQFD94";
            position = "0,0";
          }
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {criteria = "Dell Inc. DELL P2425HE CNQFD94";}
          {criteria = "Dell Inc. DELL P2425HE FNQFD94";}
        ];
      }
    ];
  };
}
