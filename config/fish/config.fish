if status is-interactive

    # Auto-start tmux — each terminal gets its own session
    # Clean up detached sessions from closed terminals
    if command -q tmux; and not set -q TMUX
        for sess in (tmux list-sessions -F '#{session_name}:#{session_attached}' 2>/dev/null | string match -r '^(.+):0$' | string replace -r ':0$' '')
            tmux kill-session -t $sess
        end
        tmux new-session
    end

    # No greeting
    set fish_greeting

    # PATH additions
    fish_add_path $HOME/.cargo/bin
    fish_add_path $HOME/.local/bin

    # Bioluminescent Rose theme colors
    set -g fish_color_normal e0def4           # default text (lavender-white)
    set -g fish_color_command ff8fb1 --bold   # commands (vivid pink)
    set -g fish_color_keyword f6c177 --bold   # keywords (gold)
    set -g fish_color_error eb6f92 --bold     # errors (love)
    set -g fish_color_param e0def4            # parameters (lavender)
    set -g fish_color_option c4a7e7           # options (iris)
    set -g fish_color_quote ffcfdf            # strings (pastel rose)
    set -g fish_color_redirection 9ccfd8      # redirections (foam)
    set -g fish_color_end 6e6a86             # end punctuation (muted)
    set -g fish_color_escape ff8fb1           # escape chars (vivid pink)
    set -g fish_color_operator 9ccfd8         # operators (foam)
    set -g fish_color_comment 6e6a86          # comments (muted)
    set -g fish_color_autosuggestion 6e6a86   # autosuggestions (muted)
    set -g fish_color_selection --background=403d52
    set -g fish_color_search_match --background=403d52
    set -g fish_color_valid_path 31748f --underline  # valid paths (pine)
    set -g fish_pager_color_prefix ff8fb1 --bold     # completion prefix (vivid pink)
    set -g fish_pager_color_completion e0def4         # completions (text)
    set -g fish_pager_color_description 6e6a86        # completion descriptions
    set -g fish_pager_color_selected_background --background=403d52

    # Use starship
    starship init fish | source

    # Aliases
    alias clear "printf '\033[2J\033[3J\033[1;1H'" # fix: kitty doesn't clear properly
    alias celar "printf '\033[2J\033[3J\033[1;1H'"
    alias claer "printf '\033[2J\033[3J\033[1;1H'"
    alias ls 'eza --icons'
    alias pamcan 'sudo dnf'
    alias q 'qs -c ii'
end
