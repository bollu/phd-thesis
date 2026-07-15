{ pkgs ? import <nixpkgs> {} }:


pkgs.mkShell {
  packages =
    let
      my-python-packages = ps: with ps; [ matplotlib pandas ];
    in
    [
      (pkgs.python3.withPackages my-python-packages)
    ];
}
