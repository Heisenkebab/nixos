{pkgs, ...}: {
  environment.systemPackages = with pkgs;
    [
      gcc
      gnumake
      rustup
      go_1_24
      air
      nodejs
      yarn
      python313
      alejandra
    ]
    ++ [
      zls
      rust-analyzer
      tinymist
      nil
      bash-language-server
      vscode-langservers-extracted
      typescript-language-server
      tailwindcss-language-server
      marksman
      lua-language-server
      sqls
      yaml-language-server
      gopls
      pyright
    ];
}
