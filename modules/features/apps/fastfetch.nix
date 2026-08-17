{ self, inputs, ... }: {
  flake.nixosModules.fastfetch = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.fastfetch
    ];
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.fastfetch = inputs.wrapper-modules.wrappers.fastfetch.wrap {
      inherit pkgs;
      # Pasăm configurarea direct către opțiunea `settings` cerută de wrapper
      settings = builtins.fromJSON (builtins.readFile ./fastfetch.json);
    };
  };
}
