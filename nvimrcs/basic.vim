"+-----------------------------------------------------------------------+
"¦ Maintainer:     aloha                                                 ¦
"¦                                                                       ¦
"¦ License:        MIT                                                   ¦
"¦                                                                       ¦
"¦ Sections:                                                             ¦
"¦                 -> Some Build-in Settings of Vim                      ¦
"¦                 -> Keys and Mappings                                  ¦
"¦                 -> Color, Highlighting and Font                       ¦
"¦                 -> Search and Replace                                 ¦
"¦                 -> Moving around, Tabs, Windows and Buffers           ¦
"¦                 -> Status Line and CmdLine                            ¦
"¦                 -> Helper functions                                   ¦
"¦                 -> Vim Configuration Files                            ¦
"¦                 -> Misc                                               ¦
"¦                                                                       ¦
"+-----------------------------------------------------------------------+

"#########################################################################
"#####################\ Some Build-in Settings of Vim /###################
"#########################################################################

"============================ 一些不好分类的 =============================
if !has('nvim')
    set nocompatible                " 不向后兼容(always 'nocompatible' in neovim)
    set ttyfast                     " should make scrolling faster(romoved in neovim)
endif
set timeout                         " 设置快捷键输入时间限制
set timeoutlen=200                  " 等待时间(ms)
set nottimeout
set lazyredraw                      " Don't redraw while executing macros (good performance config)
set regexpengine=1                  " use old regexp engine
set noautochdir                     " 使用 <leader>. 手动切换到当前目录
set virtualedit=block               " 在指定模式下，使光标可以在没有文本的地方移动
set number                          " 行首显示数字
set relativenumber                  " 行首显示相对数字
set cursorline                      " 突出显示光标所在行
set textwidth=500                   " 设置行宽
set showmatch                       " 高亮显示配对括号
set matchtime=2                     " 高亮显示配对括号时，当前括号会每 2/10 秒闪烁一次
set mousehide                       " Hide the mouse when typing text
set foldlevel=999                   " 打开文件时不折叠，为了避免随机折叠问题
set history=500                     " 命令/搜索/... 历史
set tags=./.tags                    " 设置tag文件为当前目录下的 .tags 文件，一些插件会用到该选项
set hidden                          " A buffer becomes hidden when it is abandoned
syntax enable                       " 启用语法高亮
set splitbelow                      " sp 会在下方打开分割窗口
set splitright                      " vs 会在右边打开分割窗口
set completeopt=longest,noinsert,menuone,noselect,preview
set noequalalways                   " 防止 vim 关闭窗口时自动调整窗口大小

"================================ 换行相关 ===============================
""设置自动折行时建议设置
set wrap                            " 自动折行
set showbreak=➜\                    " 或者 let &showbreak = '➜ '
set linebreak                       " 只在 breakat 指定的符号处折行
set breakat=" ^i!@*-+;:,./?"        " 见 linebreak
""设置不自动换行并调整光标在边界处的行为: 始终离边界五个字符距离，横向显示每次移动一个字符
" set nowrap sidescroll=1 sidescrolloff=5
" set scrolloff=3                     " 滚动时光标离顶/底段的行数
set list                            " 显示特殊字符
" set listchars=tab:<->,trail:•,extends:>,precedes:<    " 特殊字符显示设置 trail 与　space 冲突   eol:↵,
set listchars=trail:•

"=================== 自动缩进设置(cindent会覆盖前两项) ===================
set autoindent                      " 功能最简单的自动缩进
set smartindent                     " 为C-like语言(及其他语言)设置自动缩进, 设置 cindent 时该选项无效
set cindent                         " more cleverly than the other two and is configurable to different indenting styles.
set indentexpr=                     " 设置为非空时会覆盖 autoindent 和 smartindent

"============================ 用空格取代<tab> ============================
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

"================== 使vim的默认"剪切板"与系统剪切板同步 ==================
"                Vim 需要 +xterm_clipboard(vim --version以查看)
" au VimEnter * set clipboard=unnamedplus
set clipboard=unnamedplus

"===================== 硬盘中的文件被修改时，自动读取 ====================
set autoread
au FocusGained,BufEnter * checktime

"======================== Enable filetype plugins ========================
filetype plugin on
filetype indent on

"=============================== 临时文件 ================================
if has("vms")
    set nobackup                    " do not keep a backup file, use versions instead
    else
        set backupdir=~/.cache/nvim/.temp_dirs/backupdir
        set backup                  " keep a backup file (restore to previous version)
    if has('persistent_undo')       " you can undo even when you close a buffer/VIM
        set undodir=~/.cache/nvim/.temp_dirs/undodir
        set undofile                " keep an undo file (undo changes after closing)
    endif
