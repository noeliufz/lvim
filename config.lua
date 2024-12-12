-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })    -- 设置浮动窗口背景透明
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })    -- 浮动窗口边框透明
vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "NONE" }) -- BufferLine 填充透明
-- key mapings
lvim.builtin.terminal.open_mapping = "<c-/>"
lvim.transparent_window = true

vim.cmd("highlight Breadcrumbs ctermfg=white guifg=None")

vim.defer_fn(function()
  vim.api.nvim_set_hl(0, "WinBarNC", { bg = "none", fg = "none" })
end, 0)

lvim.plugins = {
  { "nvim-telescope/telescope.nvim", },
  { "nvim-lua/plenary.nvim", },
  { "MunifTanjim/nui.nvim", },
  { "nvim-treesitter/nvim-treesitter", },
  { "rcarriga/nvim-notify", },
  { "nvim-tree/nvim-web-devicons", },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    opts = {
      -- configuration goes here
      cn = {
        enabled = true,
      },
      lang = "rust",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = true,
    },
  },
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup({
        transparent_background = true,
        terminal_colors = true,
        devicons = true, -- highlight the icons of `nvim-web-devicons`
        styles = {
          comment = { italic = true },
          keyword = { italic = true },       -- any other keyword
          type = { italic = true },          -- (preferred) int, long, char, etc
          storageclass = { italic = true },  -- static, register, volatile, etc
          structure = { italic = true },     -- struct, union, enum, etc
          parameter = { italic = true },     -- parameter pass in function
          annotation = { italic = true },
          tag_attribute = { italic = true }, -- attribute of tag in reactjs
        },
        filter = "pro",                      -- classic | octagon | pro | machine | ristretto | spectrum
        -- Enable this will disable filter option
        day_night = {
          enable = false,            -- turn off by default
          day_filter = "pro",        -- classic | octagon | pro | machine | ristretto | spectrum
          night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
        },
        inc_search = "background",   -- underline | background
        background_clear = {
          "float_win",
          "toggleterm",
          "telescope",
          "which-key",
          "renamer",
          "notify",
          "nvim-tree",
          "neo-tree",
          "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
        },              -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
        plugins = {
          bufferline = {
            underline_selected = false,
            underline_visible = false,
          },
          indent_blankline = {
            context_highlight = "default", -- default | pro
            context_start_underline = false,
          },
        },
      })
    end
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require('notify').setup({
        background_colour = "#000000",
      })
    end
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
    end
  },
}
lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

lvim.colorscheme = "monokai-pro"
-- 设置 jk 退出插入模式
lvim.keys.insert_mode["jk"] = "<Esc>"

local cmp = require("cmp")
lvim.builtin.cmp.mapping["<CR>"] = cmp.mapping.confirm({ select = true })

-- -- 普通模式下的 Control-s 保存
-- lvim.keys.normal_mode["<C-s>"] = ":w<CR>"

-- -- 插入模式下的 Control-s 保存
lvim.keys.insert_mode["<C-s>"] = "<Esc>:w<CR>"

-- 替换 Control-s 保存文件，避免光标跳动
vim.keymap.set({ "n", "i", "v" }, "<C-s>", function()
  vim.cmd("silent! update") -- 调用静默保存，不显示跳动
end, { desc = "Save file" })

-- Shift + HJKL 切换 Buffer
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>" -- 向左切换 Buffer
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>" -- 向右切换 Buffer
lvim.keys.normal_mode["<S-j>"] = ":BufferLineMoveNext<CR>"  -- 将当前 Buffer 向右移动
lvim.keys.normal_mode["<S-k>"] = ":BufferLineMovePrev<CR>"  -- 将当前 Buffer 向左移动
lvim.builtin.lualine.style = "default"

lvim.format_on_save.enabled = true


-- LeetCode 快捷键映射 for LunarVim
lvim.keys.normal_mode["<leader>kl"] = ":Leet<CR>"
lvim.keys.normal_mode["<leader>kr"] = ":Leet run<CR>"
lvim.keys.normal_mode["<leader>ks"] = ":Leet submit<CR>"
