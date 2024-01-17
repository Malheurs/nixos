{ self, ... } : { config, lib, pkgs, ... }:

{
  ##################
  # Custom modules #
  ##################

  #themes.enable = true;
  #btop.enable = true;
  #dunst.enable = true;
  #firefox.enable = true;
  #gtk.config.enable = true;
  #hyprland.enable = true;
  #kitty.enable = true;
  #mangohud.enable = true;
  #mpv.enable = true;
  #neovim.enable = true;
  #obs-studio.enable = true;
  #qt.config.enable = true;
  #rofi.enable = true;
  #starship.enable = true;
  #vs-code.enable = true;
  #waybar.enable = true;
  #wlogout.enable = true;
  #xdg.config.enable = true;
  z#sh.enable = true;

  ##################
  # Configurations #
  ##################

  # Configure user experience
  home = {

    # Home variables
    stateVersion = "23.11";

    # Set environment variables
    sessionVariables = {

      # Programs to use
      MENU_CMD = "~/.config/rofi/scripts/launch-rofi.sh";
      EXIT_CMD = "~/.config/wlogout/scripts/launch-wlogout.sh";
      BROWSER = "floorp";
      EDITOR = "helix";
      FILE = "helix";
      FILEGUI = "thunar";
      LD_PATH = "$(nix build --print-out-paths --no-link nixpkgs#libGL)/lib";

      # Other
      USER_LOGO = "~/.dotfiles/img/nix-logo.png";
    };

    # Packages to install
    packages = with pkgs; [

      # Custom packages
      self.packages.x86_64-linux.scripts

      # Programs

      # Utilities
    ### Productivity ###
    obsidian-wayland
    ];
  };

  # Configure nixpkgs
  nixpkgs.config = {

    # Allow proprietary software
    allowUnfreePredicate = _: true;

    # Permit specific insecure packages
    permittedInsecurePackages = [
      #"electron-25.9.0"
      "electron-24.8.6" # Obsidian Wayland, above does not work
    ];
  };

  # Configure programs
  programs = {

    # Git #
  git = {
    enable = true;
    userName = "Malheurs";
    userEmail = "malheurcornelis@proton.me";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
    lfs.enable = true;
  };

  };

  # Configure services  
  services = {
  };
}
