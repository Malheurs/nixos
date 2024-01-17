{ config, lib, pkgs, ... }:

{
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {

    # Modesetting is need most of the time
    modesetting.enable = true;

    # Enable power management (do no disable)
    # Likely to cause problems on laptos and with screen tearing if disabled
    powerManagement.enable = true;

    # Use the Nvidia open source kernel module (which isn't "nouveau")
    # Support is limited to the Turing and later architectures.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via 'nvidia-settings'.
    nvidiaSettings = true;

    # Force Full Composition Pipeline. Fixe screen tearing. Can reduce OpenGl performance.
    forceFullCompositionPipeline = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # package = config.boot.kernelPackages.nvidiaPackages.stable;       # Stable version
    # package = config.boot.kernelPackages.nvidiaPackages.beta;         # Beta version
    package = config.boot.kernelPackages.nvidiaPackages.production;   # Production version 535
    # package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;  # Vulkan version 535 other
    ### To pin a specific package     ###
    #   525 OK / 535 SHIT / 545 Hope    #
    ###                               ###
    #package = (config.boot.kernelPackages.nvidiaPackages.stable.overrideAttrs {
    #  src = pkgs.fetchurl {
    #    url = "https://download.nvidia.com/XFree86/Linux-x86_64/525.147.05/NVIDIA-Linux-x86_64-525.147.05.run";
    #    sha256 = "sha256-Q1GD6lRcfhLjBE15htoHdYozab7+fuUZ6zsGPUrz/vE=";
    #  };
    #});
  };
}
