set number
set relativenumber
set guicursor=n-v-c-i:block

set encoding=utf-8

set tabstop=4
set softtabstop=4
set expandtab

set scrolloff=8

let mapleader = " "
function OpenExplorer()
    execute "w"
    execute "Ex"
    execute "silent tabonly"
endfunction
noremap <leader>xp :call OpenExplorer()<CR>


function GrepFiles()
    call inputsave()
    let search = input("Grep for: ")
    call inputrestore()
    execute "vimgrep /" . search . "/ ./**/* | copen"
endfunction
noremap <leader>gf :call GrepFiles()<CR>

function GrepGitFiles()
    call inputsave()
    let search = input("Grep git for: ")
    call inputrestore()
    execute "vimgrep /" . search . "/ `git ls-files` | copen"
endfunction
noremap <leader>gg :call GrepGitFiles()<CR>

function GotoFile()
    execute "w"
    call inputsave()
    let search = input("Goto file: ")
    call inputrestore()
    let file = trim(system("git ls-files | grep \"" . search . "\" -m 1"))
    silent execute "open " . file
endfunction
noremap <leader>ff :call GotoFile()<CR>
