{ lib, appimageTools,fetchurl}:

let 
  pname = "MQTT-Explorer";
  version = "0.4.0-beta1";
  name = "mqtt-explorer";
  src = fetchurl {
    url = "https://github.com/thomasnordquist/${pname}/releases/download/0.0.0-${version}/${pname}-${version}.AppImage";
    sha256 = "9l6i2qNRUo8I1ghMqPirD45FYqMFUjrFnDZYOILaKnU=";
  };
  appImageContents=appimageTools.extractType2 { inherit name src;};
  
 in appimageTools.wrapType2 rec {
   inherit name src;
  
  extraInstallCommands = ''
    install -m 444 -D ${appImageContents}/resources/app.asar $out/libexec/app.asar
    install -m 444 -D ${appImageContents}/mqtt-explorer.png $out/share/icons/mqtt-explorer.png
    install -m 444 -D ${appImageContents}/mqtt-explorer.desktop $out/share/applications/mqtt-explorer.desktop
    substituteInPlace $out/share/applications/mqtt-explorer.desktop \
      --replace 'Exec=AppRun' 'Exec=${name}'
  '';

  meta = with lib; {
    description = "A comprehensive and easy-to-use MQTT Client";
    homepage = "https://mqtt-explorer.com/";
    license = # TODO: make licenses.cc-by-nd-40
      { free = false; fullName = "Creative Commons Attribution-No Derivative Works v4.00"; shortName = "cc-by-nd-40"; spdxId = "CC-BY-ND-4.0"; url = "https://spdx.org/licenses/CC-BY-ND-4.0.html"; };
    maintainers = [ maintainers.yorickvp ];
     platforms= ["x86_64-linux"];
  };
}
