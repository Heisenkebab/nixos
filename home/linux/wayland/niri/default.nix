{...}: {
  imports = [
    ./niri.nix
    ./swaylock.nix
    # launcher is noctalia's (home/linux/wayland/noctalia/components/launcher.nix); kept for fallback
    # ./fuzzel.nix
    # idle is handled by noctalia (home/linux/wayland/noctalia); kept for fallback
    # ./swayidle.nix
  ];
}
