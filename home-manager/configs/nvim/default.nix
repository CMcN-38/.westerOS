#                                     .x+=:.        s                                    ....                ...         
#      x=~                           z`    ^%      :8                                .x~X88888Hx.        .x888888hx    : 
#     88x.   .e.   .e.                  .   <k    .88                  .u    .      H8X 888888888h.     d88888888888hxx  
#    '8888X.x888:.x888       .u       .@8Ned8"   :888ooo      .u     .d88B :@8c    8888:`*888888888:   8" ... `"*8888%`  
#     `8888  888X '888k   ud8888.   .@^%8888"  -*8888888   ud8888.  ="8888f8888r   88888:        `%8  !  "   ` .xnxx.    
#      X888  888X  888X :888'8888. x88:  `)8b.   8888    :888'8888.   4888>'88"  . `88888          ?> X X   .H8888888%:  
#      X888  888X  888X d888 '88%" 8888N=*8888   8888    d888 '88%"   4888> '    `. ?888%           X X 'hn8888888*"   > 
#      X888  888X  888X 8888.+"     %8"    R88   8888    8888.+"      4888>        ~*??.            > X: `*88888%`     ! 
#     .X888  888X. 888~ 8888L        @8Wou 9%   .8888Lu= 8888L       .d888L .+    .x88888h.        <  '8h.. ``     ..x8> 
#     `%88%``"*888Y"    '8888c. .+ .888888P`    ^%888*   '8888c. .+  ^"8888*"    :"""8888888x..  .x    `88888888888888f  
#       `~     `"        "88888%   `   ^"F        'Y"     "88888%       "Y"      `    `*888888888"      '%8888888888*"   
#                          "YP'                             "YP'                         ""***""           ^"****""`     
#                                                                                                                        
#    888                                                                                                                
#    888                                                                                                                
#    888                                                                                                                
#    88888b.   .d88b.  88888b.d88b.   .d88b.         88888b.d88b.   8888b.  88888b.   8888b.   .d88b.   .d88b.  888d888 
#    888 "88b d88""88b 888 "888 "88b d8P  Y8b        888 "888 "88b     "88b 888 "88b     "88b d88P"88b d8P  Y8b 888P"   
#    888  888 888  888 888  888  888 88888888 888888 888  888  888 .d888888 888  888 .d888888 888  888 88888888 888     
#    888  888 Y88..88P 888  888  888 Y8b.            888  888  888 888  888 888  888 888  888 Y88b 888 Y8b.     888     
#    888  888  "Y88P"  888  888  888  "Y8888         888  888  888 "Y888888 888  888 "Y888888  "Y88888  "Y8888  888     
#                                                                                                  888                  
#                                                                                             Y8b d88P                  
#                                                                                              "Y88P"                   
{
  pkgs,
  ...
}: {
#    ▗▖  ▗▖▗▄▄▄▖ ▗▄▖ ▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖
#    ▐▛▚▖▐▌▐▌   ▐▌ ▐▌▐▌  ▐▌  █  ▐▛▚▞▜▌
#    ▐▌ ▝▜▌▐▛▀▀▘▐▌ ▐▌▐▌  ▐▌  █  ▐▌  ▐▌
#    ▐▌  ▐▌▐▙▄▄▖▝▚▄▞▘ ▝▚▞▘ ▗▄█▄▖▐▌  ▐▌
#                                     
    programs.neovim = {
        enable = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        package = pkgs.neovim-unwrapped;
        plugins = with pkgs.vimPlugins; [
            mini-nvim

                catppuccin-nvim
                colorizer

                cmp-nvim-lsp
                friendly-snippets
                cmp-buffer
                fidget-nvim
                cmp_luasnip
                luasnip
                nvim-cmp

                snacks-nvim
                claudecode-nvim

                dashboard-nvim
                nvim-web-devicons

                indent-blankline-nvim

                mason-nvim
                mason-lspconfig-nvim
                nvim-lspconfig

                neo-tree-nvim
                plenary-nvim
                nui-nvim

                none-ls-nvim

                telescope-nvim
                telescope-ui-select-nvim

                todo-comments-nvim

                nvim-treesitter.withAllGrammars

                comment-nvim
                vim-be-good

                which-key-nvim
                harpoon2
                ];

        extraPackages = with pkgs; [
            lua-language-server
            rust-analyzer
        ];

        extraLuaConfig = ''
            ${builtins.readFile ./options.lua}
        ${builtins.readFile ./plugins/treesitter.lua}
        ${builtins.readFile ./plugins/neotree.lua}
        ${builtins.readFile ./plugins/comment.lua}
        ${builtins.readFile ./plugins/colours.lua}
        ${builtins.readFile ./plugins/completion.lua}
        ${builtins.readFile ./plugins/copilot.lua}
        ${builtins.readFile ./plugins/dashboard.lua}
        ${builtins.readFile ./plugins/indent-blankline.lua}
        ${builtins.readFile ./plugins/lsp-config.lua}
        ${builtins.readFile ./plugins/mini.lua}
        ${builtins.readFile ./plugins/none-ls.lua}
        ${builtins.readFile ./plugins/telescope.lua}
        ${builtins.readFile ./plugins/harpoon.lua}
        vim.diagnostic.config({
                virtual_text = true,   -- 🔥 enable inline text
                signs = true,          -- keep gutter signs
                update_in_insert = false,
                })
        '';
    };
}
