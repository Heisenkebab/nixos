# The CTF shell itself. Imported both by this directory's flake.nix (when the
# template is copied into a challenge) and by the nixos flake, which serves it
# as `devShells.<system>.ctf` -- so there is one list to maintain, not two.
# `stable` is nixos-25.11: use `stable.<pkg>` when the unstable build is broken.
{
  pkgs,
  stable,
}: let
  inherit (pkgs) lib;
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;

  # Interpreter behind ./solve.py. Add libraries here instead of pip.
  python = pkgs.python313.withPackages (ps:
    with ps; [
      pwntools
      pycryptodome
      z3-solver
      sympy
      gmpy2
      pyelftools
      capstone
      unicorn
      keystone-engine
      ropper
      ropgadget
      r2pipe
      requests
      scapy
      pillow
      python-magic
      numpy
      # angr # symbolic execution, very large closure
    ]);

  # No gcc/clang here: mkShell's stdenv already supplies a compiler,
  # and a second one shadows the native toolchain on darwin.
  pwn = with pkgs;
    [
      one_gadget
      patchelf
      qemu
    ]
    # gdb cannot attach on darwin without a signed certificate and a
    # task_for_pid entitlement, and cannot run Linux ELFs at all; gef is a gdb
    # plugin, and pwninit/checksec pull in elfutils.
    ++ lib.optionals isLinux [
      gdb
      gef
      pwninit
      checksec
      stable.ltrace
      strace
    ]
    # the native debugger for Mach-O targets
    ++ lib.optionals isDarwin [lldb];

  rev = with pkgs; [
    radare2
    binutils
    file
    upx
    jadx
    apktool
    # ghidra # pulls a JDK, ~1G closure
    # cutter
  ];

  crypto = with pkgs; [
    openssl
    z3
    # sage # heavy, but the only real answer to lattice/ECC tasks
  ];

  web = with pkgs; [
    curl
    ffuf
    gobuster
    sqlmap
    nmap
    socat
    netcat-gnu
    # burpsuite
  ];

  forensics = with pkgs;
    [
      binwalk
      foremost
      zsteg
      exiftool
      sleuthkit
      testdisk
      pngcheck
      volatility3
      yara
      tcpdump
      wireshark-cli
    ]
    # steghide vendors an ancient gettext whose K&R declarations modern clang
    # rejects, so it only builds on Linux.
    ++ lib.optionals isLinux [steghide];

  cracking = with pkgs; [
    john
    hashcat
    hashcat-utils
    hashid
    # wordlists # rockyou and friends, multi-GB
    # seclists
  ];

  misc = with pkgs; [
    xxd
    hexyl
    jq
    ripgrep
    gnumake
  ];
in
  pkgs.mkShell {
    name = "ctf";

    packages =
      [python]
      ++ pwn
      ++ rev
      ++ crypto
      ++ web
      ++ forensics
      ++ cracking
      ++ misc;

    # Keep this cheap: direnv re-runs it on every cd into the challenge.
    shellHook = ''
      echo "ctf: pwn rev crypto web forensics"
    '';
  }
