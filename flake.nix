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

        qrcodegen = pkgs: pkgs.qrcodegen;
        imgui = pkgs: pkgs.imgui;
        #deps = [ pkgs.qrcodegen ];

      in {
        inherit pkgs;
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = buildToolsDeps;
          buildInputs = [
            (qrcodegen pkgs)
            (imgui pkgs)
          ];
          shellHook =
            ''
              fish && exit
            '';
        };

        packages.default = pkgs.callPackage ./nix/hello-world.nix {
          qrcodegen = qrcodegen imgui pkgs;
        };
      }
    );

    #packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    #packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
}
