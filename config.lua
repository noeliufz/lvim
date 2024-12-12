-- [[
-- LunarVim 配置文件
-- 官方文档: https://www.lunarvim.org/docs/configuration
-- 示例配置: https://github.com/LunarVim/starter.lvim
-- 视频教程: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- 技术支持: https://discord.com/invite/Xb9B4Ny
-- ]]

-- [[ 基础配置 ]]
lvim.transparent_window = true         -- 启用窗口透明
lvim.colorscheme = "monokai-pro"       -- 设置主题为 Monokai Pro
lvim.format_on_save.enabled = true     -- 自动格式化文件保存
lvim.builtin.lualine.style = "default" -- 使用默认的状态栏样式

-- [[ 透明背景设置 ]]
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })    -- 浮动窗口背景透明
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })    -- 浮动窗口边框透明
vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "NONE" }) -- BufferLine 背景透明

vim.defer_fn(function()
  vim.api.nvim_set_hl(0, "WinBarNC", { bg = "none", fg = "none" }) -- 非活动窗口标题栏透明
end, 0)

-- [[ 键位映射 ]]
-- 退出插入模式
lvim.keys.insert_mode["jk"] = "<Esc>"

-- 保存文件快捷键，避免跳动
vim.keymap.set({ "n", "i", "v" }, "<C-s>", function()
  vim.cmd("silent! update") -- 静默保存当前文件
end, { desc = "Save file" })

-- 切换 Buffer
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>" -- 向左切换 Buffer
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>" -- 向右切换 Buffer
lvim.keys.normal_mode["<S-j>"] = ":BufferLineMoveNext<CR>"  -- 将当前 Buffer 向右移动
lvim.keys.normal_mode["<S-k>"] = ":BufferLineMovePrev<CR>"  -- 将当前 Buffer 向左移动

-- LeetCode 快捷键
lvim.keys.normal_mode["<leader>kl"] = ":Leet<CR>"        -- 打开 LeetCode 面板
lvim.keys.normal_mode["<leader>kr"] = ":Leet run<CR>"    -- 运行当前题目
lvim.keys.normal_mode["<leader>ks"] = ":Leet submit<CR>" -- 提交当前题目

-- 打开终端快捷键
lvim.builtin.terminal.open_mapping = "<c-/>"

-- [[ 插件配置 ]]
lvim.plugins = {
  { "nvim-telescope/telescope.nvim" },   -- 文件和代码搜索工具
  { "nvim-lua/plenary.nvim" },           -- 提供基础依赖
  { "MunifTanjim/nui.nvim" },            -- UI 支持
  { "nvim-treesitter/nvim-treesitter" }, -- 语法高亮
  { "rcarriga/nvim-notify" },            -- 消息通知
  { "nvim-tree/nvim-web-devicons" },     -- 图标支持

  -- LeetCode 插件
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    opts = {
      cn = { enabled = true }, -- 使用 LeetCode 中文站
      lang = "rust",           -- 默认语言为 Rust
    },
  },

  -- Monokai Pro 配置
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup({
        transparent_background = true, -- 启用透明背景
        styles = {
          comment = { italic = true }, -- 注释字体倾斜
          keyword = { italic = true }, -- 关键字字体倾斜
          type = { italic = true },    -- 类型字体倾斜
        },
        filter = "pro",                -- 使用 Pro 风格
        background_clear = {
          "float_win", "telescope", "nvim-tree", "bufferline",
        },
      })
    end,
  },

  -- 窗口平滑滚动插件
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb' },
        hide_cursor = true, -- 滚动时隐藏光标
      })
    end,
  },

  -- Trouble 插件：用于诊断和快速导航
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },

  -- 通知插件配置
  {
    "rcarriga/nvim-notify",
    config = function()
      require('notify').setup({
        background_colour = "#000000", -- 通知背景颜色
      })
    end,
  },
}

-- [[ Trouble 快捷键配置 ]]
lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics", -- 分组名称
  t = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "Location List" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
}

-- [[ 自动完成设置 ]]
local cmp = require("cmp")
lvim.builtin.cmp.mapping["<CR>"] = cmp.mapping.confirm({ select = true }) -- 回车选择补全项
