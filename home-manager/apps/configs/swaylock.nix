{ pkgs, ... }:
# TODO: make styles
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      fade-in = 1;
      effect-pixelate = 2;
      effect-greyscale = true;
      # efect-blur = "40x12";

      show-failed-attempts = true;
      daemonize = true;
      image = "~/.dotfiles/assets/wallpapers/michael-d-rnKqWvO80Y4-unsplash-1080.jpg";
      scaling = "fill";
      font = "FiraCode";
      color = "282a36";
      inside-color = "1F202A";
      line-color = "1F202A";
      ring-color = "bd93f9";
      text-color = "f8f8f2";

      layout-bg-color = "1F202A";
      layout-text-color = "f8f8f2";

      inside-clear-color = "6272a4";
      line-clear-color = "1F202A";
      ring-clear-color = "6272a4";
      text-clear-color = "1F202A";

      inside-ver-color = "bd93f9";
      line-ver-color = "1F202A";
      ring-ver-color = "bd93f9";
      text-ver-color = "1F202A";

      inside-wrong-color = "ff5555";
      line-wrong-color = "1F202A";
      ring-wrong-color = "ff5555";
      text-wrong-color = "1F202A";

      bs-hl-color = "ff5555";
      key-hl-color = "50fa7b";

      text-caps-lock-color = "f8f8f2";
      indicator-idle-visible = true;
    };
  };
}
