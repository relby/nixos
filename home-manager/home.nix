{ inputs, username, hostname, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # TODO: Set your username
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };

  home.sessionVariables.EDITOR = "nvim";

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    neovim
    discord
    rustup
    google-chrome
  ];

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      delta.enable = true;
      extraConfig = {
        user = {
          name = username;
          email = "kudinov.nikita@gmail.com";
        };
        init = {
          defaultBranch = "main";
        };
      };
    };
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
    bat = {
      enable = true;
      config = {
        theme = "Sublime Snazzy";
      };
    };
    alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 1;
          # Fullscreen, because startup_mode doesn't work on wayland display
          dimensions = {
            columns = 500;
            lines = 500;
          };
        };
        font =
          let family = "Hack Nerd Font Mono";
          in
          {
            normal = { inherit family; style = "Regular"; };
            bold = { inherit family; style = "Bold"; };
            italic = { inherit family; style = "Italic"; };
            bold_italic = { inherit family; style = "Bold Italic"; };
            size = 18;
          };
      };
    };
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      Settings = "gtk-application-prefer-dark-theme=1";
    };
    gtk4.extraConfig = {
      Settings = "gtk-application-prefer-dark-theme=1";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = [
        "caps:ctrl_modifier"
      ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-left = [ "<Super>h" ];
      switch-to-workspace-right = [ "<Super>l" ];
      move-to-workspace-left = [ "<Shift><Super>h" ];
      move-to-workspace-right = [ "<Shift><Super>l" ];
      show-desktop = [ "<Super>d" ];
      toggle-fullscreen = [ "<Shift><Super>f" ];
      toggle-maximized = [ "<Super>f" ];
      close = [ "<Super>q" ];
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
