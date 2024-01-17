{ inputs, pkgs, ... }:

{
  # Cachix 
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables = {
    # Necessary for e.g. `Hyprland` config `exec` commands to use `gsettings`,
    # e.g. to bind keys for switching light/dark mode.
    XDG_DATA_DIRS =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      [ datadir ];
  };

  environment.systemPackages = with pkgs; [
    # Hyprland required
    brightnessctl # Read and control device brightness
    cliphist # Wayland clipboard manager
    dunst # Notification daemon
    eww # ElKowars wacky widgets
    grim # Screenshot
    hyprpicker # Wayland color picker
    libsForQt5.qt5ct # Qt5 Configuration Tool
    libsForQt5.qtstyleplugin-kvantum # Qt5 theme engine plus a config tool and extra themes
    networkmanagerapplet # Network manager applet
    nwg-look # UI Gtk settings
    playerctl # CLI for controlling media players that implement MPRIS
    pywal # Generate and change color theme on the fly
    pyprland # Hyprland plugin system
    qt6.qtwayland # A cross-platform application framework for C+
    rofi-wayland # Windows switcher, DMenu
    slurp # Select region for screenshot
    swappy # Wayland native snapshot
    swaylock-effects # Screen locker
    swayidle # Idle manager deamon
    swaynotificationcenter # Notification daemon
    swww # Animated wallpaper daemon
    waybar # Wayland bar
    wlogout # Logout menu
    #  wpaperd                                  # Minimal wallpaper deamon
    wl-clipboard # CLI copy/paste
    wf-recorder # Screen recording
    #  wl-screenrec                             # High perf screen recording
    wlsunset # Day/night gamma adjustments for Wayland
    wtype # Xdotool 
    wlrctl # CLI for misc extesions
    wlr-randr # Screen utility for setting main screen
  ];
}
