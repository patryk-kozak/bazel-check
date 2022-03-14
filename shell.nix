{ pkgs ? import <nixpkgs> {} }:
let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    unstable.bazel_5
    pkgs.git
    pkgs.go_1_17
  ];
  shellHook = ''
    export TERM=xterm
    echo "startup --output_base $(readlink -f ./bazel-output)" > "$(pwd)"/.shell-bazelrc
    echo "startup --output_user_root $(readlink -f ./bazel-root)" >> "$(pwd)"/.shell-bazelrc
    echo "common --repository_cache $(readlink -f ./bazel-cache)" >> "$(pwd)"/.shell-bazelrc
  '';
}