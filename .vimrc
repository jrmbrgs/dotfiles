set nocompatible " be iMproved, required
filetype off " required
filetype plugin on
syntax on
set background=dark
colorscheme darkblue
set number
set hlsearch
set incsearch " Highlight dynamically as pattern is typed
set noshowmode " Don't show the current mode (airline.vim takes care of us)

set mouse=a " Enable mouse in all in all modes

let mapleader=","

" Map
nnoremap Y y$

" Indent
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" Diff
set diffopt=filler " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)


" Tab nav
noremap <C-a>   :<C-U>tabnext<CR>
inoremap <C-a>  <C-\><C-N>:tabnext<CR>
cnoremap <C-a>  <C-C>:tabnext<CR>
noremap <C-z>   :<C-U>tabprevious<CR>
inoremap <C-z>  <C-\><C-N>:tabprevious<CR>
cnoremap <C-z>  <C-C>:tabprevious<CR>

" Split nav
nmap <silent> <M-up> <C-W>k
nmap <silent> <M-down> <C-W>j
nmap <silent> <Esc>[1;9D <C-W>h
nmap <silent> <M-right> <C-W>l

noremap <C-l> :!php -l %<CR>
"noremap <C-x> :!git add %<CR>

" Local directories
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo


" Highlight Interesting Words {{{
augroup highlight_interesting_word
    autocmd!
    " This mini-plugin provides a few mappings for highlighting words temporarily.
    "
    " Sometimes you're looking at a hairy piece of code and would like a certain
    " word or two to stand out temporarily.  You can search for it, but that only
    " gives you one color of highlighting.  Now you can use <leader>N where N is
    " a number from 1-6 to highlight the current word in a specific color.
    function! HiInterestingWord(n) " {{{
        " Save our location.
        normal! mz

        " Yank the current word into the z register.
        normal! "zyiw

        " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
        let mid = 86750 + a:n

        " Clear existing matches, but don't worry if they don't exist.
        silent! call matchdelete(mid)

        " Construct a literal pattern that has to match at boundaries.
        let pat = '\V\<' .  escape(@z, '\') .  '\>'

        " Actually match the words.
        call matchadd("InterestingWord" . a:n, pat, 1, mid)

        " Move back to our original location.
        normal!  `z
    endfunction
    " }}}

    " Mappings {{{
    nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
    nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
    nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
    nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
    nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
    nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>
    " }}}

    " Default Highlights {{{
    hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
    hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
    hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
    hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
    hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
    hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195
    " }}}
augroup END
" }}}



" Plugins Config

" Airline.vim {{{
augroup airline_config
    autocmd!
    let g:airline_powerline_fonts = 1
    let g:airline_enable_syntastic = 1
    let g:airline#extensions#tabline#buffer_nr_format = '%s '
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#fnamecollapse = 0
    let g:airline#extensions#tabline#fnamemod = ':t'
augroup END
" }}}


" Syntastic.vim {{{
augroup syntastic_config
    autocmd!
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '⚠'
    let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
    let g:syntastic_javascript_checkers = ['eslint']
    let g:syntastic_sql_checkers = ['sqlint']
    "let g:syntastic_Handlebars_checkers = ['handlebars']

    let g:syntastic_mode_map = { 'mode': 'active',
                            \ 'active_filetypes': ['javascript', 'sql'],
                            \ 'passive_filetypes': [] }
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
augroup END
" }}}

" NERD Commenter {{{
augroup nerd_commenter
    autocmd!
    let NERDSpaceDelims=1
    let NERDCompactSexyComs=1
    let g:NERDCustomDelimiters = { 'racket': { 'left': ';', 'leftAlt': '#|', 'rightAlt': '|#' } }
augroup END
" }}}

" Load plugins
call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdcommenter'

call plug#end()
