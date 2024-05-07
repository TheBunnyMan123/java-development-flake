{
  description = "A dev environment for java";

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
      packages.code = (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
        pkgs.vscode-extensions.ms-dotnettools.csdevkit
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
