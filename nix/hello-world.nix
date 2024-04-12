{ stdenv, cmake, ninja, qrcodegen, imgui }:
#stdenv.mkDerivation {
stdenv.mkDerivation ( builtins.trace ">> ${qrcodegen}" {
  pname = "hello-world";
  version = "0.1.0";

  nativeBuildInputs = [ cmake ninja ];
  buildInputs = [ qrcodegen imgui ];

  src = ../.;

  cmakeFlags = [
    "-DCMAKE_CXX_FLAGS=-g3"
    "-DQRCODEGEN_DIR:STRING=${qrcodegen}"
    "-DIMGUI_DIR=${imgui}"
  ];
  ninjaFlags = [ "-v" ];
})
