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
        # preview = {
        #   docx = {
        #     command = "pandoc -s -t markdown -- {} | glow"; 
        #     mime = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
        #   };
        # };
        #  preview = {
        #     docx = {
        #         command = "pandoc -t plain {} | less -R";
        #         mime = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
        #         # command = "pandoc -t plain {}";
        #         # mime = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
        #     };
        # };
    };
    # Keybindings, nothing for now
    keymap = {};
  };
}
