{
  description = "Kass's nix flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    let
      # Import shell builder and mixins
      mixins = import ./nix/mixins.nix;
      mkShell = import ./nix/mkShell.nix;
    in
    {
      # ── Library functions (consumed as flake input) ────────────────────
      lib = {
        inherit mkShell mixins;
      };

    }

    # ── Dev shells for this repo itself (for testing) ─────────────────
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = mkShell pkgs {
          mixins = [
            "tooling"
            "git"
            "cloud"
          ];
        };
      }
    );
}
