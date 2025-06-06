{
  stdenv,
  lib,
  desktop-file-utils,
  fetchurl,
  glib,
  gettext,
  gtk4,
  libadwaita,
  meson,
  ninja,
  pkg-config,
  wrapGAppsHook4,
  gnome,
}:

stdenv.mkDerivation rec {
  pname = "d-spy";
  version = "47.0";

  outputs = [
    "out"
    "lib"
    "dev"
  ];

  src = fetchurl {
    url = "mirror://gnome/sources/d-spy/${lib.versions.major version}/d-spy-${version}.tar.xz";
    hash = "sha256-7/sw1DKtXkPmxEm9+OMX2il+VuAnQW5z4ulsTPGPaeg=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    desktop-file-utils
    wrapGAppsHook4
    gettext
    glib
  ];

  buildInputs = [
    glib
    gtk4
    libadwaita
  ];

  passthru = {
    updateScript = gnome.updateScript {
      packageName = "d-spy";
    };
  };

  meta = with lib; {
    description = "D-Bus exploration tool";
    mainProgram = "d-spy";
    homepage = "https://gitlab.gnome.org/GNOME/d-spy";
    license = with licenses; [
      lgpl3Plus # library
      gpl3Plus # app
    ];
    teams = [ teams.gnome ];
    platforms = platforms.linux;
  };
}
