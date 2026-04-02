# <https://wiki.nixos.org/wiki/Fonts>
{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.hack
      nerd-fonts.symbols-only
    ];
  };
}
