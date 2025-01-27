"======================================================================
"
" init-plugins.vim - 
"
" Created by skywind on 2018/05/31
" Last Modified: 2018/06/10 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :



"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
	let g:bundle_group = ['basic', 'enhanced', 'filetypes', 'textobj']
	" let g:bundle_group += ['airline', 'nerdtree', 'devicons', 'ale', 'echodoc', 'coc', 'omnisharp']
    let g:bundle_group += ['airline', 'fern', 'devicons', 'ale', 'echodoc', 'coc', 'omnisharp']
	let g:bundle_group += ['leaderf']
endif


"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! s:path(path)
	let path = expand(s:home . '/' . a:path )
	return substitute(path, '\\', '/', 'g')
endfunc


"----------------------------------------------------------------------
" 在 ~/.vim/bundles 下安装插件
"----------------------------------------------------------------------
call plug#begin(get(g:, 'bundle_home', '~/.vim/bundles'))

"----------------------------------------------------------------------
" 默认插件 
"----------------------------------------------------------------------

" 全文快速移动，<leader><leader>f{char} 即可触发
Plug 'easymotion/vim-easymotion'

" 表格对齐，使用命令 Tabularize
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" Diff 增强，支持 histogram / patience 等更科学的 diff 算法
Plug 'chrisbra/vim-diff-enhanced'

" Vim-which-key 是 emacs-which-key 的 vim 插件，它在弹出窗口中显示可用的快捷键
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
let g:mapleader = "\<Space>"
let g:maplocalleader = ","
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :WhichKey ','<CR>

"----------------------------------------------------------------------
" 基础插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'basic') >= 0

	" 展示开始画面，显示最近编辑过的文件
	Plug 'mhinz/vim-startify'

	" 主题包，一次性安装一大堆 colorscheme
	Plug 'flazz/vim-colorschemes'

    " doom-one主题
    Plug 'romgrk/doom-one.vim'
    " gruvbox主题
    Plug 'morhetz/gruvbox'
    " space-vim 主题
    Plug 'liuchengxu/space-vim-dark'

	" 支持库，给其他插件用的函数库
	Plug 'xolox/vim-misc'

	" 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
	Plug 'kshenoy/vim-signature'

	" 用于在侧边符号栏显示 git/svn 的 diff
	Plug 'mhinz/vim-signify'

	" 根据 quickfix 中匹配到的错误信息，高亮对应文件的错误行
	" 使用 :RemoveErrorMarkers 命令或者 <space>ha 清除错误
	Plug 'mh21/errormarker.vim'

	" 使用 ALT+e 会在不同窗口/标签上显示 A/B/C 等编号，然后字母直接跳转
	Plug 't9md/vim-choosewin'

	" Git 支持
	Plug 'tpope/vim-fugitive'

    " 工程管理
    Plug 'leafOfTree/vim-project'

    " 快捷键提示
    Plug 'sunaku/vim-shortcut'

	" 使用 ALT+E 来选择窗口
	nmap <m-e> <Plug>(choosewin)

	" 默认不显示 startify
	"  let g:startify_disable_at_vimenter = 1
	let g:startify_session_dir = '~/.vim/session'

	" 使用 <space>ha 清除 errormarker 标注的错误
	noremap <silent><space>ha :RemoveErrorMarkers<cr>

	" signify 调优
	let g:signify_vcs_list = ['git', 'svn']
	let g:signify_sign_add               = '+'
	let g:signify_sign_delete            = '_'
	let g:signify_sign_delete_first_line = '‾'
	let g:signify_sign_change            = '~'
	let g:signify_sign_changedelete      = g:signify_sign_change

	" git 仓库使用 histogram 算法进行 diff
	let g:signify_vcs_cmds = {
			\ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
			\}

    "注释插件
    Plug 'preservim/nerdcommenter'
endif


