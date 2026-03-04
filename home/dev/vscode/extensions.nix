{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
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
      quicktype.quicktype
      github.copilot-chat
      (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "sqltools-driver-pg";
          publisher = "mtxr";
          version = "0.5.7";
          hash = "sha256-fbQsKnkBz11ZTZ2v7Y9bQ9GHPjactUoB98LeNRKeOkY=";
        };
      })
      (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "sqltools";
          publisher = "mtxr";
          version = "0.28.5";
          hash = "sha256-2JgBRMaNU3einOZ0POfcc887HCScu6myETTLoJMS6o8=";
        };
      })
      (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "vscode-containers";
          publisher = "ms-azuretools";
          version = "2.3.0";
          hash = "sha256-zrEZpd2geX2G4u6LkIk3d6C7vhwZZ4lwHGQR3Z0OWY4=";
        };
      })
      (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "simple-react-snippets";
          publisher = "burkeholland";
          version = "1.2.8";
          hash = "sha256-zrRxJZHRqBMGVkd56Q+wDbCSFfl4X3Kta4sX8ecZmu8=";
        };
      })
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
