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
  ...
}: {
#     ▗▄▄▖▗▄▄▄▖▗▄▖ ▗▄▄▖  ▗▄▄▖▗▖ ▗▖▗▄▄▄▖▗▄▄▖ 
#    ▐▌     █ ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌ ▐▌  █  ▐▌ ▐▌
#     ▝▀▚▖  █ ▐▛▀▜▌▐▛▀▚▖ ▝▀▚▖▐▛▀▜▌  █  ▐▛▀▘ 
#    ▗▄▄▞▘  █ ▐▌ ▐▌▐▌ ▐▌▗▄▄▞▘▐▌ ▐▌▗▄█▄▖▐▌   
#                                           
    programs.starship = {
        enable = true;
        settings = {
            # Sets user-defined palette
            # palette = "catppuccin_mocha";

            character = {
                # Note the use of Catppuccin color 'maroon'
                success_symbol = "[[♥](green) ❯](maroon)";
                error_symbol = "[❯](red)";
                vimcmd_symbol = "[❮](green)";
            };
            directory = {
                truncation_length = 4;
                # Catppuccin 'lavender'
                style = "bold lavender";
            };
            # palette tables should be last in the config ⚓️

            palettes.catppuccin_mocha = {
                rosewater = "#f5e0dc";
                flamingo = "#f2cdcd";
                pink = "#f5c2e7";
                mauve = "#cba6f7";
                red = "#f38ba8";
                maroon = "#eba0ac";
                peach = "#fab387";
                yellow = "#f9e2af";
                green = "#a6e3a1";
                teal = "#94e2d5";
                sky = "#89dceb";
                sapphire = "#74c7ec";
                blue = "#89b4fa";
                lavender = "#b4befe";
                text = "#cdd6f4";
                subtext1 = "#bac2de";
                subtext0 = "#a6adc8";
                overlay2 = "#9399b2";
                overlay1 = "#7f849c";
                overlay0 = "#6c7086";
                surface2 = "#585b70";
                surface1 = "#45475a";
                surface0 = "#313244";
                base = "#1e1e2e";
                mantle = "#181825";
                crust = "#11111b";
            };
        };
    };
}