"----------------------------------------------------------------------
" 增强插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'enhanced') >= 0

	" 用 v 选中一个区域后，ALT_+/- 按分隔符扩大/缩小选区
	Plug 'terryma/vim-expand-region'

    " Autocompletion
    Plug 'prabirshrestha/asyncomplete.vim'
    " Asyncomplete: {{{
    let g:asyncomplete_auto_popup = 1
    let g:asyncomplete_auto_completeopt = 0
    " }}}

	" 给不同语言提供字典补全，插入模式下 c-x c-k 触发
	Plug 'asins/vim-dict'

	" 使用 :FlyGrep 命令进行实时 grep
	Plug 'wsdjeg/FlyGrep.vim'

	" 使用 :CtrlSF 命令进行模仿 sublime 的 grep
	Plug 'dyng/ctrlsf.vim'

	" 配对括号和引号自动补全
	Plug 'Raimondi/delimitMate'

	" 提供 gist 接口
	Plug 'lambdalisue/vim-gista', { 'on': 'Gista' }

    " 快速进行对齐/格式化
    Plug 'junegunn/vim-easy-align'

    " 代码片段
    Plug 'SirVer/ultisnips'
    Plug 'qiuchangjie/vim-snippets'
	
	" ALT_+/- 用于按分隔符扩大缩小 v 选区
	map <m-=> <Plug>(expand_region_expand)
	map <m--> <Plug>(expand_region_shrink)

    " 代码片段配置
    let g:UltiSnipsSnippetDirectories=["UltiSnips"]
endif

"----------------------------------------------------------------------
" 文本对象：textobj 全家桶
"----------------------------------------------------------------------
if index(g:bundle_group, 'textobj') >= 0

	" 基础插件：提供让用户方便的自定义文本对象的接口
	Plug 'kana/vim-textobj-user'

	" indent 文本对象：ii/ai 表示当前缩进，vii 选中当缩进，cii 改写缩进
	Plug 'kana/vim-textobj-indent'

	" 语法文本对象：iy/ay 基于语法的文本对象
	Plug 'kana/vim-textobj-syntax'

	" 函数文本对象：if/af 支持 c/c++/vim/java
	Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }

	" 参数文本对象：i,/a, 包括参数或者列表元素
	Plug 'sgur/vim-textobj-parameter'

	" 提供 python 相关文本对象，if/af 表示函数，ic/ac 表示类
	Plug 'bps/vim-textobj-python', {'for': 'python'}

	" 提供 uri/url 的文本对象，iu/au 表示
	Plug 'jceb/vim-textobj-uri'
endif


"----------------------------------------------------------------------
" 文件类型扩展
"----------------------------------------------------------------------
if index(g:bundle_group, 'filetypes') >= 0

	" powershell 脚本文件的语法高亮
	Plug 'pprovost/vim-ps1', { 'for': 'ps1' }

	" lua 语法高亮增强
	Plug 'tbastos/vim-lua', { 'for': 'lua' }

	" C++ 语法高亮增强，支持 11/14/17 标准
	Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }

	" 额外语法文件
	Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }

	" python 语法文件增强
	Plug 'vim-python/python-syntax', { 'for': ['python'] }

	" rust 语法增强
	Plug 'rust-lang/rust.vim', { 'for': 'rust' }

	" vim org-mode 
	Plug 'jceb/vim-orgmode', { 'for': 'org' }

    "vim 代码文件头
    Plug 'ahonn/vim-fileheader'
    let g:fileheader_author = 'ChangJie.Qiu'
    let g:fileheader_auto_add = 0
    let g:fileheader_auto_update = 1
    let g:fileheader_by_git_config = 0
    let g:fileheader_show_email = 0
    let g:fileheader_templates_map = {
        \ 'lua': [
            \ '@Author            : {{author}}',
            \ '@Date              : {{created_date}}',
            \ '@Last Modified by  : {{modifier}}',
            \ '@Last Modified time: {{modified_date}}',
            \ ],
        \ 'cs': [
            \ '@Author            : {{author}}',
            \ '@Date              : {{created_date}}',
            \ '@Last Modified by  : {{modifier}}',
            \ '@Last Modified time: {{modified_date}}',
            \ ]
        \ }
