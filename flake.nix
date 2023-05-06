{
  description = "NixOS configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Can also be nixos-22.11

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nixos-hardware, ... }:
    let
      username = "relby";
      hostname = "nixos";

      system = "x86_64-linux";
    in
    {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        ${hostname} = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs username hostname; };
          modules = [
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs username hostname; };
              home-manager.users.${username} = {
                imports = [ ./home-manager/home.nix ];
              };
            }
          ];
        };
      };
    };
}
