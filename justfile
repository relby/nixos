switch:
    sudo nixos-rebuild switch --flake .

clean:
    nix store optimise --verbose
    nix store gc --verbose
