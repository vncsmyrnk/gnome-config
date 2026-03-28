{
  description = "Opinionated GNOME configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      extensions = with pkgs.gnomeExtensions; [
        argos
        window-calls
      ];

      extensionBundle = pkgs.symlinkJoin {
        name = "gnome-extensions-bundle";
        paths = extensions;
      };

      installExtensionsScript = pkgs.writeShellApplication {
        name = "install-extensions";
        runtimeInputs = with pkgs; [
          coreutils
          findutils
        ];
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
        dontUnpack = true;
        installPhase = ''
          mkdir -p $out/bin

          cp $src $out/bin/gnome-focus-recent-window
        '';
      };

      config = pkgs.stdenv.mkDerivation {
        name = "gnome-config";
        src = ./.;
        dontUnpack = true;
        nativeBuildInputs = [ pkgs.makeWrapper ];
        installPhase = ''
          mkdir -p $out/bin $out/share/gnome-config/dconf

          cp -a $src/bin/* $out/bin/
          cp -a $src/dconf/* $out/share/gnome-config/dconf

          wrapProgram $out/bin/gnome-config \
            --set GNOME_CONFIG_PATH $out/share/gnome-config/dconf
        '';
      };

      runConfigApply = pkgs.writeShellApplication {
        name = "run-config-apply";
        text = ''
          ${config}/bin/gnome-config apply
        '';
      };

      runConfigReset = pkgs.writeShellApplication {
        name = "run-config-reset";
        text = ''
          ${config}/bin/gnome-config reset
        '';
      };

      runAll = pkgs.writeShellApplication {
        name = "run-all";
        text = ''
          ${installExtensionsScript}/bin/install-extensions
          ${config}/bin/gnome-config apply
        '';
      };

      runnersBundle = pkgs.symlinkJoin {
        name = "runners-bundle";
        paths = [
          runConfigApply
          runConfigReset
          runAll
        ];
      };

    in
    {
      packages.${system} = {
        focus-recent-window = focusRecentWindow;
        inherit config;
      };

      apps.${system} = {
        default = {
          type = "app";
          program = "${runnersBundle}/bin/run-all";
        };
        config-apply = {
          type = "app";
          program = "${runnersBundle}/bin/run-config-apply";
        };
        config-reset = {
          type = "app";
          program = "${runnersBundle}/bin/run-config-reset";
        };
      };
    };
}
