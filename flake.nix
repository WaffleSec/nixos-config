{
  description = "Waffles NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nixos-generators, catppuccin, ...}:
    let
      username = "waffles";
      userfullname = "WaffleSec";
      useremail = "me@waffles.sh";

      x64_system = "x86_64-linux";
      allSystems = [ x64_system ];

      nixosSystem = import ./lib/nixosSystem.nix;
    in {
      nixosConfigurations = let
        wafflenovo_modules = {
          nixos-modules = [
            ./hosts/wafflenovo
          ];
          home-module = import ./home/linux/desktop-plasma.nix;
        };
        wafflestation_modules = {
          nixos-modules = [
            ./hosts/wafflestation
          ];
          home-module = import ./home/linux/desktop-plasma.nix;
        };
        system = x64_system;
        specialArgs =
          {
            inherit username userfullname useremail;
            pkgs-unstable = import nixpkgs-unstable {
              system = x64_system;
              config.allowUnfree = true;
            };
          }
          // inputs;
        base_args = {
          inherit home-manager nixos-generators system catppuccin specialArgs;
        };
        stable_args = base_args // {inherit nixpkgs;};
        unstable_args = base_args // {nixpkgs = nixpkgs-unstable;};
      in {
        wafflenovo = nixosSystem (wafflenovo_modules // stable_args);
        wafflestation = nixosSystem (wafflestation_modules // stable_args);
      };
/*
      packages."${x64_system}" =
        nixpkgs.lib.genAttrs [
          "wafflenovo"
        ] (
          host:
            self.nixosConfigurations.${host}.config.formats.iso
        );
*/
      };
}
