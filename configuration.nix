# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./modules/hardware-configuration.nix # Hardware configuration
      # Include pkgs for themes
      #./pkgs                                       ### Kanagawa theme ### TO DO ###
      # Include configuration modules.
      ./modules/8bitdo.nix # Controler workaround
      ./modules/disk.nix # Disk & filesystem
      ./modules/hyprland.nix # Hyprland Display Manager & config
      ./modules/ldmtool.nix # LDMtool service
      ./modules/linux-kernel.nix # Linux Kernel config
      ./modules/nix-gaming.nix # Fufexan nix-gaming
      ./modules/nvidia.nix # Nvidia drivers & config
      ./modules/steam.nix # Steam config
      ./modules/cornelis.nix # User - That's me
    ];

  # Allow Nix flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Enable Flatpak
  services.flatpak.enable = true;

  # Scheduled auto upgrade system
  system.autoUpgrade = {
    enable = true;
    operation = "switch"; # If you don't want to apply updates immediately, only after rebooting, use `boot` option in this case
    flake = "/home/nixos/";
    flags = [ "--update-input" "nixpkgs" "--update-input" "stable" "--update-input" "home-manager" "hyprland" "--update-input" "--commit-lock-file" ];
    dates = "daily";
    # channel = "https://nixos.org/channels/nixos-unstable";
  };

  # Optimize storage and automatic scheduled GC running
  # If you want to run GC manually, use commands:
  # `nix-store --optimize` for finding and eliminating redundant copies of identical store paths
  # `nix-store --gc` for optimizing the nix store and removing unreferenced and obsolete store paths
  # `nix-collect-garbage -d` for deleting old generations of user profiles
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  #boot.loader.efi.efiSysMountPoint = "/boot";    ### Older version ?
  boot.loader.grub.useOSProber = true;
  boot.loader.timeout = 1;
  boot.initrd.enable = true;
  boot.initrd.systemd.enable = true;
  boot.plymouth = {
    # Boot splash and boot logger       ### To change for SDDM
    enable = true;
    #  font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
    #  themePackages = [ pkgs.catppuccin-plymouth ];
    #  theme = "catppuccin-macchiato";
  };

  # Enable networking
  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ 3000 ];
  # networking.firewall.allowedUDPPorts = [ 3000 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Configure keymap in X11
  services.xserver = {
    layout = "fr";
    xkbVariant = "us";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Set your time zone.
  time.hardwareClockInLocalTime = true;
  time.timeZone = "Europe/Paris";

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono # A typeface made for developers
    nerdfonts # Needed for lot of packages
    nerd-font-patcher # Font patcher to generate Nerd font
    font-awesome_5 # Font for orignal Waybar
    font-awesome_4
    font-awesome
    line-awesome
    fira-code # Monospace font with programming ligatures
    weather-icons # Weather icons
    google-fonts # Font files available from Google Fonts
  ];

  # USB Automounting
  services.gvfs.enable = true;
  # services.udisks2.enable = true;
  # services.devmon.enable = true;

  # Systemd services setup
  systemd.packages = with pkgs; [
    auto-cpufreq # Automatic CPU speed & power optimizer for Linux
  ];

  # Polkit gnome.
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "multi-user.target" ];
      wants = [ "multi-user.target" ];
      after = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Enable Services
  security.pam.services.swaylock = { };
  services.geoclue2.enable = true;
  programs.direnv.enable = true;
  services.upower.enable = true;
  programs.fish.enable = true;
  programs.dconf.enable = true;
  services.dbus.enable = true;
  services.dbus.packages = with pkgs; [
    xfce.xfconf
    gnome2.GConf
  ];
  services.mpd.enable = true;
  programs.thunar.enable = true;
  services.tumbler.enable = true;
  services.fwupd.enable = true;
  services.auto-cpufreq.enable = true;
  services.envfs.enable = true;

  # zRam
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
  };

  # Swappiness
  boot.kernel.sysctl = { "vm.swappiness" = 10; };

  # Trim For SSD, fstrim.
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  #services.udev.packages = with pkgs; [
  #  gnome.gnome-settings-daemon 
  #];

  # System wide packages
  environment.systemPackages = with pkgs; [
    ### Gnome ###
    baobab # Graphical application to analyse disk usage in any GNOME environment
    glib # For gsettings to work 
    gedit # File editor
    gnome.file-roller # Archive manager
    gnome.gnome-disk-utility # Disk utilitary
    gnome.gnome-software # GUI install Flatpak
    gnome.gnome-system-monitor # Gnome monitor

    ### Media ###
    mpv # General-purpose media player, fork of MPlayer and mplayer2
    imv # A command line image viewer for tiling window managers
    ffmpeg_6-full # Cross-platform solution to record, convert and stream audio and video

    ### Sound ###
    pamixer # Pulseaudio command line mixer
    pulsemixer # Cli and curses mixer for pulseaudio
    pavucontrol # PulseAudio Volume Control
    goxlr-utility # An unofficial GoXLR App replacement for Linux

    ### Theme ###
    bibata-cursors # Cursor theme
    gtk-engine-murrine # Needed for a lot of GTK components
    libsForQt5.qt5ct # QT5 theming
    # pmypackages.kanagawa                       ### Kanagawa theme TO DO ### Check line 13 to activate  ###
    nwg-look # GTK theming
    tokyo-night-gtk # GTK theme

    ### Terminal ###
    kitty # A modern, hackable, featureful, OpenGL based terminal emulator
    starship # A minimal, blazing fast, and extremely customizable prompt for any shell

    ### Termninal fetch ###
    neofetch # A fast, highly customizable system info script
    onefetch # Git repository summary on terminal
    ipfetch # Neofetch for ip adresses
    cpufetch # Simplistic yet fancy CPU architecture fetching tool
    starfetch # CLI star constellations displayer
    octofetch # Github user information on terminal

    ### Terminal monitors ###
    htop # An interactive process viewer
    bottom # A cross-platform graphical process/system monitor with a customizable interface
    btop # A monitor of resources
    kmon # Linux Kernel Manager and Activity Monitor
    nvtop # A (h)top like task monitor for AMD, Adreno, Intel and NVIDIA GPUs

    ### Terminal utils ###
    bash # Shell for convenience with downloaded script & other
    lazygit # Simple terminal UI for git commands
    git-ignore # Fetch .gitignore templates from gitignore.io
    git-credential-manager # A secure, cross-platform Git credential storage with authentication to GitHub, Azure Repos, and other popular Git hosting services
    pass-git-helper # A git credential helper interfacing with pass, the standard unix password manager
    lf # A terminal file manager written in Go and heavily inspired by ranger
    yad # GUI dialog tool for shell scripts
    gettext # Required for building things
    glib.dev # C library of proramming building blocks
    gitFull # Distributed version control system
    gh # GitHub CLI tool
    gnumake # Make command
    killall # Kill all command
    wget # Wget command
    unzip # Unzip command
    zip # Zip command
    gnumake # Make command

    cmatrix # Simulates the falling characters theme from The Matrix movie
    pipes-rs # An over-engineered rewrite of pipes.sh in Rust
    rsclock # A simple terminal clock written in Rust
    cava # Console-based Audio Visualizer for Alsa
    figlet # Program for making large letters out of ordinary text

    ### Text ###
    libreoffice # Comprehensive, professional-quality productivity suite, a variant of openoffice.org

    ### USB specific packages ###
    usbutils # Tools for working with USB devices, such as lsusb

    ### Wine ###
    wine # Wine for gaming
    wine64
    winePackages.wayland
    wine64Packages.wayland
    winetricks
    wine-staging

    # vulkan-tools                            # Khronos official Vulkan Tools and Utilities
    # opencl-info                             # A tool to dump OpenCL platform/device information
    # clinfo                                  # Print all known information about all available OpenCL platforms and devices in the system
    # vdpauinfo                               # Query the Video Decode and Presentation API for Unix
    # libva-utils                             # A collection of utilities and examples for VA-API
    at-spi2-atk # Interface protocol definitions and daemon for D-Bus
    dig # Domain name server
    speedtest-rs # Command line internet speedtest tool written in rust
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
