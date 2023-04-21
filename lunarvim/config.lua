--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.clipboard = ""
vim.opt.autowriteall = true
vim.opt.mouse = "r"

vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.list = false

vim.g.syntastic_typescript_tsc_args = "--experimentalDecorators"

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua,*.go,*.java,*.tsx,*.html,*.jsx,*js,*.css,*.ts",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- FORMATTER
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
  -- go install golang.org/x/tools/cmd/goimports@latest
  {
    command = "goimports",
    filetypes = { "go" },
  },
}


-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode["-"] = ":split<CR>"
lvim.keys.normal_mode["<Tab>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = ":bprev<CR>"
lvim.keys.normal_mode["<Esc>"] = ":noh<CR><Esc>"

-- need to set iterm cmd+c to send escape sequence esc+a, then map M-a to *y
-- lvim.keys.normal_mode["<C-c>"] = ":\"*y<CR>"
local map = vim.keymap.set
map("v", "<M-b>", "\"*y")


-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["S"] = {
  name = "Session",
  s = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  S = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

lvim.builtin.which_key.mappings["l"]["F"] = {
  name = "Format",
  j = { "<cmd>%!python3 -m json.tool<cr>gg=G<cr>", "Json" }
}


lvim.builtin.which_key.mappings["F"] = {
  name = "Find and Replace",
  { "<cmd>lua require('spectre').open()<cr>", "Find and Replace" }
}

lvim.builtin.which_key.mappings["g"]["b"] = {
  name = "Blame",
  { "<cmd>Git blame<cr>", "Git blame" }
}

lvim.builtin.which_key.mappings["b"]["q"] = {
  name = "Close",
  { "<cmd>bp<bar>sp<bar>bn<bar>bd<CR>", "Close" }
}
lvim.keys.normal_mode["<C-w>"]            = "<cmd>bp<bar>sp<bar>bn<bar>bd<CR>"

-- Code action
-- if vim.bo.filetype == "java" then

-- Filetype = vim.bo.filetype
lvim.builtin.which_key.mappings["l"]["a"]["j"] = {
  name = "Java Run file",
  { "<cmd>! java %:p<CR>", "Run file" }
}
-- end

-- Terminal
lvim.builtin.which_key.mappings["t"] = { "<cmd>ToggleTerm direction=float<CR>", "Terminal" }
lvim.keys.normal_mode["<C-t>"]       = ":ToggleTerm direction=float<CR>"
lvim.keys.term_mode["<C-t>"]         = "<C-\\><C-n><C-w>l"

-- Lazydocker
local Terminal   = require('toggleterm.terminal').Terminal
local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })

function Lazydocker_toggle()
  lazydocker:toggle()
end

lvim.builtin.which_key.mappings["D"] = { "<cmd>lua Lazydocker_toggle() <CR>", "Docker" }


lvim.builtin.which_key.mappings["<Space>"] = {
  name = "Select Window",
  { function()
    local picked_window_id = require('window-picker').pick_window({
      include_current_win = true
    }) or vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(picked_window_id)
  end, "Select Window" }
}


-- -- Change theme settings
-- lvim.colorscheme = "lunar"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.actions = {
  open_file = {
    resize_window = true
  }
}
lvim.builtin.nvimtree.setup.view.width = 50

