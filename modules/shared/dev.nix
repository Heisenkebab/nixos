{
  stable,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # tools
    wireguard-tools
    eza
    oh-my-zsh
    zsh
    starship
    fzf
    ripgrep
    cloc
    docker
    bat
    gh
    jq
    zip
    unzip
    gnupg
    direnv
    git
    gh
    zoxide
    bat
    delta
    fastfetch
    ffmpeg
    sass
    snicat
    # tui
    typioca
    binsider
    pipes-rs
    gpg-tui
    tmux
    lazygit
    btop
    # nvim-treesitter master is archived and does not support 0.12;
    # stablepkgs (nixos-25.11) is on 0.11.7, which it does support.
    stable.neovim
    yazi
    zellij
    minicom

    #ai
    claude-code
    github-copilot-cli
  ];
}
