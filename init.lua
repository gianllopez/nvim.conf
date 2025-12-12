-- This file is the entry point of the configuration.
-- It loads the core options, event handlers, and bootstraps the plugin manager in the correct order.
-- by @gianllopez (2025)

-- [`gianllopez/neovim.conf`]
require("config.options")
require("config.autocmds")

-- [`folke/lazy.nvim`]
require("config.lazy")
