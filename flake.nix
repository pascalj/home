{
  description = "Home configurations";

  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, homeManager }: let
    stateVersion = "23.05";
    system = "x86_64-linux";
    hosts = [
      { username = "pascalj"; hostname = "carol"; }
      { username = "pascal"; hostname = "GS"; }
    ];

    pkgs = nixpkgs.legacyPackages.${system};
    lib = pkgs.lib;
    mkHome = {username, hostname}: {
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
  in {
    formatter.${system} = pkgs.nixpkgs-fmt;
    homeConfigurations = lib.attrsets.mergeAttrsList (map mkHome hosts);
  };
}
