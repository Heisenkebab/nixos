{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    notion-app
    raycast
    utm
    hexfiend
  ];
}
