_: {
  home.file.".config/neofetch/config.conf" = {
    text = ''
      print_info() {
         prin "《·───────────────·》◈《·──────────────·》"
         info "\n \n OS" distro
         info "\n \n Kernel" kernel
         info "\n \n DE" de
         info "\n \n WM" wm
         info "\n \n Shell" shell
         info "\n \n CPU" cpu
         info "\n \n GPU" gpu
         info "\n \n Memory" memory
         prin "《·───────────────·》◈《·───────────────·》"
      }
      title_fqdn="off"

      kernel_shorthand="on"

      distro_shorthand="off"

      os_arch="on"

      uptime_shorthand="on"

      memory_percent="off"

      memory_unit="mib"

      package_managers="on"

      shell_path="off"

      shell_version="on"

      speed_type="bios_limit"

      speed_shorthand="off"

      cpu_brand="on"

      cpu_speed="on"

      cpu_cores="logical"

      cpu_temp="off"

      gpu_brand="on"

      gpu_type="all"

      refresh_rate="off"

      gtk_shorthand="off"

      gtk2="on"

      gtk3="on"

      public_ip_host="http://ident.me"

      public_ip_timeout=2

      local_ip_interface=('auto')

      de_version="on"

      disk_show=('/')

      disk_subtitle="mount"

      disk_percent="on"

      music_player="auto"

      song_format="%artist% - %album% - %title%"

      song_shorthand="off"

      mpc_args=()

      colors=(7 7 7 4 7 7 4 4)

      bold="on"

      underline_enabled="on"

      underline_char="-"


      separator=":"

      block_range=(0 15)

      color_blocks="on"

      block_width=3

      block_height=1

      col_offset="auto"

      bar_char_elapsed="-"
      bar_char_total="="

      bar_border="on"

      bar_length=15

      bar_color_elapsed="distro"
      bar_color_total="distro"

      memory_display="off"
      battery_display="off"
      disk_display="off"

      image_backend="ascii"

      image_source="auto"

      ascii_distro="auto"

      ascii_colors=(distro)

      ascii_bold="on"

      image_loop="off"

      crop_mode="normal"

      crop_offset="center"

      image_size="30%"

      catimg_size="2"

      gap=3

      yoffset=0
      xoffset=0

      background_color=

      stdout="off"
    '';
  };
}
