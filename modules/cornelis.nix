{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cornelis = {
    isNormalUser = true;
    description = "Cornelis";
    extraGroups = [ "networkmanager" "input" "wheel" "video" "audio" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      ### Internet Browser ###
      floorp # A fork of Firefox, focused on keeping the Open, Private and Sustainable Web alive, built in Japan
      #librewolf # Fork of Firefox with security patch

      ### Gaming ###
      cartridges # A GTK4 + Libadwaita game launcher
      discord # All-in-one cross-platform voice and text chat for gamers
      goverlay # An opensource project that aims to create a Graphical UI to help manage Linux overlays
      lutris # Open Source gaming platform for GNU/Linux
      mangohud # A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more
      #path-of-building # PoE character builder     ### Will work one day / Lutris instead ###
      protontricks # A simple wrapper for running Winetricks commands for Proton-enabled games
      protonup-qt # Install and manage Proton-GE and Luxtorpeda for Steam and Wine-GE for Lutris with this graphical user interface
      rare # GUI for Legendary, an Epic Games Launcher open source alternative

      ### Media ###
      #amberol # A small and simple sound and music player
      g4music # A beautiful, fast, fluent, light weight music player written in GTK4
      handbrake # A tool for converting video files and ripping DVDs
      #quodlibet # GTK-based audio player written in Python, using the Mutagen tagging library

      ### Utilities ###
      gimp # The GNU Image Manipulation Program
      #obsidian # A powerful knowledge base that works on top of a local folder of plain text Markdown files
      media-downloader # Youtube Downloader
      mkvtoolnix # MKV container tool
      qbittorrent # Featureful free software BitTorrent client
      warp # Sharing files tools
      whalebird # Electron based Mastodon, Pleroma and Misskey client for Windows, Mac and Linux
      wootility # A customization and management software for Wooting keyboards
      wooting-udev-rules # udev rules that give NixOS permission to communicate with Wooting keyboards
      zathura # PDF Reader

      ### Vpn ###
      #protonvpn-gui # Proton VPN GTK app for Linux
      protonvpn-gui_legacy # Official ProtonVPN Linux app
      protonvpn-cli # Linux command-line client for ProtonVPN

      ### VSCodium & code ###
      chezmoi # Manage your dotfiles across multiple machines, securely
      godot_4 # Free and Open Source 2D and 3D game engine
      hugo # A fast and modern static website engine
      helix # A post-modern modal text editor
      python3Full # A high-level dynamically-typed programming language
      #jetbrains.pycharm-community # IDE Python
      nixpkgs-fmt # Nix code formatter for nixpkgs

      ### Vscode free of Microsoft telemetry ###
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscode-extensions; [
          bbenoist.nix # Extension for nix support
          ms-python.python # Extension with rich support for the Python language
          ms-python.vscode-pylance # A performant, feature-rich language server for Python in VS Code
          enkia.tokyo-night # Theme that celebrates the lights of Downtown Tokyo at night      
          vscode-extensions.jnoortheen.nix-ide # Nix IDE with formatting and error support      
          vscode-extensions.esbenp.prettier-vscode # Code formatter using prettier
          vscode-extensions.ritwickdey.liveserver # Local server for web dev
          vscode-extensions.formulahendry.auto-rename-tag # Automaticallu rename paired HTML tag
          #vscode-extensions.eamodio.gitlens # Supercharge Git within VS Code
          #vscode-extensions.github.copilot # Autocomplete-style suggestions from an AI
          vscode-extensions.tabnine.tabnine-vscode # AI coding assistant with AI code completions and chat
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "kanagawa-vscode-color-theme";
            publisher = "metaphore";
            version = "0.2.1";
            sha256 = "sha256-i/PCuJFnqHuwFS0K2CsCCOw1oikSeTt+e2vPslLCSpc=";
          }
          {
            name = "vscode-html-css";
            publisher = "ecmel";
            version = "2.0.1";
            sha256 = "sha256-6JAcAwlNJXEAmU21rNUBBUl4usz7MkEpER3bRucSa74=";
          }
        ];
      })
    ];
  };

  # Enable Plex Media server
  services.plex = {
    enable = true;
    openFirewall = true;
    #    dataDir = "/var/lib/plex";
    #    user = "Cornelis_";
  };

  # Enable login
  services.xserver.enable = true; # Login 
  services.xserver.displayManager.sddm.enable = true; # Display Manager
  services.xserver.displayManager.sddm.wayland.enable = true; # Enable SDDM for Wayland
  #services.xserver.desktopManager.plasma5.enable = true; # Plasma 5 KDE desktop

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "cornelis";

  # Enable Wooting keyboards support
  hardware.wooting.enable = true;

  # Enable GoXLR autostart
  services.goxlr-utility.enable = true;
  # services.goxlr-utility.autoStart.xdg = true;                ### No xdg with Hyprland ###

}

### Workaround for Alsa-conf-ucm until patch is merged into ###
# Modify the nix store, should NEVER be done. #
# Acceptable this time cause is a one byte modification in one file. #
### Remove as soom as possible when ###

# mount /dev/disk/by-uuid/d5def15f-a51b-482c-9dae-efbe2f13b76c -o remount,rw /nix/store/
# sudo hx /nix/store/ykqqa5lrc81sm47qbcr0lxxjwxkra67w-alsa-ucm-conf-1.2.10/share/alsa/ucm2/common/pcm/split.conf
# sudo hx /nix/store/r75kll8jf5b8pq3g185ggwwnbl0pgdp6-steam-fhs/usr/share/alsa/ucm2/common/pcm/split.conf



