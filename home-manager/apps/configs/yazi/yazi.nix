{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      # 👇 "manager" змінено на "mgr"
      mgr = {
        # Layout
        # ratio = [1 2 5];
        show_hidden = true;
        show_symlink = true;
        # Sorting
        # 👇 "modified" змінено на "mtime"
        sort_by = "mtime";
        sort_dir_first = true;
        sort_reverse = true;
      };
      # preview = {
      #   ... (ваші налаштування preview залишаються тут, якщо вони вам потрібні)
      # };
    };
    # Keybindings, nothing for now
    keymap = {};
  };
}
