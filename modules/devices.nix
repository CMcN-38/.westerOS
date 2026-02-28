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

#
#         888                   d8b                           
#         888                   Y8P                           
#         888                                                 
#     .d88888  .d88b.  888  888 888  .d8888b .d88b.  .d8888b  
#    d88" 888 d8P  Y8b 888  888 888 d88P"   d8P  Y8b 88K      
#    888  888 88888888 Y88  88P 888 888     88888888 "Y8888b. 
#    Y88b 888 Y8b.      Y8bd8P  888 Y88b.   Y8b.          X88 
#     "Y88888  "Y8888    Y88P   888  "Y8888P "Y8888   88888P' 
#                                                             

{
    pkgs,
    ...
}: {

#    
#    ▗▄▄▄▖▗▖  ▗▖▗▄▄▖ ▗▖ ▗▖▗▄▄▄▖     ▗▄▖ ▗▖ ▗▖▗▄▄▄▖▗▄▄▖ ▗▖ ▗▖▗▄▄▄▖
#      █  ▐▛▚▖▐▌▐▌ ▐▌▐▌ ▐▌  █      ▐▌ ▐▌▐▌ ▐▌  █  ▐▌ ▐▌▐▌ ▐▌  █  
#      █  ▐▌ ▝▜▌▐▛▀▘ ▐▌ ▐▌  █      ▐▌ ▐▌▐▌ ▐▌  █  ▐▛▀▘ ▐▌ ▐▌  █  
#    ▗▄█▄▖▐▌  ▐▌▐▌   ▝▚▄▞▘  █      ▝▚▄▞▘▝▚▄▞▘  █  ▐▌   ▝▚▄▞▘  █  
#                                                                

    hardware.logitech.wireless = {
        enable = true;
        enableGraphical = true;
    };

    security.rtkit.enable = true;
    services = {
        pulseaudio.extraConfig = "load-module module-device-manager";
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
        };
    };


    environment.systemPackages = with pkgs; [
        hidapi          # C library for HID devices
        # logiops         # Logitech options (not really used anymore)
    ];

    #External Monitor Controls
    hardware.i2c.enable = true;
#
#    ▗▄▄▄ ▗▄▄▖ ▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖ ▗▄▄▖
#    ▐▌  █▐▌ ▐▌  █  ▐▌  ▐▌▐▌   ▐▌   
#    ▐▌  █▐▛▀▚▖  █  ▐▌  ▐▌▐▛▀▀▘ ▝▀▚▖
#    ▐▙▄▄▀▐▌ ▐▌▗▄█▄▖ ▝▚▞▘ ▐▙▄▄▖▗▄▄▞▘
#                                   
    
    # Automount hard drive.
    services.devmon.enable = true; # optional: auto-mount for desktops

    fileSystems."/mnt/hdd" = {
        device = "/dev/disk/by-uuid/8a49d9d1-999f-46b1-b4ea-461f85933795";
        fsType = "ext4";
        options = [ "defaults" "users" "rw" "nofail" "user"];
    };

    # Unsure what these are for so commenting out for the time being.
    # services.udisks2.enable = true;
    # services.udev.extraRules = ''
    #     SUBSYSTEM=="usb", ATTR{idVendor}=="1220", ATTR{idProduct}=="8fe4", TAG+="uaccess"
    #     SUBSYSTEM=="usb", ATTR{idVendor}=="1220", ATTR{idProduct}=="8fe0", TAG+="uaccess"
    # '';
#
#    ▗▄▄▖ ▗▖   ▗▖ ▗▖▗▄▄▄▖▗▄▄▄▖▗▄▖  ▗▄▖▗▄▄▄▖▗▖ ▗▖
#    ▐▌ ▐▌▐▌   ▐▌ ▐▌▐▌     █ ▐▌ ▐▌▐▌ ▐▌ █  ▐▌ ▐▌
#    ▐▛▀▚▖▐▌   ▐▌ ▐▌▐▛▀▀▘  █ ▐▌ ▐▌▐▌ ▐▌ █  ▐▛▀▜▌
#    ▐▙▄▞▘▐▙▄▄▖▝▚▄▞▘▐▙▄▄▖  █ ▝▚▄▞▘▝▚▄▞▘ █  ▐▌ ▐▌
#                                               


    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
    };
    services.blueman.enable = true;
    
    # environment.systemPackages = with pkgs; [
    #     bluez
    # ];
}
