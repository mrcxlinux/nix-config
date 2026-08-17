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
      inputs.nix4nvchad.packages.${pkgs.stdenv.hostPlatform.system}.default
      ripgrep
      luaPackages.tree-sitter-cli
      tree-sitter

      # TUI
      cava
      fastfetch
      dwt1-shell-color-scripts

      # Fonts
      nerd-fonts.noto
    ];
  };
}
