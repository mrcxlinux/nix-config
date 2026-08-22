{ self, inputs, ... }: {
  flake.nixosModules.apps = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.fastfetch
    ];
    environment.systemPackages = with pkgs; [
      # Web
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

      # Office
      onlyoffice-desktopeditors

      # Development
      git
      evtest
      inputs.lazyvim.packages.${pkgs.stdenv.hostPlatform.system}.default
      ripgrep
      luaPackages.tree-sitter-cli
      tree-sitter
      neovim
      gcc
      meson
      go
      nodejs_26
      cargo
      statix
      nixfmt

      # TUI
      cava
      fastfetch
      dwt1-shell-color-scripts
      fd
      unzip
      wget

      # Fonts
      nerd-fonts.noto
      corefonts
    ];
  };
}
