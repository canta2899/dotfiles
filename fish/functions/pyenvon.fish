function pyenvon
    if test (count $argv) -eq 1
        set current_path "$argv[1]/bin/activate.fish"
        if test -f "$current_path"
            source "$current_path"
            echo (set_color green)"Python env activated. Use 'pyenvoff' to deactivate."(set_color normal)
        else
            echo (set_color red)"An error occurred. Does $current_path exist?"(set_color normal)
        end
    else
        echo (set_color yellow)"Please provide a valid path. Ex: pyenvon /my/path"(set_color normal)
    end
end

