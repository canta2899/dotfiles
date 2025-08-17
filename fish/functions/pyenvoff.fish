function pyenvoff
    type -q deactivate; and deactivate
    if test $status -eq 0
        echo "Environment deactivated"
        return 0
    else
        echo "No environment activated"
        return 1
    end
end

