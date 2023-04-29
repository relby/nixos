{ inputs, username, hostname, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";

  security.sudo.wheelNeedsPassword = false;

  services.xserver = {
    enable = true;
    layout = "us";
  };

  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      zsh
      vim
      git
      zip
      unzip
      wget
      neofetch
    ];
  };

  users.defaultUserShell = pkgs.zsh;
  users.users = {
    ${username} = {
      isNormalUser = true;
      initialPassword = "password";
      extraGroups = [ "wheel" "networkmanager" "docker" ];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
