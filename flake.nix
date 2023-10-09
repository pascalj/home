{
  description = "Home configurations";

  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, homeManager }:
    let
      stateVersion = "23.05";
      system = "x86_64-linux";
      # 'home-manager switch' will look for <username>@<host> and <username>
      hosts = [
        { username = "pascalj"; hostname = "carol"; }
        { username = "pascal"; hostname = "GS-3KXV8Y3"; }
      ];

      pkgs = nixpkgs.legacyPackages.${system};
      lib = pkgs.lib;
      # Small wrapper to have a ./<hostname>.nix file
      mkHome = { username, hostname }: {
        "${username}@${hostname}" = homeManager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = (builtins.filter builtins.pathExists [
            ./home.nix
            ./${hostname}.nix
          ]) ++ [
            {
              home.username = username;
              home.homeDirectory = "/home/${username}";
            }
          ];
        };
      };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      homeConfigurations = lib.attrsets.mergeAttrsList (map mkHome hosts);
    };
}
