set title
set nu
set t_Co=256
set noswapfile
set laststatus=2
set incsearch
set encoding=utf-8
set list
set shiftwidth=4
set smartcase
set smartindent
set smarttab
set tabstop=4
set expandtab
set nowrapscan
set clipboard+=unnamed
set listchars=tab:>\ ,eol:$
set backspace=start,eol,indent
set ambiwidth=double
set nocompatible
set cursorline
set whichwrap=b,s,h,l,<,>,[,],~
set viminfo='20,\"5000

" 折り畳み設定
set foldmethod=marker
set fillchars=vert:\|

" タグ
set tag=/home/h-takeo/dev/dekita/tags
nnoremap <F3> :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>

hi Folded gui=bold term=standout ctermbg=LightGray ctermfg=DarkBlue guibg=Gray30 guifg=Gray80
hi FoldColumn gui=bold term=standout ctermbg=LightGray ctermfg=DarkBlue guibg=Gray guifg=DarkBlue

filetype off

if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

  call dein#begin(expand('~/.vim/dein'))

  let s:toml      = '~/.vim/rc/dein.toml'
  let s:lazy_toml = '~/.vim/rc/dein_lazy.toml'

  if dein#load_cache([expand('<sfile>'), s:toml, s:lazy_toml])
    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})
    call dein#save_cache()
  endif

  call dein#end()

  if dein#check_install()
    call dein#install()
  endif

  filetype plugin indent on
  filetype indent on
  syntax on

  let g:neocomplete_php_locale = 'ja'

  nmap ,y :YRShow<CR>
  nmap ,c :Unite colorscheme -auto-preview<CR>

  syntax enable

  let g:Powerline_symbols = 'compatible'
  let g:Powerline_theme = 'molokai'
  let g:Powerline_colorsheme = 'molokai'

  let g:airline_theme = 'molokai'

  let g:indent_guides_enable_on_vim_startup = 0

  nmap <silent> ,m :OverCommendLine<CR>

  nmap <Space>m <Plug>(quickhl-toggle)
  xmap <Space>m <Plug>(quickhl-toggle)
  nmap <Space>M <Plug>(quickhl-reset)
  xmap <Space>M <Plug>(quickhl-reset)
  nmap <Space>j <Plug>(quickhl-match)

  nmap <silent> ,u :Unite file_mru<CR>

  autocmd VimEnter * NeoComplCacheEnable

  let g:yankring_history_dir = '~/.vim/'

  " FuzzyFinder設定$
  nnoremap <unique> <silent> <space>fb :FufBuffer!<CR>
  nnoremap <unique> <silent> <space>ff :FufFile!<CR>
  nnoremap <unique> <silent> <space>fm :FufMruFile!<CR>
  nnoremap <unique> <silent> <space>fc :FufRenewCache<CR>
  autocmd FileType fuf nmap <C-c> <ESC>
  let g:fuf_patternSeparator = ' '
  let g:fuf_modesDisable = ['mrucmd']
  let g:fuf_mrufile_exclude = '\v\.DS_Store|\.git|\.swp|\.svn'
  let g:fuf_mrufile_maxItem = 100
  let g:fuf_enumeratingLimit = 20
  let g:fuf_file_exclude = '\v\.DS_Store|\.git|\.swp|\.svn'

  let NERDSpaceDelims = 1
  nmap ,, <Plug>NERDCommenterToggle
  vmap ,, <Plug>NERDCommenterToggle

  " phpdoc
  let g:pdv_cfg_Type = "mixed"
  let g:pdv_cfg_Package = ""
  let g:pdv_cfg_Version = "$id$"
  let g:pdv_cfg_Copyright = "2014-2015 leverages.co.ltd"
  inoremap <C-D> <ESC>:call PhpDocSingle()<CR>i
  nnoremap <C-D> :call PhpDocSingle()<CR>
  vnoremap <C-D> :call PhpDocSingle()<CR>

  " folding
  augroup vimrc
      autocmd FileType phpunit EnableFastPHPFolds
  augroup END

  set background=dark
  colorscheme inkpot

  " airsave
  nmap <Leader>s <Plug>(AutoWriteStart)
  nmap <Leader>ss <Plug>(AutoWriteStop)

  " 保存時にスペース削除
  autocmd BufWritePre * call <SID>remove_dust()

  let g:auto_write = 1

  " 遊び
  nmap <silent> <C-c>@ : %s /\(.\)/`\1` /ge<CR>
  nmap <silent> <C-c>s : %s /\s\+$//ge<CR>

  " SQLFormatter
  vmap <silent>sf        <Plug>SQLU_Formatter<CR>
  nmap <silent>scl       <Plug>SQLU_CreateColumnList<CR>
  nmap <silent>scd       <Plug>SQLU_GetColumnDef<CR>
  nmap <silent>scdt      <Plug>SQLU_GetColumnDataType<CR>
  nmap <silent>scp       <Plug>SQLU_CreateProcedure<CR>

  " unite-outline
  let g:unite_split_rule = 'rightbelow'
  noremap <silent> ,u :<C-u>Unite -vertical -winwidth=40 -no-quit outline<CR>

  " unite grep
  nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
  nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
  nnoremap <silent> ,rr :<C-u>UniteResume search-buffer<CR>

  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
  endif

  " src-expl
  let g:SrcExpl_isUpdateTags = 1
  nmap se :SrcExplToggle<CR>
  let g:SrcExpl_pluginList = [
    \ "__Tag_list__",
    \ "_NERD_tree_"
    \ ]
  let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."
  let g:SrcExpl_updateTagsKey = "u"
  let g:SrcExpl_prevDefKey = "p"
  let g:SrcExpl_nextDefKey = "n"

  " vim-tags
  au BufNewFile,BufRead *.php let g:vim_tags_project_tags_command = "ctags --languages=php -n -R --PHP-types=f+c+d -f ~/php.tags `pwd` 2>/dev/null &"
  noremap ,tg :TagsGenerate<CR>

  " quick-run
  noremap <silent> ,qp :QuickRun php<CR>

  " functions
  " カーソルの位置を覚えておいて行末の空白を削除したりタブ→スペースしたり
  function! s:remove_dust()
    let cursor = getpos(".")
    %s /\s\+$//ge
    %s /\t/    /ge
    call setpos(".", cursor)
    unlet cursor
  endfunction

  " easymotion
  map <Leader>f <Plug>(easymotion-bd-f)
  nmap <Leader>f <Plug>(easymotion-overwin-f)
  nmap s <Plug>(easymotion-overwin-f2)
  map <Leader>L <Plug>(easymotion-bd-jk)
  nmap <Leader>L <Plug>(easymotion-overwin-line)
  map <Leader>w <Plug>(easymotion-bd-w)
  nmap <Leader>w <plug>(easymotion-overwin-w)

  " dbext
  let dbext_default_profile=""
  let dbext_default_dbname="kirei_kaigi_takeo"
  let dbext_default_type="PGSQL"
  let dbext_default_user="postgres"
  nmap ,ql :DBExecSQL

  " au BufNewFile,BufRead * set tags=call <SID>get_tag_files()
  " function! s:get_tag_files()
    " let tmpfiles = system("find ~/ -name *.tags | grep -v .git")
    " let files = split(tmpfiles, "\n")
    " echo join(files, ',')
  " endfunction
endif
