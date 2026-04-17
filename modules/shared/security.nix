{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # tools
    git-cliff
    gnupg
    exiftool

    nmap
    wireshark
    ghidra
    mitmproxy
  ];
}
