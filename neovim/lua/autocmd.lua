-- Currently, there is no interface to create user commands in Lua. It is planned, though:
-- PR: https://github.com/neovim/neovim/pull/12378

local api = vim.api
local cmd = api.nvim_command

-- Auto save files when focus is lost
-- cmd("au FocusLost * :wa")
-- cmd("au FocusLost * silent! wa")

cmd("au BufNewFile,BufRead .eslintrc,.prettierrc,tsconfig.json setf json")
cmd("au BufNewFile,BufRead .eslintignore,.prettierignore setf conf")

-- Appending the extra file types for vim-snippets to show react snippets
-- Messing with prettier
-- cmd("au BufRead,BufNewFile *.jsx setlocal filetype=javascript.javascriptreact.javascript_react")
-- cmd("au BufRead,BufNewFile *.tsx setlocal filetype=typescript.typescriptreact.javascript_react")

-- Open help vertically and press q to exit
function _G.help_tab()
    if vim.bo.buftype == "help" then
        cmd("wincmd L")
        local nr = api.nvim_get_current_buf()
        api.nvim_buf_set_keymap(nr, "", "q", ":q<CR>", {noremap = true, silent = true})
    end
end
cmd("au BufEnter *.txt lua _G.help_tab()")

-- For highlighting yanked region
cmd('au TextYankPost * silent! lua vim.highlight.on_yank({ higroup = "HighlightedyankRegion", timeout = 120 })')
