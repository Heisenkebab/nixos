{meta, ...}:
if meta.name == "laptop"
then {
  home.file.".config/hypr/hyprpaper.conf".text = ''
  preload = ${../../../../wallpapers/wallhaven-black.png}
  preload = ${../../../../wallpapers/wallhaven-forest.jpg}
  wallpaper = eDP-1, ${../../../../wallpapers/wallhaven-black.png}
  wallpaper = HDMI-A-1, ${../../../../wallpapers/wallhaven-forest.jpg}
  '';
}
else if meta.name == "pc"
then {
  home.file.".config/hypr/hyprpaper.conf".text = ''
  preload = ${../../../../wallpapers/wallhaven-black.png}
  wallpaper = , ${../../../../wallpapers/wallhaven-black.png}
  '';
}
else {
  home.file.".config/hypr/hyprpaper.conf".text = ''
  preload = ${../../../../wallpapers/wallhaven-black.png}
  wallpaper = , ${../../../../wallpapers/wallhaven-black.png}
  '';
}
