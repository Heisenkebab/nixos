{lib, ...}: {
  programs.zsh.initContent = lib.mkAfter ''
    export DOCKER_HOST="unix://$HOME/.lima/default/sock/docker.sock"
  '';
}