endif


"----------------------------------------------------------------------
" airline
"----------------------------------------------------------------------
if index(g:bundle_group, 'airline') >= 0
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	"  let g:airline_left_sep = ''
	"  let g:airline_left_alt_sep = ''
	"  let g:airline_right_sep = ''
	"  let g:airline_right_alt_sep = ''
	"  let g:airline_powerline_fonts = 1
	"  let g:airline_exclude_preview = 1
	"  let g:airline_section_b = '%n'
	"  let g:airline_theme='deus'
	"  let g:airline#extensions#branch#enabled = 0
	"  let g:airline#extensions#syntastic#enabled = 0
	"  let g:airline#extensions#fugitiveline#enabled = 0
	"  let g:airline#extensions#csv#enabled = 0
	"  let g:airline#extensions#vimagit#enabled = 0
    "  let g:airline#extensions#tabline#enabled = 1
    
    "----------airline------------
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ''
    let g:airline#extensions#tabline#left_alt_sep = ''
    let g:airline#extensions#tabline#formatter = 'unique_tail'
    let g:airline#extensions#tabline#buffer_nr_show = 1        "显示buffer编号
    let g:airline#extensions#tabline#buffer_nr_format = '%s:'
    " let g:airline#extensions#tabline#buffer_idx_mode = 1
    let g:airline#extensions#battery#enabled = 1

    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_powerline_fonts = 1
    "  let g:airline_theme='onedark'       " 需要安装joshdick/onedark.vim主题插件
endif


"----------------------------------------------------------------------
" NERDTree
"----------------------------------------------------------------------
if index(g:bundle_group, 'nerdtree') >= 0
	Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind'] }
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	let g:NERDTreeMinimalUI = 1
	let g:NERDTreeDirArrows = 1
	let g:NERDTreeHijackNetrw = 0
	noremap <space>nn :NERDTree<cr>
	noremap <space>no :NERDTreeFocus<cr>
	noremap <space>nm :NERDTreeMirror<cr>
	noremap <space>nt :NERDTreeToggle<cr>
    noremap <space>nf :NERDTreeFind<cr>
endif

"----------------------------------------------------------------------
" fern 文件树查看器（替代NERDTree）
"----------------------------------------------------------------------
if index(g:bundle_group, 'fern') >= 0
	Plug 'lambdalisue/fern.vim'
    " 自定义命令
    " 根目录打开文件查看器
    command FernDrawer execute ":Fern . -drawer"
    " 打开文件查看器并定位到当前文件
    command FernDrawerReveal execute ":Fern . -drawer -reveal=%"
endif

"----------------------------------------------------------------------
" devicons
"----------------------------------------------------------------------
if index(g:bundle_group, 'devicons') >= 0
    Plug 'ryanoasis/vim-devicons'
endif

"----------------------------------------------------------------------
" LanguageTool 语法检查
"----------------------------------------------------------------------
if index(g:bundle_group, 'grammer') >= 0
	Plug 'rhysd/vim-grammarous'
	noremap <space>rg :GrammarousCheck --lang=en-US --no-move-to-first-error --no-preview<cr>
	map <space>rr <Plug>(grammarous-open-info-window)
	map <space>rv <Plug>(grammarous-move-to-info-window)
	map <space>rs <Plug>(grammarous-reset)
	map <space>rx <Plug>(grammarous-close-info-window)
	map <space>rm <Plug>(grammarous-remove-error)
	map <space>rd <Plug>(grammarous-disable-rule)
	map <space>rn <Plug>(grammarous-move-to-next-error)
	map <space>rp <Plug>(grammarous-move-to-previous-error)
endif