-- require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
--   auto_reload_on_write = true,
--   create_in_closed_folder = false,
--   disable_netrw = false,
--   hijack_cursor = false,
--   hijack_netrw = true,
--   hijack_unnamed_buffer_when_opening = false,
--   ignore_buffer_on_setup = false,
--   open_on_setup = false,
--   open_on_setup_file = false,
--   open_on_tab = false,
--   ignore_buf_on_tab_change = {},
--   sort_by = "name",
--   root_dirs = {},
--   prefer_startup_root = false,
--   sync_root_with_cwd = false,
--   reload_on_bufenter = false,
--   respect_buf_cwd = false,
--   on_attach = "disable",
--   remove_keymaps = false,
--   select_prompts = false,
--   view = {
--     adaptive_size = false,
--     centralize_selection = false,
--     width = 30,
--     hide_root_folder = false,
--     side = "left",
--     preserve_window_proportions = false,
--     number = false,
--     relativenumber = false,
--     signcolumn = "yes",
--     mappings = {
--       custom_only = false,
--       list = {
--         -- user mappings go here
--       },
--     },
--     float = {
--       enable = false,
--       quit_on_focus_loss = true,
--       open_win_config = {
--         relative = "editor",
--         border = "rounded",
--         width = 30,
--         height = 30,
--         row = 1,
--         col = 1,
--       },
--     },
--   },
--   renderer = {
--     add_trailing = false,
--     group_empty = false,
--     highlight_git = false,
--     full_name = false,
--     highlight_opened_files = "none",
--     root_folder_modifier = ":~",
--     indent_width = 2,
--     indent_markers = {
--       enable = false,
--       inline_arrows = true,
--       icons = {
--         corner = "└",
--         edge = "│",
--         item = "│",
--         bottom = "─",
--         none = " ",
--       },
--     },
--     icons = {
--       webdev_colors = true,
--       git_placement = "before",
--       padding = " ",
--       symlink_arrow = " ➛ ",
--       show = {
--         file = true,
--         folder = true,
--         folder_arrow = true,
--         git = true,
--       },
--       glyphs = {
--         default = "",
--         symlink = "",
--         bookmark = "",
--         folder = {
--           arrow_closed = "",
--           arrow_open = "",
--           default = "",
--           open = "",
--           empty = "",
--           empty_open = "",
--           symlink = "",
--           symlink_open = "",
--         },
--         git = {
--           unstaged = "✗",
--           staged = "✓",
--           unmerged = "",
--           renamed = "➜",
--           untracked = "★",
--           deleted = "",
--           ignored = "◌",
--         },
--       },
--     },
--     special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
--     symlink_destination = true,
--   },
--   hijack_directories = {
--     enable = true,
--     auto_open = true,
--   },
--   update_focused_file = {
--     enable = false,
--     update_root = false,
--     ignore_list = {},
--   },
--   ignore_ft_on_setup = {},
--   system_open = {
--     cmd = "",
--     args = {},
--   },
--   diagnostics = {
--     enable = false,
--     show_on_dirs = false,
--     debounce_delay = 50,
--     icons = {
--       hint = "",
--       info = "",
--       warning = "",
--       error = "",
--     },
--   },
--   filters = {
--     dotfiles = false,
--     custom = {},
--     exclude = {},
--   },
--   filesystem_watchers = {
--     enable = true,
--     debounce_delay = 50,
--   },
--   git = {
--     enable = true,
--     ignore = true,
--     show_on_dirs = true,
--     timeout = 400,
--   },
--   actions = {
--     use_system_clipboard = true,
--     change_dir = {
--       enable = true,
--       global = false,
--       restrict_above_cwd = false,
--     },
--     expand_all = {
--       max_folder_discovery = 300,
--       exclude = {},
--     },
--     file_popup = {
--       open_win_config = {
--         col = 1,
--         row = 1,
--         relative = "cursor",
--         border = "shadow",
--         style = "minimal",
--       },
--     },
--     open_file = {
--       quit_on_open = false,
--       resize_window = true,
--       window_picker = {
--         enable = true,
--         chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
--         exclude = {
--           filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
--           buftype = { "nofile", "terminal", "help" },
--         },
--       },
--     },
--     remove_file = {
--       close_window = true,
--     },
--   },
--   trash = {
--     cmd = "gio trash",
--     require_confirm = true,
--   },
--   live_filter = {
--     prefix = "[FILTER]: ",
--     always_show_folders = true,
--   },
--   log = {
--     enable = false,
--     truncate = false,
--     types = {
--       all = false,
--       config = false,
--       copy_paste = false,
--       dev = false,
--       diagnostics = false,
--       git = false,
--       profile = false,
--       watcher = false,
--     },
--   },
--   notify = {
--     threshold = vim.log.levels.INFO,
--   },
-- } -- END_DEFAULT_OPTS

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.matchup.enable = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false


local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup({
  -- on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'html', 'typescriptreact', 'javascript', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  }
})

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }
lvim.builtin.dap.active = true

local dap = require('dap')
dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = { 'dap', '-l', '127.0.0.1:${port}' },
  }
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  }
}

-- dap.adapters.delve = {
--  type = "server",
--  host = "127.0.0.1",
--  port = 38697,
-- }
-- dlv dap -l 127.0.0.1:38697 --log --log-output="dap"


-- LSP
lvim.lsp.installer.setup.ensure_installed = {
  "sumneko_lua",
  "jsonls",
  "html",
  "cssls",
  "emmet_ls",
  "tsserver",
  "intelephense",
  "tailwindcss",
}

require("lvim.lsp.manager").setup("tailwindcss")


local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "stylua", filetype = { "lua" } },
  { command = "prettier" },
  { command = "blade_formatter", filetype = { "php", "blade", "blade.php" } },
})


