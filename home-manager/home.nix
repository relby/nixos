{ inputs, username, hostname, lib, config, pkgs, ... }:
let
  sessionVariables = with pkgs; {
    TERMINAL = "alacritty";
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = google-chrome.meta.mainProgram;
  };
in
{
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  home = {
    inherit username sessionVariables;
    homeDirectory = "/home/${username}";

    shellAliases = {
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gd = "git diff";
      gp = "git push";
      gl = "git log --oneline";
      gco = "git checkout";

      ":q" = "exit";
      ":qa" = "exit";

      cat = "bat";
      diff = "delta";

      d = "docker";
      k = "kubectl";
      kns = "kubens";
    };

    packages = with pkgs; [
      neovim
      nodejs
      discord
      rustup
      google-chrome
      tldr
      gnumake
      ripgrep
      spotify
      qbittorrent
      beekeeper-studio
      just
      poetry
      neovim
      tdesktop
      insomnia
      postman
      jq
      xclip
      feh
      pgcli
      vlc
      yarn
      kubectl
      kubectx
      ngrok
      lazygit
      lazydocker
      wtype
      wezterm

      # Nodejs packages
      # TODO: Refactor it
      nodePackages."@nestjs/cli"
      nodePackages."pnpm"
      swww
    ];
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      delta.enable = true;
      extraConfig = {
        user = {
          name = "Nikita Kudinov";
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
          opacity = 0.95;
          # Fullscreen, because startup_mode doesn't work on wayland display
          startup_mode = "Maximized";
        };
        font =
          let family = "CaskaydiaCove Nerd Font";# "Iosevka Nerd Font";
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
      syntaxHighlighting.enable = true;
      defaultKeymap = "emacs";
      # oh-my-zsh = {
      #   enable = true; # Consider to enable it and configure
      # };
    };
    starship = {
      enable = true;
      settings = {
        format = lib.concatStrings [
          "$all"
          "$fill"
          "$time"
          "$line_break"
          "$cmd_duration"
          "$character"
        ];
        add_newline = false;
        time = {
          disabled = false;
          format = "[$time]($style) ";
          time_format = "%v %R";
        };
        cmd_duration.format = "[$duration]($style) ";
        directory.truncation_length = 8;
        # Symbols
        git_branch.symbol = " ";
        git_status = {
          ahead = "";
          behind = "";
        };

        c.symbol = " ";
        docker_context.symbol = " ";
        golang.symbol = " ";
        memory_usage.symbol = " ";
        python.symbol = " ";
        rust.symbol = " ";
        nix_shell.symbol = " ";

        fill.symbol = " ";
        # Disabled
        package.disabled = true;
      };
    };
    eza = {
      enable = true;
      enableAliases = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
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
    wofi.enable = true;
    waybar.enable = true;

    # TODO: Put that in a separate file
    # neovim = {
    #   enable = true;
    #   defaultEditor = true;
    #   plugins = with pkgs.vimPlugins; [
    #     # Colorschemas
    #     tokyonight-nvim catppuccin-nvim
    #     # Development
    #     neo-tree-nvim
    #     (nvim-treesitter.withPlugins
    #       (_: pkgs.tree-sitter.allGrammars)
    #     )
    #     nvim-treesitter-context
    #     telescope-nvim
    #     telescope-ui-select-nvim
    #     telescope-file-browser-nvim
    #     zen-mode-nvim
    #     comment-nvim
    #     toggleterm-nvim
    #     # LSP
    #     nvim-lspconfig
    #     rust-tools-nvim
    #     # Completion
    #     nvim-cmp
    #     cmp-buffer
    #     cmp-path
    #     cmp-nvim-lua
    #     cmp-nvim-lsp
    #     cmp_luasnip
    #     lspkind-nvim
    #     cmp-tabnine
    #     luasnip
    #     # UI
    #     lualine-nvim
    #     nvim-web-devicons
    #     gitsigns-nvim
    #     fidget-nvim
    #     undotree
    #     # Additional stuff
    #     plenary-nvim
    #     nui-nvim
    #   ];

    #   extraPackages = with pkgs; [
    #     tree-sitter
    #     nodejs
    #     # Telescope
    #     ripgrep
    #     fd
    #     # Language servers
    #     rnix-lsp
    #     pyright
    #     nodePackages.typescript-language-server
    #     rust-analyzer
    #   ];
    # };
  };

  # xdg.configFile.nvim = {
  #  source = ../dotfiles/nvim;
  #  recursive = true;
  # };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
    systemdIntegration = true;
    extraConfig = ''
      monitor = eDP-1, 1920x1080, 0x0, 1

      $mod = SUPER
      bind = $mod, Return, exec, alacritty
      bind = $mod, B, exec, google-chrome-stable
      bind = $mod, Q, killactive

      bind = $mod, F, fullscreen

      bind = ALT, H, movefocus, l
      bind = ALT, J, movefocus, d
      bind = ALT, K, movefocus, u
      bind = ALT, L, movefocus, d

      bind = $mod, H, workspace, -1
      bind = $mod, L, workspace, +1
      bind = $mod SHIFT, H, movetoworkspace, -1
      bind = $mod SHIFT, L, movetoworkspace, +1

      bind = $mod, F, fullscreen, 0
      bind = $mod, S, togglefloating

      # switch workspace
      bind = $mod, 1, workspace, 1
      bind = $mod, 2, workspace, 2
      bind = $mod, 3, workspace, 3
      bind = $mod, 4, workspace, 4
      bind = $mod, 5, workspace, 5
      bind = $mod, 6, workspace, 6
      bind = $mod, 7, workspace, 7
      bind = $mod, 8, workspace, 8
      bind = $mod, 9, workspace, 9
      bind = $mod, 0, workspace, 10

      bind = $mod SHIFT, 1, movetoworkspace, 1
      bind = $mod SHIFT, 2, movetoworkspace, 2
      bind = $mod SHIFT, 3, movetoworkspace, 3
      bind = $mod SHIFT, 4, movetoworkspace, 4
      bind = $mod SHIFT, 5, movetoworkspace, 5
      bind = $mod SHIFT, 6, movetoworkspace, 6
      bind = $mod SHIFT, 7, movetoworkspace, 7
      bind = $mod SHIFT, 8, movetoworkspace, 8
      bind = $mod SHIFT, 9, movetoworkspace, 9
      bind = $mod SHIFT, 0, movetoworkspace, 10

      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow

      bindle = , XF86MonBrightnessUp,   exec, light -A 10
      bindle = , XF86MonBrightnessDown, exec, light -U 10
      bindle = , XF86AudioRaiseVolume,  exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
      bindle = , XF86AudioLowerVolume,  exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
      bind   = , XF86AudioMute,         exec, pactl set-sink-mute @DEFAULT_SINK@ toggle
      bind   = , XF86AudioMicMute,      exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle

      bind = $mod, P, exec, wofi --show drun

      bind = $mod, I, exec, swww img --transition-type any --transition-fps 60 ~/wallpapers/dj-dark.png
      bind = $mod, O, exec, swww img --transition-type any --transition-fps 60 ~/wallpapers/dj-light.png

      bind = ALT CTRL, H, exec, wtype -m alt -m ctrl -P Left
      bind = ALT CTRL, J, exec, wtype -m alt -m ctrl -P Down
      bind = ALT CTRL, K, exec, wtype -m alt -m ctrl -P Up
      bind = ALT CTRL, L, exec, wtype -m alt -m ctrl -P Right

      general {
          gaps_in = 3
          gaps_out = 2
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
      }

      decoration {
          rounding = 5
          blur {
              enabled = yes
              size = 3
              passes = 1
              new_optimizations = on
          }
          drop_shadow = no
      }

      animations {
        enabled = true
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05
        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 1, default
      }

      input {
        kb_layout = us, ru
        kb_options = ctrl:nocaps, grp:win_space_toggle

        touchpad {
          natural_scroll = true
        }

        follow_mouse = 1
      }

      gestures {
        workspace_swipe = true
      }

      # autostart
      exec-once = swww init
      exec-once = waybar &
    '';
  };

  services = {
    mako = {
      enable = true;
    };
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
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "instantworkspaceswitcher@amalantony.net"
      ];
    };
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
      minimize = [ "<Super>y" ]; # TODO: Remove it completely
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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

