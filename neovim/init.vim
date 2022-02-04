" https://sharksforarms.dev/posts/neovim-rust/
" https://github.com/simrat39/rust-tools.nvim
" https://www.youtube.com/watch?v=CcgO_CV3iDo&list=PLu-ydI-PCl0OEG0ZEqLRRuCrMJGAAI0tW
" https://github.com/David-Kunz/vim/blob/master/_init.vim

call plug#begin('~/.vim/plugged')

Plug 'Mofiqul/vscode.nvim'
Plug 'TimUntersberger/neogit'
Plug 'folke/zen-mode.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'janko/vim-test'
Plug 'simrat39/rust-tools.nvim'
Plug 'kassio/neoterm'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'morhetz/gruvbox'
Plug 'lewis6991/gitsigns.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'projekt0n/github-nvim-theme'
Plug 'puremourning/vimspector'
Plug 'rcarriga/nvim-dap-ui'
Plug 'ryanoasis/vim-devicons'
Plug 'sbdchd/neoformat'
Plug 'sindrets/diffview.nvim'
Plug 'szw/vim-maximizer'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'tpope/vim-commentary'
Plug 'vhyrro/neorg'

call plug#end()

" default options
set encoding=UTF-8
set completeopt=menu,menuone,noselect " better autocomplete options
set mouse=r " enable mouse
set splitright " splits to the right
set splitbelow " splits below
set expandtab " space characters instead of tab
set tabstop=2 " tab equals 2 spaces
set shiftwidth=2 " indentation
set number " show absolute line numbers
set ignorecase " search case insensitive
set smartcase " search via smartcase
set incsearch " search incremental
set diffopt+=vertical " starts diff mode in vertical split
set hidden " allow hidden buffers
set cmdheight=1 " only one line for commands
set shortmess+=c " don't need to press enter so often
set signcolumn=yes " add a column for sings (e.g. LSP, ...)
set updatetime=720 " time until update
set undofile " persists undo tree
set clipboard=unnamed " Use system clipboard (only works if compiled with +x)
set path=$PWD/**
set pastetoggle=<F2> " toggle paste mode
nmap <silent> <Leader>= :nohlsearch <CR> " unhighlight search using <leader>=

filetype plugin indent on " enable detection, plugins and indents
let mapleader = " " " space as leader key

if (has("termguicolors"))
  set termguicolors " better colors, but makes it sery slow!
endif
let g:netrw_banner=0 " disable banner in netrw
let g:netrw_liststyle=3 " tree view in netrw
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript'] " syntax highlighting in markdown
nnoremap <leader>v :e $MYVIMRC<CR>

" Tell vim to remember certain things when we exit
set viminfo='20,\"50

if has("autocmd")
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

" highlight whitespace
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

"Highlight trailing whitespace in red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" in normal mode, if tabs are open
" use tab and shift-tab to navigate, t1 goes to the first tab
nmap t1 :tabfirst<CR>
nmap <S-tab> :tabnext<CR>
nmap <tab> :tabprevious<CR>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" save files if you forgot to sudo
" use w!! and it will ask for sudo and save
cmap w!! %!sudo tee > /dev/null %

"folds: zf to fold, za to toggle
set foldmethod=manual
set foldcolumn=0
set foldlevel=0
set nofoldenable

" store backup and swp files in these dirs to not clutter working dir
set nobackup      " don't create backup files
set ruler         " show the cursor position all the time
set backupdir=~/.config/nvim/_backup
set directory=~/.config/nvim/_temp

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Enable gruvbox
let g:gruvbox_italic=1
let g:gruvbox_italicize_strings=0
colorscheme gruvbox

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
	runnables = {
	    use_telescope = true
	},
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF

" Code navigation shortcuts
" as found in :help lsp
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" Quick-fix
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hover
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>


" lewis6991/gitsigns.nvim
lua << EOF
 require('gitsigns').setup({})
EOF

" 'hoob3rt/lualine.nvim'
lua << EOF
  require('lualine').setup({
  options = {
    theme = "vscode"
   }
  })
EOF

" szw/vim-maximizer
nnoremap <leader>m :MaximizerToggle!<CR>

" kassio/neoterm
let g:neoterm_default_mod = 'vertical'
" let g:neoterm_size = 100
let g:neoterm_autoinsert = 1
let g:neoterm_autoscroll = 1
let g:neoterm_term_per_tab = 1
nnoremap <c-t> :Ttoggle<CR>
" inoremap <c-t> <Esc>:Ttoggle<CR>
" tnoremap <c-t> <c-\><c-n>:Ttoggle<CR>
nnoremap <leader>x :TREPLSendLine<CR>
vnoremap <leader>x :TREPLSendSelection<CR>
if has('nvim')
  au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
endif

" sbdchd/neoformat
nnoremap <leader>F :Neoformat prettier<CR>

" nvim-telescope/telescope.nvim
lua << EOF
_G.telescope_find_files_in_path = function(path)
 local _path = path or vim.fn.input("Dir: ", "", "dir")
 require("telescope.builtin").find_files({search_dirs = {_path}})
end
EOF
lua << EOF
_G.telescope_live_grep_in_path = function(path)
 local _path = path or vim.fn.input("Dir: ", "", "dir")
 require("telescope.builtin").live_grep({search_dirs = {_path}})
end
EOF

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<C-q>"] = actions.send_to_qflist
      }
    }
  }
})
EOF

nnoremap <leader><space> :Telescope git_files<CR>
nnoremap <leader>fd :lua telescope_find_files_in_path()<CR>
nnoremap <leader>fD :lua telescope_live_grep_in_path()<CR>
nnoremap <leader>ft :lua telescope_find_files_in_path("./tests")<CR>
nnoremap <leader>fT :lua telescope_live_grep_in_path("./tests")<CR>
" nnoremap <leader>ff :Telescope live_grep<CR>
nnoremap <leader>fo :Telescope file_browser<CR>
nnoremap <leader>fn :Telescope find_files<CR>
nnoremap <leader>fg :Telescope git_branches<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fs :Telescope lsp_document_symbols<CR>
nnoremap <leader>ff :Telescope live_grep<CR>
nnoremap <leader>FF :Telescope grep_string<CR>
" nnoremap <leader>ff : lua require'telescope.builtin'.grep_string{ only_sort_text = true, search = vim.fn.input("Grep For >") }<CR>

" 'hrsh7th/nvim-compe'
lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    nvim_lua = true;
    -- treesitter = true;
  };
}
EOF
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')

" " janko/vim-test
" nnoremap <silent> tt :TestNearest<CR>
" nnoremap <silent> tf :TestFile<CR>
" nnoremap <silent> ts :TestSuite<CR>
" nnoremap <silent> t_ :TestLast<CR>
" let test#strategy = "neovim"
" let test#neovim#term_position = "vertical"
" let test#enabled_runners = ["javascript#jest"]
" let g:test#javascript#runner = 'jest'


" puremourning/vimspector
 " fun! GotoWindow(id)
 "   :call win_gotoid(a:id)
 " endfun
 " func! AddToWatch()
 "   let word = expand("<cexpr>")
 "   call vimspector#AddWatch(word)
 " endfunction
 " let g:vimspector_base_dir = expand('$HOME/.config/vimspector-config')
 " let g:vimspector_sidebar_width = 60
 " nnoremap <leader>da :call vimspector#Launch()<CR>
 " nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
 " nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
 " nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
 " nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
 " nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
 " nnoremap <leader>di :call AddToWatch()<CR>
 " nnoremap <leader>dx :call vimspector#Reset()<CR>
 " nnoremap <leader>dX :call vimspector#ClearBreakpoints()<CR>
 " nnoremap <S-k> :call vimspector#StepOut()<CR>
 " nnoremap <S-l> :call vimspector#StepInto()<CR>
 " nnoremap <S-j> :call vimspector#StepOver()<CR>
 " nnoremap <leader>d_ :call vimspector#Restart()<CR>
 " nnoremap <leader>dn :call vimspector#Continue()<CR>
 " nnoremap <leader>drc :call vimspector#RunToCursor()<CR>
 " nnoremap <leader>dh :call vimspector#ToggleBreakpoint()<CR>
 " nnoremap <leader>de :call vimspector#ToggleConditionalBreakpoint()<CR>
 " let g:vimspector_sign_priority = {
 "   \    'vimspectorBP':         998,
 "   \    'vimspectorBPCond':     997,
 "   \    'vimspectorBPDisabled': 996,
 "   \    'vimspectorPC':         999,
 "   \ }

" " janko/vim-test and puremourning/vimspector
" nnoremap <leader>dd :TestNearest -strategy=jest<CR>
" function! JestStrategy(cmd)
 "  let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
 "  call vimspector#LaunchWithSettings( #{ configuration: 'jest', TestName: testName } )
" endfunction      
" let g:test#custom_strategies = {'jest': function('JestStrategy')}

" CDS
" augroup MyCDSCode
"     autocmd!
"     autocmd BufReadPre,FileReadPre *.cds set ft=cds
" augroup END
" lua << EOF
"   local lspconfig = require'lspconfig'
"   local configs = require'lspconfig/configs'
"   configs.sapcds_lsp = {
"     default_config = {
"       cmd = {vim.fn.expand("$HOME/projects/startcdslsp")};
"       filetypes = {'cds'};
"       root_dir = function(fname)
"         return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
"       end;
"       settings = {};
"     };
"   }
"   if lspconfig.sapcds_lsp.setup then
"     lspconfig.sapcds_lsp.setup{ }
"   end
" EOF

nnoremap <Leader><ESC><ESC> :tabclose<CR>

" vimwiki/vimwiki
nnoremap <Leader>tl <Plug>VimwikiToggleListItem
vnoremap <Leader>tl <Plug>VimwikiToggleListItem
nnoremap <Leader>wn <Plug>VimwikiNextLink
let g:vimwiki_global_ext = 0
let wiki = {}
let wiki.nested_syntaxes = { 'js': 'javascript' }
let g:vimwiki_list = [wiki] 

" nvim/treesitter
let g:vscode_style = "dark"
" colorscheme vscode
" lua << EOF
" require('github-theme').setup({
"   themeStyle = "dark"
" })
" EOF

" vhyrro/neorg
nnoremap <leader>nn :e ~/neorg/index.norg<CR>
lua << EOF
  require('neorg').setup {
            -- Tell Neorg what modules to load
            load = {
                ["core.defaults"] = {}, -- Load all the default modules
                ["core.norg.concealer"] = {}, -- Allows for use of icons
                ["core.norg.dirman"] = { -- Manage your directories with Neorg
                    config = {
                        workspaces = {
                            my_workspace = "~/neorg"
                        }
                    }
                }
            },
        }
EOF

lua << EOF
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/vhyrro/tree-sitter-norg",
        files = { "src/parser.c" },
        branch = "main"
    },
}
EOF


lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  }
}
EOF

" set foldmethod=expr
" setlocal foldlevelstart=99
" set foldexpr=nvim_treesitter#foldexpr()

" mfussenegger/nvim-dap
lua << EOF
local dap = require('dap')
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/apps/vscode-node-debug2/out/src/nodeDebug.js'},
}
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})
EOF
nnoremap <leader>dh :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <S-c-k> :lua require'dap'.step_out()<CR>
nnoremap <S-c-l> :lua require'dap'.step_into()<CR>
nnoremap <S-c-j> :lua require'dap'.step_over()<CR>
nnoremap <leader>ds :lua require'dap'.stop()<CR>
nnoremap <leader>dn :lua require'dap'.continue()<CR>
nnoremap <leader>dk :lua require'dap'.up()<CR>
nnoremap <leader>dj :lua require'dap'.down()<CR>
nnoremap <leader>d_ :lua require'dap'.disconnect();require'dap'.stop();require'dap'.run_last()<CR>
nnoremap <leader>dr :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
nnoremap <leader>di :lua require'dap.ui.variables'.hover()<CR>
vnoremap <leader>di :lua require'dap.ui.variables'.visual_hover()<CR>
nnoremap <leader>d? :lua require'dap.ui.variables'.scopes()<CR>
nnoremap <leader>de :lua require'dap'.set_exception_breakpoints({"all"})<CR>
nnoremap <leader>da :lua require'debugHelper'.attach()<CR>
nnoremap <leader>dA :lua require'debugHelper'.attachToRemote()<CR>
nnoremap <leader>di :lua require'dap.ui.widgets'.hover()<CR>
nnoremap <leader>d? :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>

" Plug 'nvim-telescope/telescope-dap.nvim'
lua << EOF
require('telescope').setup()
require('telescope').load_extension('dap')
EOF
nnoremap <leader>df :Telescope dap frames<CR>
nnoremap <leader>dc :Telescope dap commands<CR>
nnoremap <leader>db :Telescope dap list_breakpoints<CR>

" theHamsta/nvim-dap-virtual-text and mfussenegger/nvim-dap
let g:dap_virtual_text = v:true

" Plug 'rcarriga/nvim-dap-ui'
" lua require("dapui").setup()
" nnoremap <leader>dq :lua require("dapui").toggle()<CR>

" jank/vim-test and mfussenegger/nvim-dap
nnoremap <leader>dd :TestNearest -strategy=jest<CR>
function! JestStrategy(cmd)
  let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
  let fileName = matchlist(a:cmd, '\v'' -- (.*)$')[1]
  call luaeval("require'debugHelper'.debugJest([[" . testName . "]], [[" . fileName . "]])")
endfunction
let g:test#custom_strategies = {'jest': function('JestStrategy')}

" TimUntersberger/neogit and sindrets/diffview.nvim
lua << EOF
require("neogit").setup {
  disable_commit_confirmation = true,
  integrations = {
    diffview = true
    }
  }
EOF
nnoremap <leader>gg :Neogit<cr>
nnoremap <leader>gd :DiffviewOpen<cr>
nnoremap <leader>gD :DiffviewOpen main<cr>
nnoremap <leader>gl :Neogit log<cr>
nnoremap <leader>gp :Neogit push<cr>

" folke/zen-mode.nvim
lua << EOF
  require("zen-mode").setup {}
EOF
nnoremap <leader>z :ZenMode<CR>
