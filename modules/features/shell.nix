{ self, inputs, ... }: {
  flake.nixosModules.shell = { pkgs, lib, ... }: {
    environment.systemPackages = [ pkgs.starship pkgs.eza ];
    programs.fish = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myShell;
    };

    programs.starship = {
      enable = true;
    };

    programs.zoxide = {
      enable = true;
    };

    users.users.rares = { shell = pkgs.fish; };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myShell = inputs.wrapper-modules.wrappers.fish.wrap {
      inherit pkgs;
      runtimePkgs = [
        pkgs.starship
        pkgs.zoxide
      ];
      shellAliases = {
        "cd"="z";
        "nix-rebuild"="sudo nixos-rebuild switch --flake /home/rares/myNixOS#myMachine";
        "nix-upgrade"="sudo nixos-rebuild switch --flake /home/rares/myNixOS#myMachine --upgrade";
        "nix-apps"="nano /home/rares/myNixOS/modules/features/apps/apps.nix && sudo nixos-rebuild switch --flake /home/rares/myNixOS#myMachine";
        "cava"="cava -p /home/rares/.config/cava/themes/noctalia";
        "ls"="eza --icons";
      };
      configFile.content = "
        starship init fish | source
        zoxide init fish | source
        set -g fish_color_autosuggestion 555
        colorscript -e panes
      ";
    };
  };
}
