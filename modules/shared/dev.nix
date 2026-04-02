{pkgs, ...}: {
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
    gdb
    # tui
    typioca
    binsider
    pipes-rs
    gpg-tui
    tmux
    lazygit
    btop
    neovim
    yazi
    zellij
    minicom

    # gui
    jetbrains.datagrip
    jetbrains.rider
    jetbrains.idea
  ];
}
