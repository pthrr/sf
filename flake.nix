{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            coq_8_14
            coqPackages_8_14.VST

            rocq-core
            coqPackages.QuickChick
            rocqPackages.stdlib
            coqPackages.ExtLib
            coqPackages.mathcomp-boot
            rocqPackages.hierarchy-builder
            coqPackages.coq-elpi
            coqPackages.simple-io

            (texlive.combine {
              inherit (texlive) scheme-basic
                ucs
                wasysym
                tipa
                preprint
                xcolor
                hyperref
                oberdiek
                enumitem
                metafont
                ;
            })

            gnumake
          ];

          shellHook = ''
            export ROCQPATH="${pkgs.coqPackages.QuickChick}/lib/coq/9.0/user-contrib/:${pkgs.rocqPackages.stdlib}/lib/coq/9.0/user-contrib/:${pkgs.coqPackages.ExtLib}/lib/coq/9.0/user-contrib/:${pkgs.coqPackages.mathcomp-boot}/lib/coq/9.0/user-contrib/:${pkgs.rocqPackages.hierarchy-builder}/lib/coq/9.0/user-contrib/:${pkgs.coqPackages.coq-elpi}/lib/coq/9.0/user-contrib/:${pkgs.coqPackages.simple-io}/lib/coq/9.0/user-contrib/"
            unset COQPATH
            echo "Coq version: $(coqc --version | head -n 1)"
            echo "Rocq version: $(rocq --version | head -n 1)"
            echo "LaTeX version: $(pdflatex --version | head -n 1)"
            echo "ROCQPATH: $ROCQPATH"
          '';
        };
      }
    );
}
