_: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Heisenkebab";
        email = "heisenkebab@proton.me";
      };

      aliases = {
        open = "!sh -c 'url=$(git config --get remote.origin.url); if [[ $url == git@* ]]; then url=$(echo $url | sed -e \"s/:/\\//\" -e \"s/^git@/https:\\/\\//\" -e \"s/\\.git$//\"); fi; xdg-open $url'";
      };

      pull = {
        rebase = true;
      };

      init.defaultBranch = "main";

      credential.helper = "!gh auth git-credential";
    };

    ignores = ["*~" ".DS_Store" ".direnv"];
  };
}
