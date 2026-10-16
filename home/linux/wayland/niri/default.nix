{...}: {
  imports = [
    ./niri.nix
    ./swaylock.nix
    ./fuzzel.nix
    # idle is handled by noctalia (home/linux/wayland/noctalia); kept for fallback
    # ./swayidle.nix
  ];
}
