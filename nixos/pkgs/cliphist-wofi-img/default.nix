{ lib,
  fetchFromGitHub,
  buildGoModule
}:

buildGoModule rec {
  pname = "cliphist-wofi-img";
  version = "latest";

  src = fetchFromGitHub {
    owner = "pdf";
    repo = "cliphist-wofi-img";
    rev = "master";
    hash = "sha256-2N7LPetEMRXVWXQ4ls3deEZmT/cxztBIGwAz0IUbnDQ=";
  };

  postInstall = ''
    mv $out/bin/cliphist-wofi-img $out/bin/cliphist-wofi-img-go
  '';

  vendorHash = null;

  meta = with lib; {
    description = "A clipboard history manager for wofi with image support";
    homepage = "https://github.com/pdf/cliphist-wofi-img";
    license = licenses.mit;
    mainteners = with maintainers; [ pdf ];
  };
}
