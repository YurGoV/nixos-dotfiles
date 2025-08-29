# configuration-wsl.nix
{ pkgs, ... }:

{
  # Вмикаємо інтеграцію з WSL
  wsl = {
    enable = true;
    defaultUser = "yurgo";
  };

  # Вказуємо, що тут не потрібен завантажувач
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = false;

  ## Тест, щоб webstorm на вінді не сварився (?чи працює?)
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
  };

  # Базові налаштування, які можна зробити спільними
  time.timeZone = "Europe/Kyiv";
  i18n.defaultLocale = "en_US.UTF-8";

  # Створюємо користувача
  users.users.yurgo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Додайте групи, які вам потрібні
  };
  
  # Дозволяємо безпарольний sudo
  ##security.sudo.wheel.nopasswd = true;
  security.sudo.wheelNeedsPassword = false;

  # Docker
  virtualisation.docker.enable = true;

  # Встановлюємо zsh як стандартний shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  home-manager.users.yurgo = import ./home-manager/home-wsl.nix;

  # Версія системи
  system.stateVersion = "24.05";
}
