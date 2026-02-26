-- vim.keymap.set('i', '<C-S>', 'copilot#Accept("\\<CR>")', {
--         expr = true,
--         replace_keycodes = false,
-- })
-- vim.g.copilot_no_tab_map = true
-- vim.keymap.set('n', '<leader>cpe', ':Copilot enable<CR>')
-- vim.keymap.set('n', '<leader>cpd', ':Copilot disable<CR>')

require("claudecode").setup()

-- Claude Code: Toggle and Send
vim.keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<CR>', { desc = 'Toggle Claude Code' })
vim.keymap.set('v', '<leader>cc', ':ClaudeCodeSend<CR>', { desc = 'Send selection to Claude'})

-- Claude Code: Quick Actions (visual mode)
vim.keymap.set('v', '<leader>ce', ':ClaudeCodeSend Explain this code<CR>', { desc = 'Explain code' })
vim.keymap.set('v', '<leader>cf', ':ClaudeCodeSend Fix and improve this code<CR>', { desc = 'Fix/refactor code' })
vim.keymap.set('v', '<leader>ct', ':ClaudeCodeSend Write tests for this code<CR>', { desc = 'Generate tests' })
vim.keymap.set('v', '<leader>cd', ':ClaudeCodeSend Add documentation for this code<CR>', { desc = 'Generate docs' })
vim.keymap.set('v', '<leader>cr', ':ClaudeCodeSend Review this code for issues<CR>', { desc = 'Review code' })

-- Claude Code: Send Context (normal mode)
vim.keymap.set('n', '<leader>cw', ':ClaudeCodeSendFile<CR>', { desc = 'Send whole file to Claude' })
vim.keymap.set('n', '<leader>cp', 'vip:ClaudeCodeSend<CR>', { desc = 'Send paragraph to Claude' })

-- Claude Code: Terminal Mode Navigation
vim.keymap.set("t", "<leader>cc", [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
vim.keymap.set("t", "<leader>h", [[<C-\><C-n><C-w>h]], { desc = 'Navigate to left window' })
vim.keymap.set("n", "<leader>h", [[<C-\><C-n><C-w>h]], { desc = 'Navigate to left window' })
vim.keymap.set("t", "<C-w>j", [[<C-\><C-n><C-w>j]], { desc = 'Navigate to bottom window' })
vim.keymap.set("t", "<C-w>k", [[<C-\><C-n><C-w>k]], { desc = 'Navigate to top window' })
vim.keymap.set("t", "<leader>l", [[<C-\><C-n><C-w>l]], { desc = 'Navigate to right window' })
vim.keymap.set("l", "<leader>l", [[<C-\><C-n><C-w>l]], { desc = 'Navigate to right window' })

