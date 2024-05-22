{ config, lib, pkgs, ... }:
{
  programs.wlogout = {
    enable = true;
    package = pkgs.wlogout;
  };
  programs.wlogout.layout = [
    {
      "label" = "lock";
      "action" = "swaylock";
      "text" = "Lock";
      "keybind" = "l";
    }
    {
      "label" = "hibernate";
      "action" = "systemctl hibernate";
      "text" = "Hibernate";
      "keybind" = "h";
    }
    {
      "label" = "logout";
      "action" = "hyprctl dispatch exit";
      "text" = "Logout";
      "keybind" = "e";
    }
    {
      "label" = "shutdown";
      "action" = "systemctl poweroff";
      "text" = "shutdown";
      "keybind" = "s";
    }
    {
      "label" = "suspend";
      "action" = "systemctl suspend";
      "text" = "Suspend";
      "keybind" = "u";
    }
    {
      "label" = "reboot";
      "action" = "systemctl reboot";
      "text" = "Reboot";
      "keybind" = "r";
    }
  ];
}
# TODO: fix error (can see if start waybar manually by terminal):
# (wlogout:42506): Gtk-CRITICAL **: 10:37:15.959: gtk_label_set_xalign: assertion 'GTK_IS_LABEL (label)' failed
