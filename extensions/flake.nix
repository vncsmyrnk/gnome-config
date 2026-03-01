{
  description = "Pure Flake GNOME Extensions Management";

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

      installScript = pkgs.writeShellApplication {
        name = "apply-extensions";
        runtimeInputs = with pkgs; [ glib coreutils gawk gnused findutils ];
        text = ''
          echo "Building extension bundle..."
          BUNDLE_PATH="${extensionBundle}"
          EXT_DIR="$HOME/.local/share/gnome-shell/extensions"

          echo "Ensuring GNOME extensions directory exists..."
          mkdir -p "$EXT_DIR"

          echo "Symlinking extensions from Nix store..."
          find "$EXT_DIR" -type l -delete 

          if [ -d "$BUNDLE_PATH/share/gnome-shell/extensions" ]; then
            ln -sfn "$BUNDLE_PATH"/share/gnome-shell/extensions/* "$EXT_DIR/"
          fi

          echo "Generating extension list for GNOME..."
          EXT_LIST=$(find "$EXT_DIR" | awk '{printf "\047%s\047,", $0}' | sed 's/,$//')

          echo "Enabling extensions via gsettings..."
          gsettings set org.gnome.shell disable-user-extensions false
          gsettings set org.gnome.shell enabled-extensions "[$EXT_LIST]"

          echo "Done! Please log out and back in for GNOME to load the new extensions."
        '';
      };

    in {
      packages.${system}.default = extensionBundle;

      apps.${system}.default = {
        type = "app";
        program = "${installScript}/bin/apply-extensions";
      };
    };
}
