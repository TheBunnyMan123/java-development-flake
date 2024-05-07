{
  description = "A dev environment for java";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { self, nixpkgs, flake-utils, nix-vscode-extensions }: 
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        system = "${system}";
      };

      packages.code = (pkgs.vscode-with-extensions.override {
        vscode = pkgs.vscodium;
        vscodeExtensions = with nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
          mhutchie.git-graph
          aaron-bond.better-comments
          pkgs.vscode-extensions.redhat.java
          pkgs.vscode-extensions.vscjava.vscode-maven
          pkgs.vscode-extensions.vscjava.vscode-java-test
          pkgs.vscode-extensions.vscjava.vscode-java-dependency
          pkgs.vscode-extensions.vscjava.vscode-java-debug
          pkgs.vscode-extensions.vscjava.vscode-gradle
        ];
      });
    in {
      devShell = pkgs.mkShell {
        shellHook = ''
          echo "Please specify which mode you want (check readme)"
          exit
        '';
      };

      devShells = {
        ide8 = pkgs.mkShell {
          packages = with pkgs; [
            bashInteractive
            jdk8
            packages.code
          ];

          shellHook = ''
            exec codium --verbose .
          '';
        };

        ide17 = pkgs.mkShell {
          packages = with pkgs; [
            bashInteractive
            jdk17
            packages.code
          ];

          shellHook = ''
            exec codium .
          '';
        };

        ide21 = pkgs.mkShell {
          packages = with pkgs; [
            bashInteractive
            jdk21
            packages.code
          ];

          shellHook = ''
            exec codium .
          '';
        };

        noIde8 = pkgs.mkShell {
          packages = with pkgs; [
            jdk8
          ];
        };

        noIde17 = pkgs.mkShell {
          packages = with pkgs; [
            jdk17
          ];
        };

        noIde21 = pkgs.mkShell {
          packages = with pkgs; [
            jdk21
          ];
        };
      };
    }
  );
}
