# The purpose of including this function is to support jenv
function export --description 'POSIX shim for the export command'
    set arr (echo $argv|tr = \n)
    set -gx $arr[1] $arr[2]
end