require('obsidian').setup({
    workspaces = {
        {
            name = "Vault",
            path = "/home/cameron/1_documents/20-29_admin/21_obsidian-vaults/21.01_Vault",
        },
    },

    daily_notes_dir = "/home/cameron/1_documents/20-29_admin/21_obsidian-vaults/21.01_Vault/100_Journal/110_Daily",
    legacy_commands = false,
})

vim.keymap.set('n', '<leader>of', ':Obsidian follow_link<CR>', {})



-- Commands
--
-- There's one entry point user command for this plugin: Obsidian
--
-- Obsidian<CR> (<enter>) to select sub commands.
-- Obsidian <Tab> to get completion for sub commands.
-- Sub commands are context sensitive, meaning some actions will only appear when:
-- you are in a note.
-- you are in visual mode.
-- See Commands for more info.
--
-- Top level commands
--
-- :Obsidian dailies [OFFSET ...] - open a picker list of daily notes
-- :Obsidian dailies -2 1 to list daily notes from 2 days ago until tomorrow
-- :Obsidian help - find files in the help wiki
-- :Obsidian helpgrep - grep files in the help wiki
-- :Obsidian new [TITLE] - create a new note
-- :Obsidian open [QUERY] - open a note in the Obsidian app
-- query is used to resolve the note to open by ID, path, or alias, else use current note
-- :Obsidian today [OFFSET] - open/create a new daily note
-- offset is in days, e.g. use :Obsidian today -1 to go to yesterday's note.
-- Unlike :Obsidian yesterday and :Obsidian tomorrow this command does not differentiate between weekdays and weekends
-- :Obsidian tomorrow - open/create the daily note for the next working day
-- :Obsidian yesterday - open/create the daily note for the previous working day
-- :Obsidian new_from_template [TITLE] [TEMPLATE] - create a new note with TITLE from a template with the name TEMPLATE
-- both arguments are optional. If not given, the template will be selected from a list using your preferred picker
-- :Obsidian quick_switch - switch to another note in your vault, searching by its name with a picker
-- :Obsidian search [QUERY] - search for (or create) notes in your vault using ripgrep with your preferred picker
-- :Obsidian tags [TAG ...] - get a picker list of all occurrences of the given tags
-- :Obsidian workspace [NAME] - switch to another workspace
--
-- Note commands
--
-- :Obsidian backlinks - get a picker list of references to the current note
-- grr/vim.lsp.buf.references to see references in quickfix list
-- :Obsidian follow_link [STRATEGY] - follow a note reference under the cursor
-- available strategies: vsplit, hsplit, vsplit_force, hsplit_force
-- :Obsidian toc - get a picker list of table of contents for current note
-- :Obsidian template [NAME] - insert a template from the templates folder, selecting from a list using your preferred picker
-- Template
-- :Obsidian links - get a picker list of all links in current note
-- :Obsidian paste_img [IMGNAME] - paste an image from the clipboard into the note at the cursor position by saving it to the vault and adding a markdown image link
-- Images
-- :Obsidian rename [NEWNAME] - rename the note of the current buffer or reference under the cursor, updating all backlinks across the vault
-- runs :wa before renaming, and loads every note with backlinks into your buffer-list
-- after renaming you need to do :wa again for changes to take effect
-- alternatively, call vim.lsp.buf.rename or use grn
-- :Obsidian toggle_checkbox - cycle through checkbox options
--
-- Visual mode commands
--
-- :Obsidian extract_note [TITLE] - extract the visually selected text into a new note and link to it
-- :Obsidian link [QUERY] - link an inline visual selection of text to a note
-- query will be used to resolve the note by ID, path, or alias, else query is selected text
-- :Obsidian link_new [TITLE] - create a new note and link it to an inline visual selection of text
-- if title is not given, selected text is used
