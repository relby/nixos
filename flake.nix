{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nixpkgs-wayland, ... }:
    let
      username = "relby";
      hostname = "nixos";

      system = "x86_64-linux";
    in
    {
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
