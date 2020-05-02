function __pwd_ls --description 'ls when the current working directory changes' --on-variable PWD
    ls $PWD
end