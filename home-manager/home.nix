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
      tldr
      just
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
    zoxide.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}

