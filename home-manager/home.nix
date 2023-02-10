{ inputs, username, hostname, lib, config, pkgs, ... }:
let
  sessionVariables = with pkgs; {
    # TODO: Figure out how to do it more nicely
    EDITOR = neovim.meta.mainProgram;
    VISUAL = neovim.meta.mainProgram;
    # TODO: Since alacritty doesn't have mainProgram field
    # Figure out how to get around it
    TERMINAL = "alacritty"; 
    BROWSER = google-chrome.meta.mainProgram;
  };
in
{
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

  home.sessionVariables = sessionVariables;

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    neovim
    nodejs
    discord
    rustup
    google-chrome
    docker
    tldr
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
          let family = "Iosevka Nerd Font";
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
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      defaultKeymap = "emacs";
      # oh-my-zsh = {
      #   enable = true; # Consider to enable it and configure
      # };
      # shellAliases = {
      #   ".." = "cd ..";
      # };
    };
    starship = {
      enable = true;
      settings = {
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$localip"
          "$directory"
          "$git_branch"
          "$git_commit"
          "$git_state"
          "$git_metrics"
          "$git_status"
          "$docker_context"
          "$c"
          "$container"
          "$deno"
          "$golang"
          "$nodejs"
          "$python"
          "$rust"
          "$conda"
          "$custom"
          "$fill"
          "$time"
          "$line_break"
          "$cmd_duration"
          "$status"
          "$character"
        ];
        add_newline = false;
        time = {
          disabled = false;
          format = "[$time]($style) ";
          time_format = "%v %R";
        };
        cmd_duration.format = "[$duration]($style) ";
        # Symbols
        c.symbol = " ";
        git_branch.symbol = " ";
        docker_context.symbol = " ";
        golang.symbol = " ";
        memory_usage.symbol = " ";
        python.symbol = " ";
        rust.symbol = " ";
        fill.symbol = " ";
      };
    };
    exa = {
      enable = true;
      enableAliases = true;
    };
    vscode = {
      enable = true;
      userSettings = {
        # TODO: Set this as a global variable
        "terminal.integrated.fontFamily" = "Iosevka Nerd Font";
        "terminal.integrated.fontSize" = 18;
        "terminal.integrated.allowChords" = false;
        "extensions.experimental.affinity" = {
          "asvetliakov.vscode-neovim" = 1;
        };
      };
      extensions = with pkgs.vscode-extensions;
        [
          # General
          asvetliakov.vscode-neovim
          eamodio.gitlens
          usernamehw.errorlens
          # Rust
          rust-lang.rust-analyzer
          # Python
          ms-python.python
          # TODO: Add extensions for JS, TS
          # Themes
        ];
    };
    zoxide.enable = true;
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
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
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "Alacritty.desktop"
        "code.desktop"
        "google-chrome.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Settings.desktop"
      ];
    };
    # Custom shortcuts. TODO: Do it more nicely
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Open the browser";
      binding = "<Super>b";
      command = sessionVariables.BROWSER;
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Open the terminal";
      binding = "<Super>Return";
      command = sessionVariables.TERMINAL;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}