"----------------------------------------------------------------------
" ale：动态语法检查
"----------------------------------------------------------------------
if index(g:bundle_group, 'ale') >= 0
	Plug 'dense-analysis/ale'

	" 设定延迟和提示信息
	let g:ale_completion_delay = 500
	let g:ale_echo_delay = 20
	let g:ale_lint_delay = 500
	let g:ale_echo_msg_format = '[%linter%] %code: %%s'

	" 设定检测的时机：normal 模式文字改变，或者离开 insert模式
	" 禁用默认 INSERT 模式下改变文字也触发的设置，太频繁外，还会让补全窗闪烁
	let g:ale_lint_on_text_changed = 'normal'
	let g:ale_lint_on_insert_leave = 1

	" 在 linux/mac 下降低语法检查程序的进程优先级（不要卡到前台进程）
	if has('win32') == 0 && has('win64') == 0 && has('win32unix') == 0
		let g:ale_command_wrapper = 'nice -n5'
	endif

	" 允许 airline 集成
	let g:airline#extensions#ale#enabled = 1

	" 编辑不同文件类型需要的语法检查器
	let g:ale_linters = {
				\ 'c': ['gcc', 'cppcheck'], 
				\ 'cpp': ['gcc', 'cppcheck'], 
				\ 'cs': ['OmniSharp'],
				\ 'python': ['flake8', 'pylint'], 
				\ 'lua': ['luac'], 
				\ 'go': ['go build', 'gofmt'],
				\ 'java': ['javac'],
				\ 'javascript': ['eslint'], 
				\ }


	" 获取 pylint, flake8 的配置文件，在 vim-init/tools/conf 下面
	function s:lintcfg(name)
		let conf = s:path('tools/conf/')
		let path1 = conf . a:name
		let path2 = expand('~/.vim/linter/'. a:name)
		if filereadable(path2)
			return path2
		endif
		return shellescape(filereadable(path2)? path2 : path1)
	endfunc

	" 设置 flake8/pylint 的参数
	let g:ale_python_flake8_options = '--conf='.s:lintcfg('flake8.conf')
	let g:ale_python_pylint_options = '--rcfile='.s:lintcfg('pylint.conf')
	let g:ale_python_pylint_options .= ' --disable=W'
	let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
	let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
	let g:ale_c_cppcheck_options = ''
	let g:ale_cpp_cppcheck_options = ''

	let g:ale_linters.text = ['textlint', 'write-good', 'languagetool']

	" 如果没有 gcc 只有 clang 时（FreeBSD）
	if executable('gcc') == 0 && executable('clang')
		let g:ale_linters.c += ['clang']
		let g:ale_linters.cpp += ['clang']
	endif
endif


"----------------------------------------------------------------------
" echodoc：搭配 YCM/deoplete 在底部显示函数参数
"----------------------------------------------------------------------
if index(g:bundle_group, 'echodoc') >= 0
	Plug 'Shougo/echodoc.vim'
	set noshowmode
	let g:echodoc#enable_at_startup = 1
endif

if index(g:bundle_group, 'omnisharp') >=0 
    Plug 'omnisharp/omnisharp-vim'
    " OmniSharp: {{{
    let g:OmniSharp_popup_position = 'peek'
    if has('nvim')
      let g:OmniSharp_popup_options = {
      \ 'winblend': 30,
      \ 'winhl': 'Normal:Normal,FloatBorder:ModeMsg',
      \ 'border': 'rounded'
      \}
    else
      let g:OmniSharp_popup_options = {
      \ 'highlight': 'Normal',
      \ 'padding': [0],
      \ 'border': [1],
      \ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
      \ 'borderhighlight': ['ModeMsg']
      \}
    endif
    let g:OmniSharp_popup_mappings = {
    \ 'sigNext': '<C-n>',
    \ 'sigPrev': '<C-p>',
    \ 'pageDown': ['<C-f>', '<PageDown>'],
    \ 'pageUp': ['<C-b>', '<PageUp>']
    \}

    " need Plug 'sirver/ultisnips'
    " let g:OmniSharp_want_snippet = 1

    let g:OmniSharp_highlight_groups = {
    \ 'ExcludedCode': 'NonText'
    \}
    " }}}
