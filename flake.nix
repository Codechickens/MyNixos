{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    omarchy-nix = {
        url = "github:henrysipp/omarchy-nix";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "home-manager";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, omarchy-nix, home-manager, ... }: {
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      modules = [
        omarchy-nix.nixosModules.default
        home-manager.nixosModules.home-manager #Add this import
        {
          # Configure omarchy
          omarchy = {
            full_name = "lucifer";
            email_address = "mateirudante@gmail.com";
            theme = "tokyo-night";
          };
          
          home-manager = {
            users.your-username = {
              imports = [ omarchy-nix.homeManagerModules.default ]; # And this one
            };
          };
        }
      ];
    };
  };
}