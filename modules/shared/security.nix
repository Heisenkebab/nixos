{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # tools
    git-cliff
    gnupg

    nmap
    wireshark
    ghidra
    mitmproxy
  ];
}
