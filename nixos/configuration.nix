# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, username, hostname, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-acpi_call
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd

    inputs.hyprland.nixosModules.default

    ./hardware-configuration.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  networking = {
    inherit hostname;
    networkmanager.enable = true;
  };

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";

  security.sudo.wheelNeedsPassword = false;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      gcc
      git
      vim
      zip
      unzip
      wget
      curl
      neofetch
      xdg-utils
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  programs = {
    dconf.enable = true;
    zsh.enable = true;
    light.enable = true;
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" "CascadiaCode" ]; })
  ];

  users = {
    mutableUsers = false;
    users = {
      ${username} = {
        isNormalUser = true;
        initialPassword = "password";
        extraGroups = [ "wheel" "docker" "audio" "video" ];
        home = "/home/${username}";
      };
    };
    defaultUserShell = pkgs.zsh;
    shell = pkgs.zsh;
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
    xserver = {
      enable = true;
      layout = "us, ru";
      xkbOptions = "ctrl:nocaps, grp:win_space_toggle";
      libinput = {
        enable = true;
        touchpad = {
          disableWhileTyping = true;
          naturalScrolling = true;
        };
      };
      desktopManager = {
        xterm.enable = true;
      };
    };
    tailscale.enable = true;
    dbus.enable = true;
  };

  virtualisation = {
    docker.enable = true;
  };

  hardware = {
    opengl.enable = true;

    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
  };

  sound.enable = true;

  console.useXkbConfig = true;

  system.stateVersion = "23.05";
}
