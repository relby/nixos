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
      # postman
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
      pavucontrol

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
          # eamodio.gitlens
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
    waybar = {
      enable = true;
      settings = {
        mainBar = {
        "position" = "top";
        "layer" = "top";

        "modules-left" = [
          "custom/launcher"
          "temperature"
          "wlr/workspaces"
        ];
        "modules-center" = [
          "custom/playerctl"
        ];
        "modules-right" = [
          "mpd"
          "pulseaudio"
          "backlight"
          "memory"
          "cpu"
          "network"
          "clock"
          "custom/powermenu"
          "tray"
        ];
        "wlr/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
          "format-icons" = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "7" = "";
            "8" = "";
            "9" = "";
            "10" = "〇";
            "focused" = "";
            "default" = "";
          };
        };

        "clock" = {
          "interval" = 60;
          "align" = 0;
          "rotate" = 0;
          "tooltip-format" = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
          "format" = " {:%H:%M}";
          "format-alt" = " {:%a %b %d; %G}";
        };
        "cpu" = {
          "format" = "�� {usage}%";
          "interval" = 1;
        };
        "custom/launcher" = {
          "format" = " ";
          "on-click" = "$HOME/.config/hypr/scripts/menu";
          "on-click-middle" = "exec default_wall";
          "on-click-right" = "exec wallpaper_random";
          "tooltip" = false;
        };
        "custom/powermenu" = {
          "format" = "";
          "on-click" = "$HOME/.config/hypr/scripts/wlogout";
          "tooltip" = false;
        };
        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
          "tooltip" = false;
        };
        "memory" = {
          "format" = "�� {percentage}%";
          "interval" = 1;
          "states" = {
            "warning" = 85;
          };
        };
        "mpd" = {
            "interval" = 2;
            "unknown-tag" = "N/A";
            "format" = "{stateIcon} {artist} - {title}";
            "format-disconnected" = " Disconnected";
            "format-paused" = "{stateIcon} {artist} - {title}";
            "format-stopped" = "Stopped ";
            "state-icons" = {
                "paused" = "";
                "playing" = "";
            };
            "tooltip-format" = "MPD (connected)";
            "tooltip-format-disconnected" = "MPD (disconnected)";
            "on-click" = "mpc toggle";
            "on-click-middle" = "mpc prev";
            "on-click-right" = "mpc next";
            "on-update" = "";
            "on-scroll-up" = "mpc seek +00:00:01";
            "on-scroll-down" = "mpc seek -00:00:01";
            "smooth-scrolling-threshold" = 1;
        };
        "custom/playerctl" = {
           "format" = "{icon}  <span>{}</span>";
           "return-type" = "json";
           "max-length" = 55;
           "exec" = "playerctl -a metadata #format '{\"text\": \"  {{markup_escape(title)}}\"; \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
           "on-click-middle" = "playerctl previous";
           "on-click" = "playerctl play-pause";
           "on-click-right" = "playerctl next";
           "format-icons" = {
             "Paused" = "<span foreground='#6dd9d9'></span>";
             "Playing" = "<span foreground='#82db97'></span>";
           };
        };
        "network" = {
            "interval" = 5;
            #"interface" = "wlan*"; // (Optional) To force the use of this interface, set it for netspeed to work
            "format-wifi" = " {essid}";
            "format-ethernet" = " {ipaddr}/{cidr}";
            "format-linked" = " {ifname} (No IP)";
            "format-disconnected" = "睊 Disconnected";
            "format-disabled" = "睊 Disabled";
            "format-alt" = " {bandwidthUpBits} |  {bandwidthDownBits}";
            "tooltip-format" = " {ifname} via {gwaddr}";
        };
        "pulseaudio" = {
            #"format" = "{volume}% {icon} {format_source}";
            "format" = "{icon} {volume}%";
            "format-muted" = " Mute";
            "format-bluetooth" = " {volume}% {format_source}";
            "format-bluetooth-muted" = " Mute";
            "format-source" = " {volume}%";
            "format-source-muted" = "";
            "format-icons" = {
                "headphone" = "";
                "hands-free" = "";
                "headset" = "";
                "phone" = "";
                "portable" = "";
                "car" = "";
                "default" = [
                    ""
                    ""
                    ""
                ];
            };
            "scroll-step" = 5.0;
            # Commands to execute on events
            "on-click" = "amixer set Master toggle";
            "on-click-right" = "pavucontrol";
            "smooth-scrolling-threshold" = 1;
        };
        "temperature" = {
          "format" = " {temperatureC}°C";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 15;
          "spacing" = 5;
        };
      };
      };
      style = ''
