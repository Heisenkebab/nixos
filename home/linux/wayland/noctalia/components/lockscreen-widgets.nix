{
  user,
  bounds,
  primaryMon,
}: {
  enabled = true;
  widget_order = ["main-panel" "sticker-main" "user-greeting" "date-main" "clock-main" "login-box"];

  widget = {
    "main-panel" = {
      type = "label";
      output = primaryMon.name;

      box_width = 850.0;
      box_height = 140.0;

      cx = bounds.width / 2;
      cy = bounds.height * 0.28;

      settings = {
        title = "";
        description = "";
        color = "surface";
        background_color = "surface";
        background_opacity = 0.95;
        background_radius = 24.0;
        background = true;
        shadow = true;
      };
    };

    "sticker-main" = {
      type = "sticker";
      output = primaryMon.name;

      box_width = 80.0;
      box_height = 80.0;

      cx = (bounds.width / 2) - 340.0;
      cy = bounds.height * 0.28;

      settings = {
        image_path = "${../assets/noctalia-logo.svg}";
        opacity = 1.0;
        background = false;
      };
    };

    "user-greeting" = {
      type = "label";
      output = primaryMon.name;

      box_width = 300.0;
      box_height = 40.0;

      cx = (bounds.width / 2) - 80.0;
      cy = (bounds.height * 0.28) - 22.0;

      settings = {
        title = "Welcome ${user.name}";
        description = "";
        color = "on_surface";
        opacity = 1.0;
        shadow = false;
        background = false;
      };
    };

    "date-main" = {
      type = "clock";
      output = primaryMon.name;

      box_width = 300.0;
      box_height = 40.0;

      cx = (bounds.width / 2) - 80.0;
      cy = (bounds.height * 0.28) + 22.0;

      settings = {
        clock_style = "digital";
        format = "{:%A, %d. %B}";
        color = "on_surface_variant";
        shadow = false;
        background = false;
        center_text = true;
      };
    };

    "clock-main" = {
      type = "clock";
      output = primaryMon.name;

      box_width = 200.0;
      box_height = 80.0;

      cx = (bounds.width / 2) + 260.0;
      cy = bounds.height * 0.28;

      settings = {
        clock_style = "digital";
        format = "{:%H:%M}";
        color = "on_surface";
        shadow = false;
        background = false;
        center_text = true;
      };
    };

    "login-box" = rec {
      type = "login_box";
      output = primaryMon.name;

      box_width = 750.0;
      box_height = 140.0;

      cx = bounds.width / 2;
      cy = bounds.height - (box_height / 2) - 100.0;

      settings = {
        background_color = "surface";
        background_opacity = 0.95;
        background_radius = 20.0;

        center_password_text = false;
        input_opacity = 1.0;
        input_radius = 12.0;

        layout = "regular";
        show_login_button = true;
        show_session_buttons = true;

        show_keyboard_layout = false;
        show_unlock_hint = false;
        show_caps_lock = false;
        show_weather = false;
        show_media = false;
      };
    };
  };
}
