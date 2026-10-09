# AGENTS.md

This file provides guidance to coding agents (Claude Code, Codex, etc.) when working with code in this repository. `CLAUDE.md` is a symlink to this file.

## What this is

A single Nix flake building NixOS configs for two Linux hosts (`laptop`, `pc`) and a nix-darwin config for one Mac (`macBook`), sharing home-manager modules across all three. Everything is driven from the `hosts` list in `flake.nix` — there is no per-host directory tree; hosts are data, not code.

## Commands

```bash
# Evaluate everything (both nixosConfigurations, darwinConfigurations, devShells, templates)
nix flake check

# Apply a host (run on that host; darwin build must run on the Mac)
sudo nixos-rebuild switch --flake .#laptop
sudo nixos-rebuild switch --flake .#pc
darwin-rebuild switch --flake .#macBook

# Format / lint (mirrors .github/workflows/ci.yaml)
nix run nixpkgs#alejandra -- -c .
nix run nixpkgs#deadnix -- -f

# CTF devshell (see templates/ctf/README.md for what's inside)
nix develop ~/nixos#ctf          # or: echo 'use flake ~/nixos#ctf' > .envrc && direnv allow
nix flake init -t ~/nixos#ctf    # only when a challenge needs its own nixpkgs pin / extra tools
```

`.githooks/pre-commit` runs those same three checks (format, deadnix, `nix flake check`) on any commit that stages a `.nix` file or `flake.lock`. It is enabled by the direnv shell (`shell.nix` sets `core.hooksPath`); `git commit --no-verify` skips it.

A new file under `home/`, `modules/`, or `systems/` must be added to git (`git add`) before `nix flake check` will see it — the flake evaluates the tracked working tree, not the filesystem.

## Architecture

**Host registry (`flake.nix`)**: the `hosts` list is the single source of truth per machine — `name`, `system.os`/`dGpu`/`iGpu`, `wm`. `forLinuxHosts`/`forDarwinHosts` fold each entry into a `nixosSystem`/`darwinSystem`. Adding a host means adding an entry here, not a new directory tree.

**`desktop.wm.<name>` options** (`modules/linux/desktop.nix`): each compositor (`niri`, `hyprland`) has `enable`, `bar` (`niribar`/`mechabar`/`none`; defaults to `niribar` for niri, `mechabar` for hyprland) and `additionalSettings`. They are set per-host from the flake's `wm` field, which is passed through verbatim as `desktop.wm`:
```nix
wm = {
  niri = {
    enable = true;
    bar = "niribar";
    additionalSettings = [];
  };
};
```
An assertion requires exactly one `desktop.wm.<name>.enable` per Linux host. This is the switch that both NixOS modules (`programs.niri.enable = config.desktop.wm.niri.enable` in `hosts/linux/configuration.nix`) and home-manager modules key off of. New WM-specific home-manager config goes in its own directory and is pulled in conditionally, e.g. `home/linux/wayland/default.nix`:
```nix
lib.optional desktop.wm.hyprland.enable ./hypr
++ lib.optional desktop.wm.niri.enable ./niri
```
Follow this pattern (directory + `lib.optional desktop.wm.<name>.enable ./dir`) for anything that should only load under one compositor — that's how the fuzzel/niri and wofi/hyprland splits work. The waybar flavor (`./waybar/niribar` / `./waybar/mechabar`) is picked from the `bar` of whichever compositor is enabled.

`additionalSettings` is a list of attrsets merged (`lib.mkMerge`) on top of the shared compositor settings — `programs.niri.settings` in `home/linux/wayland/niri/niri.nix`, `wayland.windowManager.hyprland.settings` in `home/linux/wayland/hypr/default.nix`. Lists such as `spawn-at-startup` concatenate rather than replace. Put host-specific compositor config there — including monitor layout (niri `outputs`, hyprland `monitor`) and workspace pinning — instead of branching on the hostname inside the shared module.

**Directory tree, by layer**:
- `hosts/{linux,darwin}/` — per-OS entrypoint: `configuration.nix` (NixOS/nix-darwin system config, hardware-configuration.nix, boot/secure-boot/greetd) and `home.nix` (home-manager root for that OS, sets `home.username`/`homeDirectory`/`stateVersion`).
- `modules/{linux,shared,darwin}/` — system-level NixOS/nix-darwin modules (packages, security, fonts, desktop option definitions).
- `systems/{linux,shared,darwin}/` — lower-level system concerns split further by topic (`hardware/`, `security/`, `container/`, `customization/`, `system/`, darwin `services/`). Each subdirectory is a module via its own `default.nix`.
- `home/{linux,shared,darwin}/` — home-manager modules (dotfiles-equivalent config: wayland compositors, dev tooling, apps). Mirrors the same linux/shared/darwin split as `modules/` and `systems/`.

Every directory is wired in via a `default.nix` that just lists `imports`; there's no auto-globbing, so a new module file must be added to the nearest `default.nix` imports list or it won't be evaluated.

**Two nixpkgs channels**: `nixpkgs` (unstable, default for `pkgs`) and `stablepkgs` (`nixos-25.11`, imported once per system as `stable` and threaded through `specialArgs`/`extraSpecialArgs`). Reach for `stable.<pkg>` instead of `pkgs.<pkg>` when unstable has a broken/regressed package (see commit `7985a30`, which pulled `nvim` from stable to dodge a treesitter error) — don't downgrade the whole channel for one package.

**specialArgs asymmetry**: NixOS modules get a trimmed `meta` (`hostname`, `system`, `isLaptop` — no `wm`). Home-manager's `extraSpecialArgs` instead sets `meta = host` (the *full* flake host entry, including `wm`) and separately passes `desktop = config.desktop` (the resolved option, post-`mkOption` defaults). When a home-manager module needs the compositor/bar choice or `additionalSettings`, use `desktop.wm.<name>`, not `meta.wm.<name>` — the latter is the raw host entry, so any field the host omits (e.g. `bar`) is missing instead of defaulted.

**`nixpkgs.nix`**: a legacy (non-flake) nixpkgs import pinned to the flake.lock revision, used by `shell.nix` for `nix-shell` situations where flakes aren't wanted.
