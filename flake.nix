{
  description = ''Handler framework for the Mongrel2 web server.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."mongrel2-master".dir   = "master";
  inputs."mongrel2-master".owner = "nim-nix-pkgs";
  inputs."mongrel2-master".ref   = "master";
  inputs."mongrel2-master".repo  = "mongrel2";
  inputs."mongrel2-master".type  = "github";
  inputs."mongrel2-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."mongrel2-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}