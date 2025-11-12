{pkgs, ...}: {
  programs.vscode = {
    userSettings = {
      "files.autoSave" = "onFocusChange";
      "editor.formatOnSave" = true;
      "workbench.sideBar.location" = "right";
      "workbench.colorTheme" = "One Dark Pro Night Flat";
    };
  }
}
