{
  description = "A dev environment for Figura";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        system = "${system}";
      };
    in {
      devShell = {
        shellHook = ''
          echo "Please specify which mode you want (check readme)"
          exit
        '';
      }

      devShells = {
        ide8 = pkgs.mkShell {
          packages = with pkgs; [
            bashInteractive
            jdk8
            (vscode-with-extensions.override {
              vscode = vscodium;
              vscodeExtensions = with vscode-extensions; [
                redhat.java
                vscjava.vscode-maven
                vscjava.vscode-java-test
                vscjava.vscode-java-dependency
                vscjava.vscode-java-debug
                vscjava.vscode-gradle
              ];
            })
          ];

          shellHook = ''
            exec codium .
          '';
        };

        ide17 = pkgs.mkShell {
          packages = with pkgs; [
            bashInteractive
            jdk17
            (vscode-with-extensions.override {
              vscode = vscodium;
              vscodeExtensions = with vscode-extensions; [
                redhat.java
                vscjava.vscode-maven
                vscjava.vscode-java-test
                vscjava.vscode-java-dependency
                vscjava.vscode-java-debug
                vscjava.vscode-gradle
              ];
            })
          ];

          shellHook = ''
            exec codium .
          '';
        };

        ide21 = pkgs.mkShell {
          packages = with pkgs; [
            bashInteractive
            jdk21
            (vscode-with-extensions.override {
              vscode = vscodium;
              vscodeExtensions = with vscode-extensions; [
                redhat.java
                vscjava.vscode-maven
                vscjava.vscode-java-test
                vscjava.vscode-java-dependency
                vscjava.vscode-java-debug
                vscjava.vscode-gradle
              ];
            })
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
