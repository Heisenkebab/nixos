# <https://wiki.nixos.org/wiki/Docker>
_: {
  virtualisation = {
    docker = {
      enable = true;
      # Start Docker on first use (socket activation) instead of at boot
      enableOnBoot = false;
    };

    podman = {
      enable = false;
    };
  };
}
