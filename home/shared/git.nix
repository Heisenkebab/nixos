_: {
  programs.git = {
    enable = true;
    userName = "Heisenkebab";
    userEmail = "winnoa21@htl-kaindorf.at";
    ignores = ["*~" ".DS_Store" ".direnv"];
    aliases = {
      open = "!sh -c 'url=$(git config --get remote.origin.url); if [[ $url == git@* ]]; then url=$(echo $url | sed -e \"s/:/\\//\" -e \"s/^git@/https:\\/\\//\" -e \"s/\\.git$//\"); fi; xdg-open $url'";
    };
    extraConfig = {
      pull = {
        rebase = true;
      };
      credential.helper = "!gh auth git-credential";
    };
  };
}