endif

if index(g:bundle_group, 'coc') >= 0
    Plug 'neoclide/coc.nvim', {'branch':'release'}
    let g:coc_global_extensions=[
                \'coc-omnisharp',
                \'coc-html',
                \'coc-eslint',
                \'coc-snippets',
                \'coc-clangd',
                \'coc-codegeex',
                \'coc-java',
                \'coc-pairs',
                \'coc-json',
                \'coc-lists',
                \'coc-highlight',
                \'coc-css',
                \'coc-git',
                \'coc-phpls',
                \'coc-prettier',
                \'coc-wxml',
                \'coc-tsserver',
                \'coc-vetur',
                \'coc-stylelint',
                \'coc-word',
                \'coc-python',
                \'coc-vimlsp',
                \'coc-tabnine',
                \'coc-emoji',
                \'coc-marketplace',
                \'coc-sumneko-lua',
                \]
    "------------------------------coc.nvim---------------------------------------
    filetype on

    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1):
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

    " Make <CR> to accept selected completion item or notify coc.nvim to format
    " <C-g>u breaks current undo, please make your own choice.
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
    else
    inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call ShowDocumentation()<CR>

    function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Run the Code Lens action on the current line.
    nmap <leader>cl  <Plug>(coc-codelens-action)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Remap <C-f> and <C-b> for scroll float windows/popups.
    " if has('nvim-0.4.0') || has('patch-8.2.0750')
    " nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    " nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    " inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    " inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    " vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    " vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    " endif

    " Use CTRL-S for selections ranges.
    " Requires 'textDocument/selectionRange' support of language server.
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocActionAsync('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Mappings for CoCList
    " Show all diagnostics.
    nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
    "------------------------------coc.nvim---------------------------------------------
endif


"----------------------------------------------------------------------
" LeaderF：CtrlP / FZF 的超级代替者，文件模糊匹配，tags/函数名 选择
"----------------------------------------------------------------------
if index(g:bundle_group, 'leaderf') >= 0
	" 如果 vim 支持 python 则启用  Leaderf （只要设置好变量 &pythonthreedll 就可以）
	if has('python') || has('python3')
		Plug 'Yggdroot/LeaderF',{'do':':LeaderfInstallCExtension'}

		"  " CTRL+p 打开文件模糊匹配
		"  let g:Lf_ShortcutF = '<c-p>'

		"  " ALT+n 打开 buffer 模糊匹配
		"  let g:Lf_ShortcutB = '<m-n>'

		"  " CTRL+n 打开最近使用的文件 MRU，进行模糊匹配
		"  noremap <c-n> :LeaderfMru<cr>

		"  " ALT+p 打开函数列表，按 i 进入模糊匹配，ESC 退出
		"  noremap <m-p> :LeaderfFunction!<cr>

		"  " ALT+SHIFT+p 打开 tag 列表，i 进入模糊匹配，ESC退出
		"  noremap <m-P> :LeaderfBufTag!<cr>

		"  " ALT+n 打开 buffer 列表进行模糊匹配
		"  noremap <m-n> :LeaderfBuffer<cr>

        "  " ALT+SHIFT+m 搜索当前光标所在的单词
        "  noremap <m-M> :<c-u><c-r>=printf("Leaderf! rg -e %s", expand("<cword>"))<cr>
		"  "  " ALT+m 全局 tags 模糊匹配
		"  "  noremap <m-m> :LeaderfTag<cr>
        "  " ALT+m 全局 rg 模糊匹配
        "  noremap <m-m> :Leaderf rg<cr>
        "  " ALT+SHIFT+n recall rg
        "  noremap <m-N> :LeaderfRgRecall<cr>

        "------------------------------LeaderF---------------------------------------------
        let g:Lf_PreviewInPopup = 1
        let g:Lf_PreviewHorizontalPosition = 'right'
        let g:Lf_UseCache = 0
        " 模糊匹配忽略扩展名
        let g:Lf_WildIgnore = {
                \ 'dir': ['.svn','.git','.hg','Temp', 'obj', 'Library'],
                \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.meta',
                    \ '*.sln*','*.csproj', 'UnityLockfile', '*.prefab', '*.unity', '*.asset', 
                    \ '*.unitypackage', '*.anim', '*.tif', '*.bin', '*.png', '*.mat', '*.fbx', 
                    \ '*.tga', '*.tiff', '*.dds', '*.ico', '*.jpeg', '*.jpg', '*.shader', 
                    \ '*.controller', '*.signal', '*.mp3', '*.asmdef', '*.cache', '*.spriteatlas',
                    \ '*.fontsettings', '*.renderTexture', '*.bank', '*.xsd', '*.plist', '*.playable']
                \}
        " MRU 文件忽略扩展名
		let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', 
            \ '*.dll', '*.meta','*.sln*','*.csproj', 'UnityLockfile', '*.prefab', '*.unity', '*.asset', 
            \ '*.unitypackage', '*.anim', '*.tif', '*.bin', '*.png', '*.mat', '*.fbx', '*.tga', '*.tiff', 
            \ '*.dds', '*.ico', '*.jpeg', '*.jpg', '*.shader', '*.controller', '*.signal', '*.mp3', '*.asmdef', '*.cache', 
            \ '*.spriteatlas', '*.fontsettings', '*.renderTexture', '*.bank', '*.xsd', '*.plist', '*.playable']
        nmap<c-p> :LeaderfFile<cr>
        nmap<c-s-p> :LeaderfRgInteractive<cr>
        nmap<c-b> :LeaderfBuffer<cr>
        nmap<c-t> :LeaderfFunction<cr>
        nmap<c-s-t> :LeaderfFunctionAll<cr>
        nmap<c-f> :LeaderfLine<cr>
        nmap<c-s-f> :<c-u><c-r>=printf("Leaderf! rg %s", expand("<cword>"))<cr>

        "  imap<c-p> <Esc>:Leaderf file<cr>
        "  imap<c-b> <Esc>:Leaderf buffer<cr>
        "  imap<c-t> <Esc>:Leaderf function<cr>
        "  imap<c-f> <Esc>:Leaderf rg<cr>
        "  imap<c-s-f> <Esc>:<c-u><c-r>=printf("Leaderf! rg %s", expand("<cword>"))<cr>
        "------------------------------LeaderF---------------------------------------------

		" 最大历史文件保存 2048 个
		let g:Lf_MruMaxFiles = 2048

        " 这个选项可以是'rg', 'pt', 'ag', 'find'之一
        let g:Lf_DefaultExternalTool='rg'

		" ui 定制
		let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

		" 如何识别项目目录，从当前文件目录向父目录递归知道碰到下面的文件/目录
		let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
		"  let g:Lf_WorkingDirectoryMode = 'Ac'
		let g:Lf_WindowHeight = 0.30
		let g:Lf_CacheDirectory = expand(s:home . '/.cache/Leaderf')

		" 显示绝对路径
		let g:Lf_ShowRelativePath = 0

		" 隐藏帮助
		let g:Lf_HideHelp = 1

		let g:Lf_StlColorscheme = 'powerline'

		" 禁用 function/buftag 的预览功能，可以手动用 p 预览
		let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

		" 使用 ESC 键可以直接退出 leaderf 的 normal 模式
		let g:Lf_NormalMap = {
				\ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
				\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<cr>']],
				\ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<cr>']],
				\ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<cr>']],
				\ "BufTag": [["<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<cr>']],
				\ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
				\ }

	else
		" 不支持 python ，使用 CtrlP 代替
		Plug 'ctrlpvim/ctrlp.vim'

		" 显示函数列表的扩展插件
		Plug 'tacahiroy/ctrlp-funky'

		" 忽略默认键位
		let g:ctrlp_map = ''

		" 模糊匹配忽略
		let g:ctrlp_custom_ignore = {
		  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
		  \ 'file': '\v\.(exe|so|dll|mp3|wav|sdf|suo|mht)$',
		  \ 'link': 'some_bad_symbolic_links',
		  \ }

		" 项目标志
		let g:ctrlp_root_markers = ['.project', '.root', '.svn', '.git']
		let g:ctrlp_working_path = 0

		" CTRL+p 打开文件模糊匹配
		noremap <c-p> :CtrlP<cr>

		" CTRL+n 打开最近访问过的文件的匹配
		noremap <c-n> :CtrlPMRUFiles<cr>

		" ALT+p 显示当前文件的函数列表
		noremap <m-p> :CtrlPFunky<cr>

		" ALT+n 匹配 buffer
		noremap <m-n> :CtrlPBuffer<cr>
	endif
endif

"----------------------------------------------------------------------
" 结束插件安装
"----------------------------------------------------------------------
call plug#end()

"代码补全
set completeopt=longest,menu,menuone,noselect
set completepopup=highlight:Pmenu,border:off


"  "----------------------------------------------------------------------
"  " YouCompleteMe 默认设置：YCM 需要你另外手动编译安装
"  "----------------------------------------------------------------------

"  " 禁用预览功能：扰乱视听
"  let g:ycm_add_preview_to_completeopt = 0

"  " 禁用诊断功能：我们用前面更好用的 ALE 代替
"  let g:ycm_show_diagnostics_ui = 0
"  let g:ycm_server_log_level = 'info'
"  let g:ycm_min_num_identifier_candidate_chars = 2
"  let g:ycm_collect_identifiers_from_comments_and_strings = 1
"  let g:ycm_complete_in_strings=1
"  let g:ycm_key_invoke_completion = '<c-z>'

"  " noremap <c-z> <NOP>

"  " 两个字符自动触发语义补全
"  let g:ycm_semantic_triggers =  {
"  			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
"  			\ 'cs,lua,javascript': ['re!\w{2}'],
"  			\ }


"  "----------------------------------------------------------------------
"  " Ycm 白名单（非名单内文件不启用 YCM），避免打开个 1MB 的 txt 分析半天
"  "----------------------------------------------------------------------
"  let g:ycm_filetype_whitelist = { 
"  			\ "c":1,
"  			\ "cpp":1, 
"  			\ "objc":1,
"  			\ "objcpp":1,
"  			\ "python":1,
"  			\ "java":1,
"  			\ "javascript":1,
"  			\ "coffee":1,
"  			\ "vim":1, 
"  			\ "go":1,
"  			\ "cs":1,
"  			\ "lua":1,
"  			\ "perl":1,
"  			\ "perl6":1,
"  			\ "php":1,
"  			\ "ruby":1,
"  			\ "rust":1,
"  			\ "erlang":1,
"  			\ "asm":1,
"  			\ "nasm":1,
"  			\ "masm":1,
"  			\ "tasm":1,
"  			\ "asm68k":1,
"  			\ "asmh8300":1,
"  			\ "asciidoc":1,
"  			\ "basic":1,
"  			\ "vb":1,
"  			\ "make":1,
"  			\ "cmake":1,
"  			\ "html":1,
"  			\ "css":1,
"  			\ "less":1,
"  			\ "json":1,
"  			\ "cson":1,
"  			\ "typedscript":1,
"  			\ "haskell":1,
"  			\ "lhaskell":1,
"  			\ "lisp":1,
"  			\ "scheme":1,
"  			\ "sdl":1,
"  			\ "sh":1,
"  			\ "zsh":1,
"  			\ "bash":1,
"  			\ "man":1,
"  			\ "markdown":1,
"  			\ "matlab":1,
"  			\ "maxima":1,
"  			\ "dosini":1,
"  			\ "conf":1,
"  			\ "config":1,
"  			\ "zimbu":1,
"  			\ "ps1":1,
"  			\ }


