{pkgs, ...}: {
  environment.systemPackages = with pkgs; [  
    openssl_3 
  ];
}
