{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
        settings = {
          spawn-at-startup = [
            (lib.getExe self'.packages.myNoctalia)
          ];

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          input.keyboard.xkb.layout = "us,ro";

          input.touchpad.natural-scroll = { };

          layout = {
            gaps = 15;
            struts = {
              left = 5;
              right = 5;
            };
            border.off = _: { };
            focus-ring.off = _: { };
          };

          prefer-no-csd = true;

          extraConfig = ''
              include optional=true "/home/rares/.config/niri/noctalia.kdl"

              window-rule {
                geometry-corner-radius 10
                clip-to-geometry true
              }

              window-rule {
                match is-focused=true

                focus-ring {
                  on
                  width 2
                }

                shadow {
                  on
                  softness 12
                  spread 1
                  offset x=0 y=3
                }
              }

              window-rule {
                match is-focused=false

                shadow {
                  off
                }
              }

              environment {
                QT_QPA_PLATFORMTHEME "kde"
                XDG_MENU_PREFIX "plasma-"
            }

            layer-rule {
              match namespace="^noctalia-backdrop"
              place-within-backdrop true
            }

          '';

          binds = {
            "Mod+Return".spawn-sh = "${lib.getExe self'.packages.myTerminal}";
            "Mod+Q".close-window = _: { };
            "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} msg panel-toggle launcher";
            "Mod+F".toggle-window-floating = _: { };
            "Mod+E".spawn-sh = "dolphin";
            "Mod+W".spawn-sh = "zen";
            "Mod+X".spawn-sh = "${lib.getExe self'.packages.myNoctalia} msg panel-toggle session";
            "Mod+Shift+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} msg screenshot-region";
            "Mod+V".spawn-sh = "${lib.getExe self'.packages.myNoctalia} msg clipboard";
            "Mod+Print".spawn-sh = "${lib.getExe self'.packages.myNoctalia} msg screenshot-fullscreen";
            "XF86MonBrightnessUp".spawn-sh = "${lib.getExe self'.packages.myNoctalia} msg brightness-up";
            "XF86MonBrightnessDown".spawn-sh = "${lib.getExe self'.packages.myNoctalia} msg brightness-down";
            "XF86AudioRaiseVolume".spawn-sh = "${lib.getExe self'.packages.myNoctalia} msg volume-up";
            "XF86AudioLowerVolume".spawn-sh = "${lib.getExe self'.packages.myNoctalia} msg volume-down";
            "XF86AudioMute".spawn-sh = "${lib.getExe self'.packages.myNoctalia} msg volume-mute";
            "Mod+Space".switch-layout = "next";
            "Mod+Shift+F".maximize-column = _: { };
            "Mod+1".focus-workspace = 1;
            "Mod+2".focus-workspace = 2;
            "Mod+3".focus-workspace = 3;
            "Mod+4".focus-workspace = 4;
            "Mod+Left".focus-column-left = _: { };
            "Mod+Right".focus-column-right = _: { };
            "Mod+Shift+Left".move-column-left = _: { };
            "Mod+Shift+Right".move-column-right = _: { };
          };
        };
      };
    };
}
