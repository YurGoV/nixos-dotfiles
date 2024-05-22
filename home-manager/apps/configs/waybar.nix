{ config, pkgs, lib, ... }:

      # ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      ${builtins.readFile "/home/yurgo/.dotfiles/home-manager/apps/configs/waybar-style.css"}

      window#waybar {
        background: transparent;
        border-bottom: none;
      }
    '';
    settings = [{
      height = 30;
      layer = "top";
      position = "bottom";
      tray = { spacing = 10; };
      modules-center = [ "sway/window" "hyprland/workspaces" ];
      modules-left = [ "sway/workspaces" "sway/mode" "custom/power" ];
      modules-right = [
        "pulseaudio"
        "bluetooth"
        "network"
        "cpu"
        "memory"
        "temperature"
        "battery"
        "clock"
        "tray"
      # ] ++ (if config.hostId == "yoga" then [ "battery" ] else [ ])
      # ++ [
      #   "clock"
      #   "tray"
      ];
      "custom/power" = {
        format = " ⏻ ";
        tooltip = false;
        on-click = "wlogout --protocol layer-shell";
      };
      "hyprland/workspaces" = {
        format = "{icon}";
        on-click = "activate";
        all-outputs = true;
        format-icons = {
          urgent = " ";
          active = " ";
          default = " ";
        };
      };
      battery = {
        format = "{capacity}% {icon}";
        format-alt = "{time} {icon}";
        format-charging = "{capacity}% ⚡";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = "{capacity}% ";
        states = {
          critical = 15;
          warning = 30;
        };
      };
      clock = {
        format-alt = "{:%Y-%m-%d}";
        tooltip-format = "{:%Y-%m-%d | %H:%M}";
      };
      cpu = {
        format = "{usage}% ";
        tooltip = false;
      };
      memory = { format = "{}% "; };
      network = {
        interval = 3;
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        format-disconnected = "Disconnected ⚠";
        format-ethernet = "{ifname}: {ipaddr}/{cidr} ⊡  up: {bandwidthUpBits} down: {bandwidthDownBits}";
        format-linked = "{ifname} (No IP) noIp";
        format-wifi = "{essid} ({signalStrength}%) ";
        on-click = "nm-applet";
      };
      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon}  {format_source}";
        format-bluetooth-muted = " {icon}  {format_source}";
        format-icons = {
          car = "";
          default = [ "" "" "" ];
          handsfree = "";
          headphones = "";
          headset = "";
          phone = "";
          portable = "";
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        on-click = "pavucontrol";
      };
      bluetooth = {
      	format = " {status}";
       	format-disabled = "";
       	format-connected = " {num_connections} connected";
       	tooltip-format = "{controller_alias}\t{controller_address}";
       	tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
       	tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        on-click = "blueman-manager";
      };
      "sway/mode" = { format = ''<span style="italic">{}</span>''; };
      temperature = {
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [ "" "" "" ];
      };
    }];
  };
}
