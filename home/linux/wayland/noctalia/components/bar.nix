_: {
  order = ["main"];

  default = {
    position = "top";
    enabled = true;

    auto_hide = false;
    smart_auto_hide = false;
    show_on_workspace_switch = true;
    reserve_space = true;
    layer = "top";

    thickness = 34;
    background_opacity = 1.0;
    border = "outline";
    border_width = 0.0;
    shadow = true;
    contact_shadow = false;
    panel_overlap = 1;
    radius = 12;
    radius_top_left = 12;
    radius_top_right = 12;
    radius_bottom_left = 12;
    radius_bottom_right = 12;
    concave_edge_corners = true;
    margin_ends = 100;
    margin_edge = 0;
    margin_opposite_edge = 0;
    padding = 14;
    widget_spacing = 6;
    hover_highlight = true;
    scale = 1.0;
    font_scale = 1.0;
    font_weight = 500;
    font_family = "";

    capsule = false;
    capsule_fill = "surface_variant";
    capsule_thickness = 0.76;
    capsule_radius = 8.0;
    capsule_opacity = 1.0;

    start = [
      # "launcher"
      "wallpaper"
      "workspaces"
    ];

    center = [
      "clock"
    ];

    end = [
      # "media"
      "tray"
      "notifications"
      # "clipboard"
      "network"
      "bluetooth"
      "volume"
      "brightness"
      "battery"
      # "control-center"
      "session"
    ];
  };
}
