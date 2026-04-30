-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/hannesalbinsson/.cache/nvim/packer_hererocks/2.1.1765228720/share/lua/5.1/?.lua;/Users/hannesalbinsson/.cache/nvim/packer_hererocks/2.1.1765228720/share/lua/5.1/?/init.lua;/Users/hannesalbinsson/.cache/nvim/packer_hererocks/2.1.1765228720/lib/luarocks/rocks-5.1/?.lua;/Users/hannesalbinsson/.cache/nvim/packer_hererocks/2.1.1765228720/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/hannesalbinsson/.cache/nvim/packer_hererocks/2.1.1765228720/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["arctic.nvim"] = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/arctic.nvim",
    url = "https://github.com/rockyzhang24/arctic.nvim"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\n‹\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\31auto_session_suppress_dirs\1\4\0\0\6~\16~/Downloads\6/\1\0\4\31auto_session_suppress_dirs\0\14log_level\nerror\25auto_restore_enabled\2%auto_session_enable_last_session\1\nsetup\17auto-session\frequire\0" },
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["conform.nvim"] = {
    config = { "\27LJ\2\n&\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\1¿\vformat≤\a\1\0\b\0+\00006\0\0\0'\2\1\0B\0\2\0025\1\2\0009\2\3\0005\4!\0005\5\5\0005\6\4\0=\6\6\0055\6\a\0=\6\b\0055\6\t\0=\6\n\0055\6\v\0=\6\f\0055\6\r\0=\6\14\0055\6\15\0=\6\16\0055\6\17\0=\6\18\0055\6\19\0=\6\20\0055\6\21\0=\6\22\0055\6\23\0=\6\24\0055\6\25\0=\6\26\0055\6\27\0=\6\28\0055\6\29\0=\6\30\0055\6\31\0=\6 \5=\5\"\4=\1#\4B\2\2\0016\2$\0009\2%\0029\2&\0025\4'\0'\5(\0003\6)\0005\a*\0B\2\5\0012\0\0ÄK\0\1\0\1\0\1\tdesc*Format file or range (in visual mode)\0\14<leader>f\1\3\0\0\6n\6v\bset\vkeymap\bvim\19format_on_save\21formatters_by_ft\1\0\2\21formatters_by_ft\0\19format_on_save\0\bcpp\1\2\0\0\17clang_format\6c\1\2\0\0\17clang_format\vpython\1\3\0\0\nisort\nblack\blua\1\2\0\0\vstylua\rmarkdown\1\3\0\0\14prettierd\rprettier\tyaml\1\3\0\0\14prettierd\rprettier\tjson\1\3\0\0\14prettierd\rprettier\thtml\1\3\0\0\14prettierd\rprettier\bcss\1\3\0\0\14prettierd\rprettier\vsvelte\1\3\0\0\14prettierd\rprettier\20typescriptreact\1\3\0\0\14prettierd\rprettier\20javascriptreact\1\3\0\0\14prettierd\rprettier\15typescript\1\3\0\0\14prettierd\rprettier\15javascript\1\0\14\15typescript\0\6c\0\blua\0\15javascript\0\bcpp\0\tjson\0\vpython\0\rmarkdown\0\tyaml\0\thtml\0\bcss\0\vsvelte\0\20typescriptreact\0\20javascriptreact\0\1\3\0\0\14prettierd\rprettier\nsetup\1\0\4\21stop_after_first\2\15timeout_ms\3Ù\3\nasync\1\17lsp_fallback\2\fconform\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/opt/conform.nvim",
    url = "https://github.com/stevearc/conform.nvim"
  },
  harpoon = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/harpoon",
    url = "https://github.com/theprimeagen/harpoon"
  },
  ["lsp-zero.nvim"] = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/lsp-zero.nvim",
    url = "https://github.com/VonHeikemen/lsp-zero.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/lush.nvim",
    url = "https://github.com/rktjmp/lush.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\n\v\0\1\1\0\0\0\1K\0\1\0ö\1\1\0\4\0\t\0\0156\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\3\0'\2\4\0B\0\2\0027\0\4\0006\0\4\0009\0\5\0005\2\a\0003\3\6\0=\3\b\2B\0\2\1K\0\1\0\14on_colors\1\0\1\14on_colors\0\0\nsetup\15tokyonight\frequire!colorscheme tokyonight-storm\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  undotree = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-firestore"] = {
    loaded = true,
    path = "/Users/hannesalbinsson/.local/share/nvim/site/pack/packer/start/vim-firestore",
    url = "https://github.com/delphinus/vim-firestore"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\1\1\0\0\0\1K\0\1\0ö\1\1\0\4\0\t\0\0156\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\3\0'\2\4\0B\0\2\0027\0\4\0006\0\4\0009\0\5\0005\2\a\0003\3\6\0=\3\b\2B\0\2\1K\0\1\0\14on_colors\1\0\1\14on_colors\0\0\nsetup\15tokyonight\frequire!colorscheme tokyonight-storm\bcmd\bvim\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\2\n‹\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\31auto_session_suppress_dirs\1\4\0\0\6~\16~/Downloads\6/\1\0\4\31auto_session_suppress_dirs\0\14log_level\nerror\25auto_restore_enabled\2%auto_session_enable_last_session\1\nsetup\17auto-session\frequire\0", "config", "auto-session")
time([[Config for auto-session]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufNewFile * ++once lua require("packer.load")({'conform.nvim'}, { event = "BufNewFile *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'conform.nvim'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
