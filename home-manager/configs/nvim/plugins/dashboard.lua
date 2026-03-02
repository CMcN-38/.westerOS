require('dashboard').setup{
        theme = 'hyper',
        hide ={
                statusline,
                tabline,
                winbar
        },
        config = {
                week_header = {
                        enable = true,
                },
                shortcut = {
                        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                        {
                                icon = ' ',
                                icon_hl = '@variable',
                                desc = 'Files',
                                group = 'Label',
                                action = 'Telescope find_files',
                                key = 'f',
                        },
                        {
                                icon = ' ',
                                icon_hl = '@variable',
                                desc = 'Grep',
                                group = 'Label',
                                action = 'Telescope live_grep',
                                key = 'g',
                        },
                        {
                                desc = ' Obsidian home',
                                group = 'Number',
                                action = 'Neotree /home/cameron/1_documents/20-29_admin/21_obsidian-vaults/21.01_Vault',
                                key = 'o',
                        },
                        {
                                desc = ' Obsidian Today',
                                group = 'Number',
                                action = 'Obsidian today',
                                key = 't',
                        },
                },
        },
}