* {
  font-family: "JetBrainsMono Nerd Font";
  font-size: 12pt;
  font-weight: bold;
  border-radius: 8px;
  transition-property: background-color;
  transition-duration: 0.5s;
}
@keyframes blink_red {
  to {
    background-color: rgb(242, 143, 173);
    color: rgb(26, 24, 38);
  }
}
.warning,
.critical,
.urgent {
  animation-name: blink_red;
  animation-duration: 1s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}
window#waybar {
  background-color: transparent;
}
window > box {
  margin-left: 5px;
  margin-right: 5px;
  margin-top: 5px;
  background-color: #1e1e2a;
  padding: 3px;
  padding-left: 8px;
  border: 2px none #33ccff;
}
#workspaces {
  padding-left: 0px;
  padding-right: 4px;
}
#workspaces button {
  padding-top: 5px;
  padding-bottom: 5px;
  padding-left: 6px;
  padding-right: 6px;
}
#workspaces button.active {
  background-color: rgb(181, 232, 224);
  color: rgb(26, 24, 38);
}
#workspaces button.urgent {
  color: rgb(26, 24, 38);
}
#workspaces button:hover {
  background-color: rgb(248, 189, 150);
  color: rgb(26, 24, 38);
}
tooltip {
  background: rgb(48, 45, 65);
}
tooltip label {
  color: rgb(217, 224, 238);
}
#custom-launcher {
  font-size: 20px;
  padding-left: 8px;
  padding-right: 6px;
  color: #7ebae4;
}
#mode,
#clock,
#memory,
#temperature,
#cpu,
#mpd,
#custom-wall,
#temperature,
#backlight,
#pulseaudio,
#network,
#battery,
#custom-powermenu {
  padding-left: 10px;
  padding-right: 10px;
}

/* #mode { */
/* 	margin-left: 10px; */
/* 	background-color: rgb(248, 189, 150); */
/*     color: rgb(26, 24, 38); */
/* } */
#memory {
  color: rgb(181, 232, 224);
}
#cpu {
  color: rgb(245, 194, 231);
}
#clock {
  color: rgb(217, 224, 238);
}
/* #idle_inhibitor {
                 color: rgb(221, 182, 242);
               }*/
#custom-wall {
  color: #33ccff;
}
#temperature {
  color: rgb(150, 205, 251);
}
#backlight {
  color: rgb(248, 189, 150);
}
#pulseaudio {
  color: rgb(245, 224, 220);
}
#network {
  color: #abe9b3;
}
#network.disconnected {
  color: rgb(255, 255, 255);
}
#custom-powermenu {
  color: rgb(242, 143, 173);
  padding-right: 8px;
}
#tray {
  padding-right: 8px;
  padding-left: 10px;
}
#mpd.paused {
  color: #414868;
  font-style: italic;
}
#mpd.stopped {
  background: transparent;
}
#mpd {
  color: #c0caf5;
}
      '';
    };

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
    enableNvidiaPatches = true;
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
      bindle = , XF86AudioRaiseVolume,  exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%
      bindle = , XF86AudioLowerVolume,  exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%
      bind   = , XF86AudioMute,         exec, ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle
      bind   = , XF86AudioMicMute,      exec, ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle

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

  systemd.user.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_EGL_NO_MODIFIRES = "1";
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

