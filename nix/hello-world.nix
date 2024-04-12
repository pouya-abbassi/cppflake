{ stdenv, cmake, ninja, qrcodegen, imgui }:
stdenv.mkDerivation {
  pname = "hello-world";
  version = "0.1.0";

  nativeBuildInputs = [ cmake ninja ];
  buildInputs = [ qrcodegen imgui ];

  src = ../.;

  cmakeFlags = [
    #"CXXFLAGS=-g3"
    "-DQRCODEGEN_DIR:STRING=${qrcodegen}"
    "-DIMGUI_DIR=${imgui}"
  ];
}
