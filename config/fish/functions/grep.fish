function grep --wraps grep --description 'Adds color to the grep command'
    set -l param --color=always
    command grep $param $argv
end