{ pkgs ? import <nixpkgs> {} }:
let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    bazel_4
    bazel-buildtools
    git
    go_1_17
  ];
  #shellHook = ''
  #  echo "startup --output_base $(readlink -f ./bazel-output)" > "$(pwd)"/.shell-bazelrc
  #'';
}