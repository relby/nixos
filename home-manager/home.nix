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

  # TODO: Set your username
  home = {
    inherit username sessionVariables;
    homeDirectory = "/home/${username}";

    shellAliases = {
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gd = "git diff";
      gp = "git push";
      gl = "git log --oneline";

      ":q" = "exit";
      ":qa" = "exit";

      cat = "bat";
      diff = "delta";

      d = "docker";
      k = "kubectl";
      kns = "kubens";
    };

    packages = (with pkgs; [
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

      # Nodejs packages
      # TODO: Refactor it
      nodePackages."@nestjs/cli"
      nodePackages."pnpm"
    ]) ++ (with pkgs.gnomeExtensions; [
      user-themes
      dash-to-dock
      disable-workspace-switch-animation-for-gnome-40
    ]);
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
          opacity = 1;
          # Fullscreen, because startup_mode doesn't work on wayland display
          dimensions = {
            columns = 500;
            lines = 500;
          };
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
      enableSyntaxHighlighting = true;
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
    exa = {
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

  wayland.windowManager.hyprland.enable = true;

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
  home.stateVersion = "22.11";
}

