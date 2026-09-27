#!/usr/bin/env python3
"""Exploit skeleton.

    python solve.py            local process
    python solve.py GDB        local process under gdb
    python solve.py REMOTE     connect to HOST:PORT
"""

from pwn import ELF, args, context, gdb, log, process, remote

BINARY = "./chal"
HOST, PORT = "localhost", 1337

exe = context.binary = ELF(BINARY, checksec=False)
context.terminal = ["tmux", "split-window", "-h"]

GDBSCRIPT = """
b *main
continue
"""


def start():
    if args.REMOTE:
        return remote(HOST, PORT)
    if args.GDB:
        return gdb.debug([exe.path], gdbscript=GDBSCRIPT)
    return process([exe.path])


io = start()

log.info("%s", exe.checksec())

io.interactive()
