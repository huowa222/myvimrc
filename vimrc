set number
set nocompatible
set cursorline
set ruler
set shiftwidth=2
set softtabstop=2
set tabstop=2
set ts=2
set autochdir
set tags=tags;
set autoread;
set autowriteall;
set ignorecase smartcase
set nowrapscan
set incsearch
set hlsearch
set magic
set hidden
set smartindent
set backspace=indent,eol,start
set expandtab
set autoindent
set autoread
set mouse=r #mouse copy and paste
"防止 tab 制表符
autocmd FileType c,cpp set shiftwidth=2 | set expandtab

"防止linux终端下无法拷贝
#set mouse=nicr
#au GUIEnter * simalt ~x
#if(g:iswindows==1) "允许鼠标的使用
#endif

filetype plugin on
filetype plugin indent on

# tags=/Users/liaozhenliang/workspace/quic-client-sdk/:/Users/liaozhenliang/workspace/ats/trafficserver:/Users/liaozhenliang/workspace/openssl-1.1.1c
tags=/Users/liaozhenliang/workspace_docker/web_server/ats
syntax on

# taglist plugin
let Tlist_Auto_Open = 1
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_WinWidth=28

# nerdtree plugin
autocmd VimEnter * NERDTree
nmap <silent> <c-n> :NERDTreeToggle<CR>

# plugin autorefresh tags files
Plug 'ludovicchabant/vim-gutentags'

# incrementally tag files
function! GenerateTagsIncrementally()
python << EOF
import os
print('Generating tags incrementally.')
# Walk the file tree, if a file has an mtime more recent than the tag file,
# add it to the list of files to index.
tags_mtime = os.stat('tags').st_mtime
with open('list', 'w') as fp:
    for dirpath, dirnames, filenames in os.walk(os.getcwd()):
        for filename in filenames:
            full_path = os.path.join(dirpath, filename)
            if os.stat(full_path).st_mtime > tags_mtime:
                fp.write(full_path + '\n')
                # print(full_path) # Files to be indexed.

# Run ctags using the created list of files.
os.system('ctags --recurse --verbose --append --extra=+q --fields=+aimS --c-kinds=+p --c++-kinds=+p -L list')
os.remove('list')
EOF
endfunction
command GenerateTagsIncrementally call GenerateTagsIncrementally()

# 快捷键. 
:map! <C-\> <ESC>:wq<CR>
nnoremap ,s yiw:vimgrep /<C-R>0/ %<CR>:copen<CR>

nmap <C-S> :update!<CR>
vmap <C-S> <C-C>:update!<CR>
imap <C-S> <C-O>:update!<CR>

#nnoremap <C-S> :w<enter>
#inoremap <C-S> <C-O>:w<enter>
