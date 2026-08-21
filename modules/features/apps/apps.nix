{ self, inputs, ... }: {
  flake.nixosModules.apps = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.fastfetch
    ];
    environment.systemPackages = with pkgs; [
      # Web
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

      # Development
      git
      evtest
      inputs.lazyvim.packages.${pkgs.stdenv.hostPlatform.system}.default
      ripgrep
      luaPackages.tree-sitter-cli
      tree-sitter
      neovim
      gcc

      # TUI
      cava
      fastfetch
      dwt1-shell-color-scripts
      fd

      # Fonts
      nerd-fonts.noto
    ];
  };
}
