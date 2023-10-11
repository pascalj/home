{
  description = "Home configurations";

  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        # 'home-manager switch' will look for <username>@<host> and <username>
        hosts = [
          { username = "pascalj"; hostname = "carol"; }
          { username = "pascal"; hostname = "GS-3KXV8Y3"; }
        ];

        # Small wrapper to have a ./<hostname>.nix file
        mkHome = { username, hostname }: {
          "${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
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
        formatter = pkgs.nixpkgs-fmt;
        packages.homeConfigurations = pkgs.lib.attrsets.mergeAttrsList (map mkHome hosts);
      }
    );
}