endif
set noswapfile
" set swapfile
" set updatetime=1000
" set directory=~/.cache/nvim/.temp_dirs/swapdir

"======================= No annoying sound on errors =====================
set noerrorbells
set novisualbell
set tm=500
" Properly disable sound on errors on MacVim
if has("gui_mac")
    autocmd GUIEnter * set vb t_vb=
endif
" Add a bit extra margin to the left
set foldcolumn=1

"============================== 编码和语言 ===============================
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
" let $LANG='zh_CN'
" source $VIMRUNTIME/delmenu.vim
" set langmenu='zh_CN'
" source $VIMRUNTIME/menu.vim

"================ 退格键，可删除缩进、行尾、光标前的字符 =================
""Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l


"#########################################################################
"############################\ Keys and Mappings /########################
"#########################################################################

"============================ 先导键 <leader> ============================
let g:mapleader = "\<space>"

"============== normal模式的中文字符（windows gvim中无效） ===============
nnoremap ： :
nnoremap ； ;
nnoremap 、 /
nnoremap 。 .

"============================== 保存和退出 ===============================
" Fast saving & quitting
nnoremap <silent> <leader>w :w<cr>
nnoremap <silent> <leader>W :wa<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :qa<cr>

" :W sudo saves the file
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

"================== 折叠命令syntax/indent模式 (vim 自带) =================
" zc 折叠
" zC 对所在范围内所有嵌套的折叠点进行折叠
" zo 展开折叠
" zO 对所在范围内所有嵌套的折叠点展开
" [z 到当前打开的折叠的开始处。
" ]z 到当前打开的折叠的末尾处。
" zj 向下移动到达下一个折叠的开始处。关闭的折叠也被计入。
" zk 向上移动到前一折叠的结束处。关闭的折叠也被计入。
" zR 打开全部折叠
" zM 关闭所有折叠
" zd 删除光标所在的折叠
" zE 删除所有折叠

"================================ 窗口操作 ===============================
" 1. <leader>+空格 切换全屏和小屏
"    For GVim on windows.
if has("win32") && has("gui_running")
    nnoremap <leader><space> :call ToggleFullScreen()<cr>
endif

let g:make_full_screen = 1
    if has("win32") && has("gui_running") && g:make_full_screen == 1
    au VimEnter * call FullScreen()
endif

" 2. Bwin/Swin转换屏幕显示内容（也会改变Gvim窗口大小）
" 注意 Bwin 会打开 NERDTree 和 Tagbar
command! Bwin call BigWindow()
command! Swin call SmallWindow()

" 3. 打开终端
""根据窗口宽高比自动在垂直/水平窗口打开终端
""你可以在functions.vim找到该函数并调整参数
nnoremap <leader>ter :call OpenTerminalSmartly()<cr>
""在neovim中进入终端时自动进入终端模式(C-\+C+N退出)
" if has('nvim')
"     autocmd TermOpen * startinsert
" endif
"" Alt+q 返回终端normal模式
tnoremap <M-q> <C-\><C-n>

""4. Browse files
nnoremap <silent><cr> :e .<cr>

"================================ 其他操作 ===============================
nnoremap <leader>H :vert h<space>

inoremap ii <esc>
nnoremap Y y$

noremap ; :


"#########################################################################
"######################\ Color, Highlighting and Font /###################
"#########################################################################

colorscheme molokai                 " 设置颜色主题
if !has('nvim')
    set t_Co=256
endif
set termguicolors " enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"============================== 透明背景 =================================
"      需要终端的支持，terminator/Tilix/konsole/yakuake 支持透明背景
try
   call g:TransparentBg(0)
catch
   echoerr "设置透明背景失败"
endtry

"==================== Set font according to system =======================
""Need to improve.
""Recommand fonts: tonsky/FiraCode, Jetbrains Mono
""If you want to use unicode icons, you need nerd-fonts-fire nerd-fonts-jetbrains-mono and etc.
if has("mac") || has("macunix")
    set gfn=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32") && has("gui_running")
    "set gfn=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
    " set the X11 font to use
    " set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1
    "set guifont=Bitstream_Vera_Sans_Mono:h15:cANSI
    set guifont=JetBrains_Mono:h12:cANSI:qDRAFT
    "set gfw=幼圆:h12:w6.5:b:cGB2312
    set gfw=黑体:h13:cGB2312
elseif has("gui_gtk2")
    set guifont=JetBrains_Mono:h12:cANSI:qDRAFT
    "set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif

"=============== Set extra options when running in GUI mode ==============
if has("gui_running")
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    set guioptions-=m
    set guioptions-=T
    set guioptions-=e
    set guitablabel=%M\ %t
