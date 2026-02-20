# lib/mixins.nix
#
# Each mixin is a function: pkgs -> { packages, shellHook, env }
# Consuming code selects mixins by name and mkShell merges them.

{
  # ── Tooling: direnv, Taskfile, 1Password CLI ───────────────────────
  tooling = pkgs: {
    packages = with pkgs; [
      direnv
      go-task
    ];

    shellHook = ''
      if command -v direnv &>/dev/null && [ -z "''${DIRENV_IN_ENVRC:-}" ]; then
        eval "$(direnv hook bash 2>/dev/null || direnv hook zsh 2>/dev/null || true)"
      fi
    '';

    env = { };
  };

  # ── Git: common git tooling ────────────────────────────────────────
  git = pkgs: {
    packages = with pkgs; [
      git
      git-lfs
      gh
      pre-commit
    ];

    shellHook = "";
    env = { };
  };

  # ── Nix tools: formatting, linting, maintenance ───────────────────
  nix-tools = pkgs: {
    packages = with pkgs; [
      nixpkgs-fmt
      nil
      nix-direnv
      nix-tree
    ];

    shellHook = "";
    env = { };
  };

}
