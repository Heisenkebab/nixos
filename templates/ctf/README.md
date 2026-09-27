# CTF challenge

Most challenges need nothing but an `.envrc`, because the shell is served from
the nixos flake:

```sh
mkdir chal-name && cd chal-name
echo 'use flake ~/nixos#ctf' > .envrc
direnv allow
```

One shell, one nixpkgs pin, shared by every challenge. Adding a tool to
`~/nixos/templates/ctf/shell.nix` makes it appear in all of them.

Copy this template instead — `nix flake init -t ~/nixos#ctf` — only when a
challenge needs to diverge: its own pinned nixpkgs (to match a given libc), or
tools you do not want in the shared shell. The copy is self-contained, so you
can hand the whole directory to a teammate.

## Solving

Drop the challenge binary in as `./chal` (or edit `BINARY` in `solve.py`):

```sh
python solve.py          # local
python solve.py GDB      # local, under gdb (needs tmux)
python solve.py REMOTE   # HOST:PORT from solve.py
```

`solve.py` is not installed by the shared shell — grab it with
`cp ~/nixos/templates/ctf/solve.py .` when you want the skeleton.

## What's in the shell

| area | tools |
|---|---|
| pwn | `one_gadget`, `patchelf`, `qemu`, `lldb` (macOS), `gdb`+`gef`/`pwninit`/`checksec`/`ltrace`/`strace` (Linux) |
| rev | `radare2`, `binutils`, `upx`, `jadx`, `apktool` |
| crypto | `openssl`, `z3`, python `pycryptodome`/`sympy`/`gmpy2` |
| web | `ffuf`, `gobuster`, `sqlmap`, `nmap`, `socat`, `nc`, `curl` |
| forensics | `binwalk`, `foremost`, `steghide`, `zsteg`, `exiftool`, `sleuthkit`, `volatility3`, `yara`, `tshark` |
| cracking | `john`, `hashcat`, `hashid` |
| python | `pwntools`, `ropper`, `ROPgadget`, `pyelftools`, `capstone`, `unicorn`, `keystone`, `r2pipe`, `scapy` |

Heavier tools are listed but commented out in `shell.nix` — uncomment what a
challenge actually needs rather than paying for them up front: `ghidra`,
`cutter`, `burpsuite`, `sage`, `angr`, `wordlists`/`seclists`.

## macOS notes

`gdb` is left out of the shell on macOS entirely: it needs a self-signed
certificate and a `task_for_pid` entitlement before it can attach, and it cannot
run Linux ELF binaries at all. `lldb` is installed instead. For pwn challenges
either:

- run the shell inside a Linux VM/container (`nix develop` works the same there), or
- use `qemu-x86_64` for the ELF and debug with `gdb`'s remote target, or
- reach for `lldb` when the target is a native Mach-O.

`gdb`, `gef`, `pwninit`, `checksec`, `ltrace` and `strace` are Linux-only and
are dropped from the shell automatically on darwin. `steghide` too -- it vendors
a gettext that modern clang will not compile.