-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "ggandor/lightspeed.nvim",
    event = "BufRead",
    config = function()
      require("lightspeed").setup {
        ignore_case = false,
        exit_after_idle_msecs = { unlabeled = 200, labeled = 200 },
        --- s/x ---
        jump_to_unique_chars = { safety_timeout = 400 },
        match_only_the_start_of_same_char_seqs = true,
        force_beacons_into_match_width = false,
        -- Display characters in a custom way in the highlighted matches.
        substitute_chars = { ['\r'] = '¬', },
        -- Leaving the appropriate list empty effectively disables "smart" mode,
        -- and forces auto-jump to be on or off.
        -- safe_labels = { . . . },
        -- labels = { . . . },
        -- These keys are captured directly by the plugin at runtime.
        special_keys = {
          next_match_group = '<space>',
          prev_match_group = '<tab>',
        },
        --- f/t ---
        limit_ft_matches = 4,
        repeat_ft_with_target_char = false,
      }
    end,
  },
  { "leoluz/nvim-dap-go" },
  { "mg979/vim-visual-multi" },
  { "jesseduffield/lazygit" },
  { "nvim-tree/nvim-web-devicons" },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    config = function()
      require("bqf").setup({
        auto_enable = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
        },
        func_map = {
          vsplit = "",
          ptogglemode = "z,",
          stoggleup = "",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        },
      })
    end,
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true, -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      }
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "1.*",
    config = function()
      require("window-picker").setup({
        autoselect_one = true,
        include_current = false,
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal" },
          },
        },
        other_win_hl_color = "#e35e4f",
      })
    end,
  },
  {
    "ahmedkhalf/lsp-rooter.nvim",
    event = "BufRead",
    config = function()
      require("lsp-rooter").setup()
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require('symbols-outline').setup()
    end
  },
  -- {
  --   "Pocco81/auto-save.nvim",
  --   debounce_delay = 1000,
  --   config = function()
  --     require("auto-save").setup()
  --   end,
  -- },
  {
    "metakirby5/codi.vim",
    cmd = "Codi",
  },
  {
    "ellisonleao/glow.nvim",
    ft = { "markdown" },
    config = function() require("glow").setup() end,
    cmd = "Glow"
    -- run = "yay -S glow"
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = "quadratic", -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      })

      local t    = {}
      -- Syntax: t[keys] = {function, {function arguments}}
      -- Use the "sine" easing function
      t['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '150', [['quadratic']] } }
      t['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '150', [['quadratic']] } }
      -- Use the "circular" easing function
      t['<C-b>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '300', [['quadratic']] } }
      t['<C-f>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '300', [['quadratic']] } }
      -- Pass "nil" to disable the easing animation (constant scrolling speed)
      t['<C-y>'] = { 'scroll', { '-0.10', 'false', '100', nil } }
      t['<C-e>'] = { 'scroll', { '0.10', 'false', '100', nil } }
      -- When no easing function is provided the default easing function (in this case "quadratic") will be used
      t['zt']    = { 'zt', { '200' } }
      t['zz']    = { 'zz', { '200' } }
      t['zb']    = { 'zb', { '200' } }

      require('neoscroll.config').set_mappings(t)
    end
  },
  {
    "echasnovski/mini.map",
    branch = "stable",
    config = function()
      require('mini.map').setup()
      local map = require('mini.map')
      map.setup({
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.diagnostic({
            error = 'DiagnosticFloatingError',
            warn  = 'DiagnosticFloatingWarn',
            info  = 'DiagnosticFloatingInfo',
            hint  = 'DiagnosticFloatingHint',
          }),
        },
        symbols = {
          encode = map.gen_encode_symbols.dot('4x2'),
        },
        window = {
          side = 'right',
          width = 10, -- set to 1 for a pure scrollbar :)
          winblend = 15,
          show_integration_count = false,
        },
      })
    end
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    lazy = true,
    --    module = "persistence", deprecated
    config = function()
      require("persistence").setup {
        dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup {
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 400,
          ignore_whitespace = false,
        },
      }
    end
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gblame",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },

  {
    "tpope/vim-surround",

    -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
    -- setup = function()
    --  vim.o.timeoutlen = 500
    -- end
  },
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
--
--
lvim.autocommands = {
  {
    { "BufEnter", "Filetype" },
    {
      desc = "Open mini.map and exclude some filetypes",
      pattern = { "*" },
      callback = function()
        local exclude_ft = {
          "qf",
          "NvimTree",
          "toggleterm",
          "TelescopePrompt",
          "alpha",
          "netrw",
        }

        local map = require('mini.map')
        if vim.tbl_contains(exclude_ft, vim.o.filetype) then
          vim.b.minimap_disable = true
          map.close()
        elseif vim.o.buftype == "" then
          map.open()
        end
      end,
    },
  },
  {
    { "InsertLeave" },
    {
      desc = "Auto Save",
      -- pattern = { "*.go", "*.js", "*.tsx", "*.jsx", "*.java", "*.kt", "*.md", "*.css", "*.html", "*.lua" },
      pattern = { "*.*" },
      command = "w",
    },
  },
}
