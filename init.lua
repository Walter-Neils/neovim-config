
local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file, ...)
    if ____moduleCache[file] then
        return ____moduleCache[file].value
    end
    if ____modules[file] then
        local module = ____modules[file]
        local value = nil
        if (select("#", ...) > 0) then value = module(...) else value = module(file) end
        ____moduleCache[file] = { value = value }
        return value
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["lua.integrations.neovide"] = function(...) 
local ____exports = {}
function ____exports.isNeovideSession()
    return vim.g.neovide ~= nil
end
function ____exports.getNeovideExtendedVimContext()
    return vim
end
return ____exports
 end,
["lua.toggles"] = function(...) 
local ____exports = {}
____exports.CONFIGURATION = {
    useLSPLines = false,
    useCMP = true,
    useTelescope = true,
    useLSPUI = false,
    useRustaceanvim = true,
    useLSPSignature = true,
    useIndentBlankline = true,
    useTreeDevIcons = true,
    useLualine = true,
    useBarBar = true,
    lspconfig = {useInlayHints = false}
}
return ____exports
 end,
["lua.plugins.init"] = function(...) 
local ____exports = {}
local ____toggles = require("lua.toggles")
local CONFIGURATION = ____toggles.CONFIGURATION
function ____exports.getPlugins()
    local result = {}
    result[#result + 1] = require("lua.plugins.nvim-tree").default
    result[#result + 1] = require("lua.plugins.floatterm").default
    if CONFIGURATION.useTelescope then
        result[#result + 1] = require("lua.plugins.telescope").default
    end
    result[#result + 1] = require("lua.plugins.treesitter").default
    result[#result + 1] = require("lua.plugins.lspconfig").default
    result[#result + 1] = require("lua.plugins.mason").default
    result[#result + 1] = require("lua.plugins.autopairs").default
    if CONFIGURATION.useCMP then
        result[#result + 1] = require("lua.plugins.cmp").default
    end
    if CONFIGURATION.useLSPLines then
        result[#result + 1] = require("lua.plugins.lsp_lines").default
    end
    if CONFIGURATION.useLSPUI then
        result[#result + 1] = require("lua.plugins.lspUI").default
    end
    if CONFIGURATION.useRustaceanvim then
        result[#result + 1] = require("lua.plugins.rustaceanvim").default
    end
    result[#result + 1] = require("lua.plugins.tokyonight").default
    if CONFIGURATION.useLSPSignature then
        result[#result + 1] = require("lua.plugins.lsp_signature").default
    end
    if CONFIGURATION.useIndentBlankline then
        result[#result + 1] = require("lua.plugins.indent-blankline").default
    end
    if CONFIGURATION.useTreeDevIcons then
        result[#result + 1] = require("lua.plugins.nvim-tree-devicons").default
    end
    if CONFIGURATION.useLualine then
        result[#result + 1] = require("lua.plugins.lualine").default
    end
    if CONFIGURATION.useBarBar then
        result[#result + 1] = require("lua.plugins.barbar").default
    end
    return result
end
return ____exports
 end,
["lua.theme"] = function(...) 
local ____exports = {}
local function VSCode()
    vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", {bg = "NONE", strikethrough = true, fg = "#808080"})
    vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", {bg = "NONE", strikethrough = true, fg = "#808080"})
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", {bg = "NONE", fg = "#569CD6"})
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", {link = "CmpIntemAbbrMatch"})
    vim.api.nvim_set_hl(0, "CmpItemKindVariable", {bg = "NONE", fg = "#9CDCFE"})
    vim.api.nvim_set_hl(0, "CmpItemKindInterface", {link = "CmpItemKindVariable"})
    vim.api.nvim_set_hl(0, "CmpItemKindText", {link = "CmpItemKindVariable"})
    vim.api.nvim_set_hl(0, "CmpItemKindFunction", {bg = "NONE", fg = "#C586C0"})
    vim.api.nvim_set_hl(0, "CmpItemKindMethod", {link = "CmpItemKindFunction"})
    vim.api.nvim_set_hl(0, "CmpItemKindKeyword", {bg = "NONE", fg = "#D4D4D4"})
    vim.api.nvim_set_hl(0, "CmpItemKindProperty", {link = "CmpItemKindKeyword"})
    vim.api.nvim_set_hl(0, "CmpItemKindUnit", {link = "CmpItemKindKeyword"})
end
local function TokyoNight()
    vim.cmd("colorscheme tokyonight")
end
____exports.THEME_APPLIERS = {VSCode = VSCode, TokyoNight = TokyoNight}
return ____exports
 end,
["main"] = function(...) 
local ____exports = {}
local ____neovide = require("lua.integrations.neovide")
local getNeovideExtendedVimContext = ____neovide.getNeovideExtendedVimContext
local ____init = require("lua.plugins.init")
local getPlugins = ____init.getPlugins
local ____theme = require("lua.theme")
local THEME_APPLIERS = ____theme.THEME_APPLIERS
vim.api.nvim_create_user_command(
    "ResetInstallData",
    function()
        vim.notify("Configuration reset")
    end,
    {}
)
local function setupNeovide()
    local vim = getNeovideExtendedVimContext()
    if vim.g.neovide then
        vim.g.neovide_scale_factor = 0.75
    end
end
local function setupLazy()
    local lazyPath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazyPath) then
        local repo = "https://github.com/folke/lazy.nvim.git"
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            repo,
            "--branch=stable",
            lazyPath
        })
    end
    vim.opt.rtp:prepend(lazyPath)
end
setupNeovide()
setupLazy()
local lazy = require("lazy")
lazy.setup(getPlugins())
THEME_APPLIERS.TokyoNight()
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.ruler = false
require("mappings")
return ____exports
 end,
["lua.helpers.keymap.index"] = function(...) 
local ____exports = {}
function ____exports.applyKeyMapping(map)
    if map.action ~= nil then
        vim.keymap.set(map.mode, map.inputStroke, map.action, map.options)
    else
        vim.keymap.set(map.mode, map.inputStroke, map.outputStroke, map.options)
    end
end
return ____exports
 end,
["mappings"] = function(...) 
local ____exports = {}
local ____keymap = require("lua.helpers.keymap.index")
local applyKeyMapping = ____keymap.applyKeyMapping
local ____toggles = require("lua.toggles")
local CONFIGURATION = ____toggles.CONFIGURATION
vim.g.mapleader = " "
local MOVEMENT_DIRECTION_KEYS = {left = {key = "h", command = "<Left>"}, right = {key = "l", command = "<Right>"}, up = {key = "k", command = "<Up>"}, down = {key = "j", command = "<Down>"}}
for direction in pairs(MOVEMENT_DIRECTION_KEYS) do
    local key = MOVEMENT_DIRECTION_KEYS[direction]
    applyKeyMapping({mode = "i", inputStroke = ("<C-" .. key.key) .. ">", outputStroke = key.command, options = {desc = "move " .. direction}})
end
for direction in pairs(MOVEMENT_DIRECTION_KEYS) do
    local key = MOVEMENT_DIRECTION_KEYS[direction]
    applyKeyMapping({mode = "n", inputStroke = ("<C-" .. key.key) .. ">", outputStroke = "<C-w>" .. key.key, options = {desc = "switch window " .. direction}})
end
if not CONFIGURATION.useBarBar then
    applyKeyMapping({mode = "n", inputStroke = "<A-h>", outputStroke = "<cmd>:bprev <CR>", options = {desc = "previous buffer"}})
    applyKeyMapping({mode = "n", inputStroke = "<A-l>", outputStroke = "<cmd>:bnext <CR>", options = {desc = "next buffer"}})
else
    applyKeyMapping({mode = "n", inputStroke = "<A-h>", outputStroke = "<cmd>:BufferPrevious <CR>", options = {desc = "previous buffer"}})
    applyKeyMapping({mode = "n", inputStroke = "<A-l>", outputStroke = "<cmd>:BufferNext <CR>", options = {desc = "next buffer"}})
end
applyKeyMapping({mode = "n", inputStroke = "<Esc>", outputStroke = "<cmd>noh<CR>", options = {desc = "general clear highlights"}})
applyKeyMapping({mode = "n", inputStroke = "<leader>x", outputStroke = "<cmd>:bd<CR>:bnext<CR>", options = {desc = "Close current buffer"}})
applyKeyMapping({mode = "n", inputStroke = "<C-n>", outputStroke = "<cmd>NvimTreeToggle<CR>", options = {desc = "toggle file tree"}})
for ____, mode in ipairs({"n", "i", "t"}) do
    applyKeyMapping({mode = mode, inputStroke = "<A-i>", outputStroke = "<cmd>FloatermToggle __builtin_floating<CR>", options = {desc = "toggle floating terminal"}})
end
applyKeyMapping({mode = "t", inputStroke = "<A-h>", outputStroke = "<cmd>FloatermPrev<CR>", options = {desc = "terminal previous terminal"}})
applyKeyMapping({mode = "t", inputStroke = "<A-l>", outputStroke = "<cmd>FloatermNext<CR>", options = {desc = "terminal next terminal"}})
applyKeyMapping({mode = "t", inputStroke = "<A-n>", outputStroke = "<cmd>FloatermNew<CR>", options = {desc = "terminal new terminal"}})
applyKeyMapping({mode = "t", inputStroke = "<A-k>", outputStroke = "<cmd>FloatermKill<CR>", options = {desc = "terminal new terminal"}})
applyKeyMapping({mode = "t", inputStroke = "<C-x>", outputStroke = "<C-\\><C-N>", options = {desc = "terminal escape terminal mode"}})
if CONFIGURATION.useTelescope then
    applyKeyMapping({mode = "n", inputStroke = "<leader>ff", outputStroke = "<cmd>Telescope find_files <CR>", options = {desc = "Find files"}})
    applyKeyMapping({mode = "n", inputStroke = "<leader>fw", outputStroke = "<cmd>Telescope live_grep <CR>", options = {desc = "Live grep"}})
    applyKeyMapping({mode = "n", inputStroke = "<leader>fb", outputStroke = "<cmd>Telescope buffers <CR>", options = {desc = "Find buffers"}})
    applyKeyMapping({mode = "n", inputStroke = "<leader>cm", outputStroke = "<cmd>Telescope git_commits <CR>", options = {desc = "Git commits"}})
    applyKeyMapping({mode = "n", inputStroke = "<leader>gt", outputStroke = "<cmd>Telescope git_status <CR>", options = {desc = "Git status"}})
    applyKeyMapping({mode = "n", inputStroke = "<leader>fz", outputStroke = "<cmd>Telescope current_buffer_fuzzy_find <CR>", options = {desc = "Find in current buffer"}})
end
applyKeyMapping({
    mode = "n",
    inputStroke = "<leader>fm",
    action = function()
        vim.lsp.buf.format({async = true})
    end,
    options = {desc = "LSP Formatting"}
})
applyKeyMapping({
    mode = "n",
    inputStroke = ",",
    action = function()
        vim.lsp.buf.signature_help()
    end,
    options = {desc = "Toggle inlay hints"}
})
if CONFIGURATION.useBarBar then
    applyKeyMapping({mode = "n", inputStroke = "<Tab>", outputStroke = "<cmd>:bnext<CR>", options = {desc = "Switch next buffer"}})
end
return ____exports
 end,
["lua.plugins.autopairs"] = function(...) 
local ____exports = {}
local plugin = {[1] = "windwp/nvim-autopairs", event = "InsertEnter", config = true}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.barbar"] = function(...) 
local ____exports = {}
local plugin = {
    [1] = "romgrk/barbar.nvim",
    dependencies = {"lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons"},
    init = function()
        vim.g.barbar_auto_setup = false
    end,
    opts = {animation = true, insert_at_start = true}
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.cmp"] = function(...) 
local ____exports = {}
local KIND_ICONS = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲"
}
function ____exports.getCMP()
    local target = "cmp"
    local cmp = require(target)
    return cmp
end
local plugin = {
    [1] = "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "neovim/nvim-lspconfig",
        "onsails/lspkind.nvim",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip"
    },
    config = function()
        local cmp = ____exports.getCMP()
        cmp.setup({
            window = {completion = {winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None", col_offset = -3, side_padding = 0}},
            formatting = {format = function(_entry, vim_item)
                local icons = KIND_ICONS
                local icon = icons[vim_item.kind]
                icon = (" " .. icon) .. " "
                vim_item.menu = ("  (" .. tostring(vim_item.kind)) .. ")  "
                vim_item.kind = string.format("%s %s", icon, vim_item.kind)
                return vim_item
            end},
            snippet = {expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end},
            sources = cmp.config.sources({{name = "nvim_lsp"}}),
            mapping = {
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(1),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({select = false})
            }
        })
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.floatterm"] = function(...) 
local ____exports = {}
local plugin = {[1] = "voldikss/vim-floaterm", cmd = {"FloatermNew", "FloatermToggle", "FloatermShow", "FloatermHide"}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.indent-blankline"] = function(...) 
local ____exports = {}
local plugin = {
    [1] = "lukas-reineke/indent-blankline.nvim",
    version = "^3",
    config = function()
        local target = "ibl"
        local ibl = require(target)
        ibl.setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lspUI"] = function(...) 
local ____exports = {}
local plugin = {
    [1] = "jinzhongjia/LspUI.nvim",
    branch = "main",
    event = "VeryLazy",
    config = function()
        local target = "LspUI"
        local lspUI = require(target)
        lspUI.setup({inlay_hint = {enable = false}})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lsp_lines"] = function(...) 
local ____exports = {}
local plugin = {
    [1] = "ErichDonGubler/lsp_lines.nvim",
    event = "VimEnter",
    config = function()
        local target = "lsp_lines"
        require(target).setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lsp_signature"] = function(...) 
local ____exports = {}
local plugin = {
    [1] = "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
        local target = "lsp_signature"
        local lsp_signature = require(target)
        lsp_signature.setup(opts)
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lspconfig"] = function(...) 
local ____exports = {}
local on_attach, configureLSP
local ____toggles = require("lua.toggles")
local CONFIGURATION = ____toggles.CONFIGURATION
function on_attach(client, bufnr)
    if CONFIGURATION.lspconfig.useInlayHints then
        local ____error
        do
            local function ____catch(e)
                ____error = e
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                if client.server_capabilities.inlayHintProvider then
                    if vim.lsp.buf.inlay_hint == nil then
                        vim.notify("Failed to enable inlay hints: neovim builtin inlay_hints unavailable")
                    else
                        vim.lsp.buf.inlay_hint.enable(true, {bufnr = bufnr})
                    end
                    return true
                end
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
        vim.notify("Failed to enable LSP hints: " .. tostring(____error))
    end
end
function configureLSP()
    local target = "lspconfig"
    local lspconfig = require(target)
    local capabilities
    if CONFIGURATION.useCMP then
        local target = "cmp_nvim_lsp"
        capabilities = require(target).default_capabilities()
    end
    lspconfig.tsserver.setup({capabilities = capabilities, on_attach = on_attach})
    lspconfig.lua_ls.setup({capabilities = capabilities, on_attach = on_attach})
    vim.diagnostic.config({update_in_insert = true, virtual_text = not CONFIGURATION.useLSPLines})
end
local plugin = {[1] = "neovim/nvim-lspconfig", config = configureLSP}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lualine"] = function(...) 
local ____exports = {}
local plugin = {
    [1] = "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        local target = "lualine"
        local module = require(target)
        module.setup({options = {theme = "material"}})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.mason"] = function(...) 
local ____exports = {}
local plugin = {
    [1] = "williamboman/mason.nvim",
    config = function()
        local target = "mason"
        require(target).setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.nvim-tree-devicons"] = function(...) 
local ____exports = {}
local plugin = {
    [1] = "nvim-tree/nvim-web-devicons",
    config = function()
        local target = "nvim-web-devicons"
        local module = require(target)
        module.setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.nvim-tree"] = function(...) 
local ____exports = {}
local plugin = {
    [1] = "nvim-tree/nvim-tree.lua",
    cmd = {"NvimTreeToggle", "NvimTreeFocus"},
    opts = function()
        local options = {
            filters = {
                dotfiles = false,
                exclude = {vim.fn.stdpath("config") .. "/lua/custom"}
            },
            disable_netrw = true,
            hijack_netrw = true,
            hijack_cursor = true,
            hijack_unnamed_buffer_when_opening = false,
            sync_root_with_cwd = true,
            update_focused_file = {enable = true, update_root = false},
            view = {adaptive_size = false, side = "left", width = 30, preserve_window_proportions = true},
            git = {enable = false, ignore = true},
            filesystem_watchers = {enable = true},
            actions = {open_file = {resize_window = true}},
            renderer = {
                root_folder_label = false,
                highlight_git = false,
                highlight_opened_files = "none",
                indent_markers = {enable = false},
                icons = {show = {file = true, folder = true, folder_arrow = true, git = false}, glyphs = {default = "󰈚", symlink = "", folder = {
                    default = "",
                    empty = "",
                    empty_open = "",
                    open = "",
                    symlink = "",
                    symlink_open = "",
                    arrow_open = "",
                    arrow_closed = ""
                }, git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌"
                }}}
            }
        }
        return options
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.rustaceanvim"] = function(...) 
local ____exports = {}
local plugin = {
    [1] = "mrcjkb/rustaceanvim",
    version = "^3",
    ft = {"rust"},
    dependencies = {"nvim-lua/plenary.nvim", "mfussenegger/nvim-dap"},
    config = function()
        vim.g.rustaceanvim = {
            tools = {hover_actions = {auto_focus = true}},
            server = {on_attach = function(client, bufnr)
                vim.notify("rustaceanvim attached")
            end}
        }
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.telescope"] = function(...) 
local ____exports = {}
local plugin = {[1] = "nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim"}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.tokyonight"] = function(...) 
local ____exports = {}
local plugin = {[1] = "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.treesitter"] = function(...) 
local ____exports = {}
local plugin = {[1] = "nvim-treesitter/nvim-treesitter"}
____exports.default = plugin
return ____exports
 end,
}
return require("main", ...)
