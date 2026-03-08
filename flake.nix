{
  description = "Opinionated GNOME configuration";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      extensions = with pkgs.gnomeExtensions; [ argos window-calls ];

      extensionBundle = pkgs.symlinkJoin {
        name = "gnome-extensions-bundle";
        paths = extensions;
      };

      installExtensionsScript = pkgs.writeShellApplication {
        name = "install-extensions";
        runtimeInputs = with pkgs; [ coreutils findutils ];
        text = ''
          echo "Building extension bundle..."
          BUNDLE_PATH="${extensionBundle}"
          EXT_DIR="$HOME/.local/share/gnome-shell/extensions"
          mkdir -p "$EXT_DIR"

          find "$EXT_DIR" -type l -delete

          mkdir -p "$BUNDLE_PATH/share/gnome-shell/extensions"
          ln -sfn "$BUNDLE_PATH"/share/gnome-shell/extensions/* "$EXT_DIR/"
          echo "Done. Sign in again to activate the extensions."
        '';
      };

      focusRecentWindow = pkgs.stdenv.mkDerivation {
        name = "gnome-focus-recent-window";
        src = ./bin/gnome-focus-recent-window;
        installPhase = ''
          mkdir -p $out/bin

          cp -a bin/* $out/bin/
        '';
      };

      config = pkgs.stdenv.mkDerivation {
        name = "gnome-config";
        src = ./.;
        nativeBuildInputs = [ pkgs.makeWrapper ];
        installPhase = ''
          mkdir -p $out/bin $out/share/gnome-config/dconf

          cp -a bin/* $out/bin/
          cp -a dconf/* $out/share/gnome-config/dconf

          wrapProgram $out/bin/gnome-config \
            --set GNOME_CONFIG_PATH $out/share/gnome-config/dconf
        '';
      };

      runAll = pkgs.writeShellApplication {
        name = "run-all";
        text = ''
          ${installExtensionsScript}/bin/install-extensions
          ${config}/bin/gnome-config apply "$@"
        '';
      };

    in {
      packages.${system} = {
        default = config;
        inherit extensionBundle focusRecentWindow config;
      };

      apps.${system} = {
        default = {
          type = "app";
          program = "${runAll}/bin/run-all";
        };
      };
    };
}

