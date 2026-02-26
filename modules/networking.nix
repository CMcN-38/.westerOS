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


#                      888                                   888      d8b                   
#                      888                                   888      Y8P                   
#                      888                                   888                            
#    88888b.   .d88b.  888888 888  888  888  .d88b.  888d888 888  888 888 88888b.   .d88b.  
#    888 "88b d8P  Y8b 888    888  888  888 d88""88b 888P"   888 .88P 888 888 "88b d88P"88b 
#    888  888 88888888 888    888  888  888 888  888 888     888888K  888 888  888 888  888 
#    888  888 Y8b.     Y88b.  Y88b 888 d88P Y88..88P 888     888 "88b 888 888  888 Y88b 888 
#    888  888  "Y8888   "Y888  "Y8888888P"   "Y88P"  888     888  888 888 888  888  "Y88888 
#                                                                                       888 
#                                                                                  Y8b d88P 
#                                                                                   "Y88P"  

{
    config,
    ...
}: {

#    
#    ▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▄▄▄▖▗▄▄▖ ▗▄▄▄▖ ▗▄▖  ▗▄▄▖▗▄▄▄▖ ▗▄▄▖
#      █  ▐▛▚▖▐▌  █  ▐▌   ▐▌ ▐▌▐▌   ▐▌ ▐▌▐▌   ▐▌   ▐▌   
#      █  ▐▌ ▝▜▌  █  ▐▛▀▀▘▐▛▀▚▖▐▛▀▀▘▐▛▀▜▌▐▌   ▐▛▀▀▘ ▝▀▚▖
#    ▗▄█▄▖▐▌  ▐▌  █  ▐▙▄▄▖▐▌ ▐▌▐▌   ▐▌ ▐▌▝▚▄▄▖▐▙▄▄▖▗▄▄▞▘
#                                                       
    networking = {
        hostName = "targaryen";
        
        # Configure the IP address
        networkmanager.enable = true;
        useDHCP = false;
        interfaces.wlp2s0.ipv4.addresses = [{
            address = "192.168.0.114";
            prefixLength = 24;
        }];
        defaultGateway = "192.168.4.1";
        nameservers = ["8.8.8.8"];

        # Enable the firewall but open necessary ports for tailscale, ssh, and transmission.
        firewall = {
            enable = true;
            trustedInterfaces = ["tailscale0"];
            allowedUDPPorts = [config.services.tailscale.port 47392];
            allowedTCPPorts = [22 47392 8080];
        };
    };

    services.tailscale.enable = true;

#
#     ▗▄▄▖ ▗▄▄▖▗▖ ▗▖
#    ▐▌   ▐▌   ▐▌ ▐▌
#     ▝▀▚▖ ▝▀▚▖▐▛▀▜▌
#    ▗▄▄▞▘▗▄▄▞▘▐▌ ▐▌
#                   
    services.openssh = {
        enable = true;
        settings.PubkeyAuthentication = true;
        settings.PasswordAuthentication = true; # Ideally this would be false but due to Blink bugs, necessary.
    };

    programs.ssh = {
        extraConfig = "
            Host stark
                Hostname 192.168.4.96
                Port 22
                User cameron
            Host lannister
                Hostname 192.168.4.121
                Port 22
                User cameron
        ";
    };

}

