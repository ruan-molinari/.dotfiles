{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./video.nix
    ./dem.nix
  ];
}
