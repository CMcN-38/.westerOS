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
#             888             888          
#             888             888          
#             888             888          
#    .d8888b  888888 888  888 888  .d88b.  
#    88K      888    888  888 888 d8P  Y8b 
#    "Y8888b. 888    888  888 888 88888888 
#         X88 Y88b.  Y88b 888 888 Y8b.     
#     88888P'  "Y888  "Y88888 888  "Y8888  
#                         888              
#                    Y8b d88P              
#                     "Y88P"               

{
    pkgs,
    config,
    lib,
    inputs,
    ...
}: {

    home-manager = {
        users.cameron ={
            imports = [
                ../hosts/${config.networking.hostName}/home-configuration.nix
                    inputs.stylix.homeManagerModules.stylix 
            ];

            stylix = {
                enable = true;
                targets.kitty.enable = false;

                base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

                cursor = {
                    package = pkgs.bibata-cursors;
                    name = "Bibata-Modern-Ice";
                    size = 24;
                };

                icons = {
                    # name = "Papirus-Dark";
                    package = pkgs.catppuccin-papirus-folders.override {
                        flavor = "mocha";
                        accent = "pink";
                    };
                };

                fonts = {
                    monospace = {
                        name = "FiraCode Nerd Font";
                        package = pkgs.nerd-fonts.fira-code;
                    };

                    sizes = {
                        terminal = 12;
                        applications = 12;
                        desktop = 12;
                        popups = 12;
                    };
                };
            };

            gtk.iconTheme = lib.mkForce {
                name = "Papirus-Dark";
                package = pkgs.catppuccin-papirus-folders.override {
                    flavor = "mocha";
                    accent = "pink";
                };
            };
        };
    };

}
