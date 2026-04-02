{lib, ...}: {
  environment.etc."minirc.dfl".text = lib.mkForce ''
    # use "minicom -s" to change parameters.
    pu port         /dev/ttyUSB0
    pu baudrate     9600

  '';
}
