{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = import nixpkgs { inherit system; };
        buildToolsDeps = (with pkgs; [
          fish
          cmake
          ninja
          pkg-config
        ]);

        qrcodegen = pkgs.qrcodegen.overrideDerivation (oldAttrs: {
          sourceRoot = "${oldAttrs.src.name}/cpp";
          checkPhase = "";
          installPhase = ''
            runHook preInstall
            install -Dt $out/include/qrcodegen/ qrcodegen.hpp
            install -Dt $out/include/qrcodegen/ qrcodegen.cpp
            runHook postInstall
          '';
        });
        #deps = [ pkgs.qrcodegen ];

      in {
        inherit pkgs;
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = buildToolsDeps;
          buildInputs = [
            #qrcodegen
            pkgs.imgui
          ];
          shellHook =
            ''
              fish && exit
            '';
        };

        packages.default = pkgs.callPackage ./nix/hello-world.nix {
          #qrcodegen = pkgs.qrcodegen;
          #imgui = pkgs.imgui;
          inherit qrcodegen;
        };
      }
    );

    #packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    #packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
}
