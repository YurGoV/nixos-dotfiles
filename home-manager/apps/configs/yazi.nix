{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
        manager = {
            # Layout
            # ratio = [1 2 5];
            show_hidden = true;
            show_symlink = true;
            # Sorting
            sort_by = "modified";
            sort_dir_first = true;
            sort_reverse = true;
        };
    };
  };
}
