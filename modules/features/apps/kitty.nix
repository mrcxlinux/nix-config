{ self, inputs, ... }: {
  flake.nixosModules.terminal = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myTerminal
    ];
  };


  perSystem = { pkgs, lib, self', ... }: {
    packages.myTerminal = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;
      keybindings =  {
        "ctrl+plus" = "change_font_size all +1";
        "ctrl+equal" = "change_font_size all +1";
        "ctrl+kp_add" = "change_font_size all +1";
        "ctrl+minus" = "change_font_size all -1";
        "ctrl+underscore" = "change_font_size all -1";
        "ctrl+kp_subtract" = "change_font_size all -1";
        "ctrl+0" = "change_font_size all 0";
        "ctrl+kp_0" = "change_font_size all 0";
      };
      extraConfig = "include ~/.config/kitty/current-theme.conf";
      font.name = "NotoMono Nerd Font";
      settings = {
        confirm_os_window_close = 0;
        cursor_shape = "beam";
        cursor_trail = 1;
        window_margin_width = 10;};
      };
  };
}
