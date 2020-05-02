function jenv
    set cmd $argv[1]
    set arg ""
    if test (count $argv) -gt 1
        set arg $argv[2..-1]
    end

    switch "$cmd"
        case enable-plugin rehash shell shell-options
            eval (jenv "sh-$cmd" "$arg")
        case '*'
            command jenv $cmd $arg
    end
end