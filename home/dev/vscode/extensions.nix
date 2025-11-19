{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      github.copilot
      ms-python.python
      ms-python.debugpy
      zhuangtongfa.material-theme
      esbenp.prettier-vscode
      usernamehw.errorlens
      eamodio.gitlens
      bradlc.vscode-tailwindcss
      prisma.prisma
      (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "material-icon-theme";
          publisher = "PKief";
          version = "5.28.0";
          hash = "sha256-VZFeEaWe5JZQegOJ674vHxQAFuWFG5lttnWwSQ5AY5g=";
        };
      })
    ];
    mutableExtensionsDir = false;
    package = pkgs.vscode;
  };
}
