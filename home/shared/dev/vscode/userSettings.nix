{pkgs, ...}: {
  programs.vscode = {
    profiles.default.userSettings = {
      "files.autoSave" = "onFocusChange";
      "editor.formatOnSave" = true;
      "workbench.sideBar.location" = "right";
      "workbench.colorTheme" = "One Dark Pro Night Flat";
      "editor.cursorBlinking" = "expand";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.wordWrap" = "on";
    };
  };
}
