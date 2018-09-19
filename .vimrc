set nocompatible " be iMproved, required
filetype off " required
filetype plugin on
syntax on
set backspace=2
set background=dark
colorscheme jb

" Search
set hlsearch
set incsearch " Highlight dynamically as pattern is typed
set ignorecase
set smartcase
set noshowmode " Don't show the current mode (airline.vim takes care of us)

set mouse=a

let mapleader=" "

" Local directories
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo

" Number
set number
nmap <Leader>n :set nonumber!<CR>

nmap <Leader>m :set mouse=v<CR>
nmap <Leader>M :set mouse=a<CR>
nmap <Leader>p :set paste!<CR>
nmap <Leader>ss :source ~/.vimrc<CR>
nmap <Leader>c :NERDTreeToggle<CR>:set nonumber!<CR>:set mouse=v<CR>:SyntasticToggleMode<CR>

set laststatus=2

" Map
nnoremap Y y$
vnoremap <C-c> "*y

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
map <Space><Left> :bp<CR>
nmap <Space><Left> :bp<CR>
map <Space><Right> :bn<CR>
nmap <Space><Right> :bn<CR>
nnoremap <Leader>q :bp\|bd #<CR>


" Split nav
nmap <silent> <M-up> <C-W>k
nmap <silent> <M-down> <C-W>j
nmap <silent> <Esc>[1;9D <C-W>h
nmap <silent> <M-right> <C-W>l

"noremap <C-l> :!php -l %<CR>
"noremap <C-x> :!git add %<CR>

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


" PHPQA.vim {{{
augroup phpqa_config
    autocmd!
let g:phpqa_codecoverage_file = "./build/cov/clover.xml"
" Show markers for lines that ARE covered by tests (default = 1)
let g:phpqa_codecoverage_showcovered = 0
augroup END
" }}}

" Syntastic.vim {{{
augroup syntastic_config
    autocmd!
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '⚠'
    "PHP
    let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
    let g:syntastic_php_phpcs_args = '--standard=$HOME/code/dotfiles/phpcs.ruleset.xml'
    " Other Lang
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
    nmap <Leader>s :SyntasticToggleMode<CR>
    noremap <Leader>z <C-w><Down><CR> " next syn error
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

" EasyAlign.vim {{{
augroup easy_align_config
    autocmd!
    vmap <Leader>a <Plug>(EasyAlign)
    nmap <Leader>a <Plug>(EasyAlign)
augroup END
" }}}

" RainbowParenthesis.vim {{{
augroup rainbow_parenthesis_config
    autocmd!
    nnoremap <leader>rp :RainbowParenthesesToggle<CR>
augroup END
" }}}


augroup jsdoc_config
    autocmd!
    let g:jsdoc_allow_input_prompt=1
    let g:jsdoc_input_description=1
    let g:jsdoc_enable_es6=1
    nmap <silent> <C-l> <Plug>(jsdoc)
augroup END

augroup phpdoc_config
    autocmd!
    let g:pdv_template_dir = $HOME ."/.vim/plugged/pdv/templates_snip"
    nnoremap <buffer> <Leader>d :call pdv#DocumentWithSnip()<CR>
augroup END


augroup nerdtree_config
    autocmd!
    autocmd VimEnter * NERDTree
    autocmd VimEnter * wincmd p
    map <Leader>nt :NERDTreeToggle<CR>
augroup END

augroup fzf_config
    autocmd!
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }
    map <leader>p :FZF<CR>
augroup END

autocmd BufNewFile,BufRead *.sql  set filetype=mysql


" Load plugins
call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/vim-easy-align'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-surround'
Plug 'heavenshell/vim-jsdoc'

"Php doc + deps
Plug 'SirVer/ultisnips'
Plug 'tobyS/pdv'
Plug 'tobyS/vmustache'

"Syntax
Plug 'mxw/vim-jsx'
Plug 'derekwyatt/vim-scala'
Plug 'etaoins/vim-volt-syntax'
Plug 'keith/swift.vim'
Plug 'vim-scripts/groovy.vim'
Plug 'vim-scripts/groovyindent-unix'
Plug 'puppetlabs/puppet-syntax-vim'
Plug 'leafgarland/typescript-vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'python-mode/python-mode'

Plug 'terryma/vim-multiple-cursors'

" IDE
Plug 'flazz/vim-colorschemes'
Plug 'majutsushi/tagbar'
Plug 'Townk/vim-autoclose'
Plug '~/code/vim-projects-ctags'
"Plug 'jrmbrgs/vim-projects-ctags'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/code/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'joonty/vim-phpqa'


call plug#end()

let g:projectNameList = ['slingshot', 'turbo', 'booking_responsive', 'frontvpg', 'bg_builder', 'disturb']
let g:tagFile = '.tags'
let g:ctagsLang = {
    \   'php' : 'ctags -R --languages=PHP --file-scope=no --exclude=.git --recurse=yes --totals=yes --PHP-kinds=+cf',
\}
"          'php' : 'ctags -R --languages=PHP --file-scope=no --exclude=.git --recurse=yes --exclude=vendor --totals=yes --PHP-kinds=+ncf',
map <Leader>pt :call projectsCtags#GenCtags()<cr>
map <Leader>pp :echo projectsCtags#GetProjectAbsolutePath()<cr>
map <leader>g <C-]>