endif

"================ Use Unix as the standard file type =====================
set fileformats=unix,dos,mac


"#########################################################################
"##########################\ Search and Replace /#########################
"#########################################################################
set ignorecase smartcase            " 只有小写时忽略大小写
set hlsearch                        " 高亮搜索结果
set incsearch                       " 增量搜索
set magic                           " 开启 magic 模式

""可视化模式下, */# 向后、前搜索选中的文本.From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

""Clear highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

""When you press <leader>r you can search and replace the selected text
"vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>


"#########################################################################
"################\ Moving around, Tabs, Windows and Buffers /#############
"#########################################################################

"============================ Moving around ==============================
" fast moving
noremap J 4j
noremap K 4k

" Remap VIM 0 to first non-blank character
nnoremap 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-k> mz:m-2<cr>`z
nmap <M-j> mz:m+<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

"============================ windows related ============================
""Moving around windows.
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap <silent> <leader>sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap <silent> <leader>sj :set splitbelow<CR>:split<CR>
noremap <silent> <leader>sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap <silent> <leader>sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
noremap <silent> <up> :res +5<CR>
noremap <silent> <down> :res -5<CR>
noremap <silent> <left> :vertical resize-5<CR>
noremap <silent> <right> :vertical resize+5<CR>

"============================ buffers related ============================

""关闭缓冲区，保留窗口
nnoremap <leader>bd :call g:BufcloseCloseIt()<cr>
""Close all the buffers
nnoremap <leader>ba :bufdo bd<cr>
""Close all the other buffers
""https://blog.csdn.net/magicpang/article/details/2308167
nnoremap <leader>bo :call DeleteAllBuffersInWindow('noforce')<cr>
nnoremap <leader>BO :call DeleteAllBuffersInWindow('force')<cr>

nnoremap = :bnext<cr>
nnoremap - :bprevious<cr>

""映射<leader>num到num buffer
" nnoremap <leader>1 :b 1<CR>
" nnoremap <leader>2 :b 2<CR>
" nnoremap <leader>3 :b 3<CR>
" nnoremap <leader>4 :b 4<CR>
" nnoremap <leader>5 :b 5<CR>
" nnoremap <leader>6 :b 6<CR>
" nnoremap <leader>7 :b 7<CR>
" nnoremap <leader>8 :b 8<CR>
" nnoremap <leader>9 :b 9<CR>

""快速切换到当前编辑的缓冲区中的文件所在的目录
noremap <leader>. :cd %:p:h<cr>:pwd<cr>

""Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

""Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"=============================== tabs related ============================
""Useful mappings for managing tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tm :tabmove<space>
nnoremap + :tabnext<cr>
nnoremap _ :tabprevious<cr>

""Let '<leader>tt' toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <Leader>tt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

""Opens a new tab with the current buffer's path
""Super useful when editing files in the same directory
nnoremap <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

"#########################################################################
"######################\ Status Line and CmdLine /########################
"#########################################################################
set shortmess="filnxtToOSIc"        " 简化显示信息，详见 :h shm
""Always show the status line
set laststatus=2
set ruler                           " 在状态栏显示当前所在的文件位置

set cmdheight=1                     " Make command line one line high
set showcmd                         " normal模式下在vim命令行右边显示输入

"============================= wildmenu 设置 =============================
set wildmenu                        " 命令模式下，在状态栏中显示vim补全选项
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif


"#########################################################################
"######################\ Vim Configuration Files /########################
"#########################################################################

"=================== Fast editing of vimrc configs =======================
nnoremap <leader>e :cd ~/.config/nvim/nvimrcs/<cr>:e<space>

"if has("win16") || has("win32") && has('gui_running')
"    autocmd! bufwritepost $VIMRUNTIME/.vimrc source $VIMRUNTIME/.vimrc
"elseif has("linux")
"    autocmd! bufwritepost ~/.vimrc source ~/.vimrc
"endif


"#########################################################################
"###############################\ Misc /##################################
"#########################################################################

"=================== Automatically clean extra spaces ====================
autocmd BufWritePre *.c,*.cpp,*.h,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()

"===== Remove the Windows ^M - when the encodings gets messed up =========
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"================= Quickly open a buffer for scribble ====================
map <leader>q :e ~/buffer<cr>

"============= Quickly open a markdown buffer for scribble ===============
map <leader>x :e ~/buffer.md<cr>

"==================== Toggle paste mode on and off =======================
map <leader>pp :setlocal paste!<cr>

"===================== Use Showhi to show hlgroup ========================
command! Showhi echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"

