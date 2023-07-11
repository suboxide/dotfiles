{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nur.url = "github:nix-community/NUR";
  };

   outputs = { nixpkgs, nur, nix-colors, home-manager, nix-gaming, ... }@inputs:
   let
        pkgs = import nixpkgs {
            overlays = [
                nur.overlay
            ];
        };
    in
    {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nix-colors; };
        modules = [
          ./configuration.nix
          nur.nixosModules.nur
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sub = import ./home.nix;
			home-manager.extraSpecialArgs = { inherit nix-colors; };
            nixpkgs.overlays = [
                  nur.overlay
            ];
            _module.args.nur = { inherit nur; };
           }
           ({ config, ... }: {
           environment.systemPackages = [ 
           	config.nur.repos.anthonyroussel.shadow-testing 
           	inputs.nix-gaming.packages.x86_64-linux.wine-ge
           	];
           })
        ];
      };
    };

  };
}
