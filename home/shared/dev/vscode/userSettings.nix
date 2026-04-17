{pkgs, ...}: {
  programs.vscode = {
    profiles.default.userSettings = {
      "files.autoSave" = "onFocusChange";
      "editor.formatOnSave" = true;
      "workbench.sideBar.location" = "right";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "editor.cursorBlinking" = "expand";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.wordWrap" = "on";
    };
  };
}
