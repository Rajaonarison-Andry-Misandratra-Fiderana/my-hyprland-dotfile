local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Safe require helper
local function safe_require(mod)
    local ok, res = pcall(require, mod)
    if not ok then
        vim.notify(string.format("Error requiring module '%s': %s", mod, tostring(res)), vim.log.levels.ERROR)
        return nil
    end
    return res
end

-- Collect plugin specs from lua/plugins/*.lua
local specs = {}
local plugin_dir = fn.stdpath("config") .. "/lua/plugins"
local files = fn.globpath(plugin_dir, "*.lua", false, true)

-- helper for list extend
if not vim.list_extend then
    vim.list_extend = function(a, b)
        for _, v in ipairs(b) do
            table.insert(a, v)
        end
        return a
    end
end

for _, filepath in ipairs(files) do
    local name = fn.fnamemodify(filepath, ":t:r")
    local module = "plugins." .. name
    local mod = safe_require(module)
    if mod then
        if type(mod) == "table" then
            if mod[1] ~= nil then
                vim.list_extend(specs, mod)
            else
                table.insert(specs, mod)
            end
        else
            vim.notify(string.format("Plugin module '%s' did not return a table", module), vim.log.levels.WARN)
        end
    end
end

-- Normalize: wrap string config fields into functions that require the module
for _, spec in ipairs(specs) do
    if type(spec) == "table" and type(spec.config) == "string" then
        local cfg_mod = spec.config
        spec.config = function()
            local ok, m = pcall(require, cfg_mod)
            if not ok then
                vim.notify(string.format("Failed to load config module '%s' for plugin '%s'", cfg_mod, tostring(spec[1] or "?")), vim.log.levels.ERROR)
                return
            end
            if type(m) == "function" then
                pcall(m)
            elseif type(m) == "table" and type(m.setup) == "function" then
                pcall(m.setup, m.opts or {})
            end
        end
    end
end

-- Finally setup lazy with collected specs
require("lazy").setup({
    spec = {
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        { import = "plugins" },
    },
    defaults = { lazy = true, version = false },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = false, notify = false },
    performance = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } },
})
