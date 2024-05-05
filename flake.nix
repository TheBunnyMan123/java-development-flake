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
      devShell = pkgs.mkShell {
        packages = with pkgs; [
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
          exec code .
        '';
      };
    }
  );
}
