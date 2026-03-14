# home.nix
{ variables, ... }: {
  imports =[
    ./packages.nix
    ./dotfiles.nix
  ];
}