# nix/mixins.nix
#
# Each mixin is a function: pkgs -> { packages, shellHook, env }
# Consuming code selects mixins by name and mkShell merges them.

{
  tooling = pkgs: {
    packages = with pkgs; [
      direnv
      nix-direnv
      go-task
      treefmt
      shfmt
      nixfmt-rfc-style
      nodePackages.prettier
    ];

    shellHook = ''
      if command -v direnv &>/dev/null && [ -z "''${DIRENV_IN_ENVRC:-}" ]; then
        eval "$(direnv hook bash 2>/dev/null || direnv hook zsh 2>/dev/null || true)"
      fi
    '';

    env = { };
  };

  git = pkgs: {
    packages = with pkgs; [
      git
      git-lfs
      glab
      gh
      prek
      lazygit
    ];

    shellHook = "";
    env = { };
  };

  cloud = pkgs: {
    packages = with pkgs; [
      awscli2
      #oci-cli
    ];

    shellHook = "";
    env = { };
  };

}
