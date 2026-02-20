# Composes language packs and mixins into a single pkgs.mkShell.

pkgs:
{ languages ? []
, mixins ? []
, extraPackages ? []
, shellHook ? ""
}:

let
  allMixins = import ./mixins.nix;
  allLanguages = import ./languages.nix;

  # Resolve selected mixins
  allModules = map (name:
    if builtins.hasAttr name allMixins
    then allMixins.${name} pkgs
    else throw "Unknown mixin: ${name}. Available: ${builtins.concatStringsSep ", " (builtins.attrNames allMixins)}"
  ) mixins;


  mergedPackages = builtins.concatLists (map (m: m.packages or []) allModules);
  mergedShellHook = builtins.concatStringsSep "\n" (
    (builtins.filter (h: h != "") (map (m: m.shellHook or "") allModules))
    ++ [ shellHook ]
  );
  mergedEnv = builtins.foldl' (acc: m: acc // (m.env or {})) {} allModules;

in
pkgs.mkShell (mergedEnv // {
  packages = mergedPackages ++ extraPackages;
  shellHook = mergedShellHook;
})
