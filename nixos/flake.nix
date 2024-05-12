{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
    } @inputs: let 
      systemSettings = {
        system = "x86_64-linux";
        hostname = "nixos";
        timezone = "America/Sao_Paulo";
        locale = "en_US.UTF-8";
      };

      userSettings = {
        username = "ruan";
        githubUser = "ruan-molinari";
        name = "Ruan";
        email = "ruan.molinari@proton.me";
        editor = "nvim";
      };

      lib = nixpkgs.lib;
      system = systemSettings.system;
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in {
      nixosConfigurations = {
        default = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit systemSettings;
            inherit userSettings;
          };
          modules = [
            ./hosts/default
          ];
        };
      };

      homeConfigurations = {
        ruan = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
            inherit systemSettings;
            inherit userSettings;
          };
          modules = [
            ./users/ruan/home.nix
          ];
        };
      };
    };
}
