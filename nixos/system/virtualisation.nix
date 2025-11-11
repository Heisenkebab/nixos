_: {
  virtualisation = {
    libvirtd.enable = false;

    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };

      guest = {
        enable = false;
        dragAndDrop = true;
        seamless = true;
        clipboard = true;
      };
    };
  };
}
