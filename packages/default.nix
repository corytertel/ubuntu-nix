{ lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
    (import ./crystal-nova.nix { inherit lib pkgs; })
    (import ./discord.nix { inherit pkgs; })
    (import ./nf-oxygen.nix { inherit lib pkgs; })
    (import ./nf-victormono.nix { inherit lib pkgs; })
  ];
}
