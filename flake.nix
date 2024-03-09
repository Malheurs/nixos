{
  description = "Cornelis's Nix Flake";

  inputs = {
    ### Nix Packages ###
    stable.url = "github:NixOS/nixpkgs/nixos-23.11"; # Stable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Unstable

    ### Hyprland ###
    hyprland.url = "github:hyprwm/Hyprland";

    ### Nix Gaming ###
    nix-gaming.url = "github:fufexan/nix-gaming";

    ### Genshin Impact ###
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs"; # Name of nixpkgs input you want to use

    ### Home Manager ###
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, aagl, ... } @ inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      #  pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [

          ];
        };
      };
    in
    {
      homeConfigurations = {
        cornelis = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            /home/cornelis/nixos/home.nix
            #/home/cornelis/nixos/home/configurations/cornelis.nix
          ];
        };
      };
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          inherit pkgs;
          specialArgs = { inherit inputs; };
          modules = [
            /home/cornelis/nixos/configuration.nix
            {
              imports = [ aagl.nixosModules.default ];
              nix.settings = aagl.nixConfig; # Set up Cachix
              programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
            }
          ];
        };
      };
    };
}
