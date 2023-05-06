{ inputs, username, hostname, lib, config, pkgs, ... }: {
  home = {
    inherit username;
  };

  programs = {
    home-manager.enable = true;
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      startup = [
        { command = "alacritty"; }
      ];
    };
  };

  home.stateVersion = "22.11";
}

