{
   system ? builtins.currentSystem
 , pkgs ? import <nixpkgs> { inherit system; }
 , pkgs_latest ? import <nixpkgs_latest> { inherit system; }
}:
let
  python = pkgs.python39;
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    python
    pkgs_latest.bazel_5
    pkgs_latest.bazel-buildtools
  ];
  shellHook = ''
    PYTHONPATH=${python}/${python.sitePackages}
  '';
}