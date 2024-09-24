# waybar.nix
{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      ${builtins.readFile "/home/yurgo/.dotfiles/home-manager/apps/configs/waybar/waybar-style.css"}

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
        "temperature"
        "custom/fan"
        "memory"
        "battery"
        "clock"
        "tray"
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
      temperature = {
        # hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input"; #GPU
        # // TODO: change to sensord
        hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
        critical-threshold = 80;
        # format = "{temperatureC}°C {icon}";
        format = "{temperatureC}°C";
        # format-icons = [ "" "" "" ];
      };
       # Custom fan module configuration
      "custom/fan" = {  # <--- NEW SECTION
        format = "{}";  # Customize the format as needed
        exec = "~/.dotfiles/scripts/hw/get-fan-speed.sh";  # <--- CHANGE THIS TO YOUR SCRIPT PATH
        interval = 5;  # Update every 5 seconds
        tooltip = false;
        return-type = "json";
      };  # <--- END OF NEW SECTION
      memory = { format = "{}% "; };
      network = {
        interval = 3;
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        format-disconnected = "Disconnected ⚠";
        # format-ethernet = "{ifname}: {ipaddr}/{cidr} ⊡  up: {bandwidthUpBits} down: {bandwidthDownBits}";
        format-ethernet = "⊡  up: {bandwidthUpBits} down: {bandwidthDownBits}";
        format-linked = "{ifname} (No IP) noIp";
        format-wifi = "{essid} ({signalStrength}%) ";
        on-click = "nm-applet";
      };
      pulseaudio = {
        format = "{volume}% {icon}   {format_source}";
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
    }];
  };
}
