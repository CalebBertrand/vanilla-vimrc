set number
set relativenumber
set guicursor=n-v-c-i:block

set ai

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

function HookFile()
    let register = input("Hook file into register: ")
    execute "let @" . register . " = \"" . expand("%") . "\""
endfunction
noremap <leader>j :call HookFile()<CR>

function GotoHook()
    let register = input("Goto hook: ")
    execute "edit " . getreg(register)
endfunction
noremap <leader>h :call GotoHook()<CR>

function OpenFileUnderCursor()
    let path = expand('<cfile>')
    let isTsFile = matchend(expand('%'), '.ts') >= 0
    if !empty(path)
        let projectRoot = substitute(trim(system('npm root')), '\/node_modules', '', 'g')
        let expandedPath = substitute(path, '[~]', projectRoot, 'g')
        if isTsFile
            let expandedPath = expandedPath . '.ts'
        endif

        execute 'edit ' . expandedPath
    endif
endfunction
noremap gf :call OpenFileUnderCursor()<CR>

colorscheme peachpuff
