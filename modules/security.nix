{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # tools
    git-cliff
    gnupg

    nmap
    burpsuite
    wireshark
    ghidra
  ];
}
