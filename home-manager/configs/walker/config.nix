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
#    ▗▖ ▗▖ ▗▄▖ ▗▖   ▗▖ ▗▖▗▄▄▄▖▗▄▄▖ 
#    ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌▗▞▘▐▌   ▐▌ ▐▌
#    ▐▌ ▐▌▐▛▀▜▌▐▌   ▐▛▚▖ ▐▛▀▀▘▐▛▀▚▖
#    ▐▙█▟▌▐▌ ▐▌▐▙▄▄▖▐▌ ▐▌▐▙▄▄▖▐▌ ▐▌
#                                  
    programs.walker = {
        enable = true;
        runAsService = true;

        config = {
            force_keyboard_focus = true;
            selection_wrap = true;
            theme = "westerOS_default";
            hide_action_hints = true;
            # additional_theme_location = "~/.westerOS/home-manager/themes/catppuccin/walker/";

            placeholders."default" = { input = " Search..."; list = "No Results"; };
            columns."symbols" = 1;
            providers.prefixes = [
            {provider = "providerlist"; prefix = "/";}
            {provider = "files"; prefix = ".";}
            {provider = "symbols"; prefix = ":";}
            {provider = "calc"; prefix = "=";}
            {provider = "websearch"; prefix = "@";}
            {provider = "clipboard"; prefix = "$";}
            ];
            providers.max_results = 256;
            providers."default" = ["desktopapplications" "websearch"];
            # emergencies = {text = "Restart Walker"; command = "westerOS_restart-walker"; };
            keybinds.quick_activate = [];
        };

        themes = {
            "westerOS_default" = {
                style = "

@define-color window_bg_color #1f1f28;
@define-color accent_bg_color #54546d;
@define-color theme_fg_color #f2ecbc;
@define-color error_bg_color #C34043;
@define-color error_fg_color #DCD7BA;

* {
  all: unset;
}

* {
  font-family: monospace;
  font-size: 18px;
  color: @text;
}

scrollbar {
  opacity: 0;
}

window {
  background: transparent;
}

.normal-icons {
  -gtk-icon-size: 16px;
}

.large-icons {
  -gtk-icon-size: 32px;
}

.box-wrapper {
  background: alpha(@base, 0.95);
  padding: 20px;
  border: 2px solid @border;
}

.preview-box {
}

.box {
}

.search-container {
  background: @base;
  padding: 10px;
}

.input placeholder {
  opacity: 0.5;
}

.input {
}

.input:focus,
.input:active {
  box-shadow: none;
  outline: none;
}

.content-container {
}

.placeholder {
}

.scroll {
}

.list {
}

child,
child > * {
}

child:hover .item-box {
}

child:selected .item-box {
}

child:selected .item-box * {
  color: @selected-text;
}

.item-box {
  padding-left: 14px;
}

.item-text-box {
  all: unset;
  padding: 14px 0;
}

.item-text {
}

.item-subtext {
  font-size: 0px;
  min-height: 0px;
  margin: 0px;
  padding: 0px;
}

.item-image {
  margin-right: 14px;
  -gtk-icon-transform: scale(0.9);
}

.current {
  font-style: italic;
}

.keybind-hints {
  background: @background;
  padding: 10px;
  margin-top: 10px;
}

.preview {
}
                ";

                layouts = {
                    "layout" = ''
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <requires lib="gtk" version="4.0"></requires>
  <object class="GtkWindow" id="Window">
    <style>
      <class name="window"></class>
    </style>
    <property name="resizable">true</property>
    <property name="title">Walker</property>
    <child>
      <object class="GtkBox" id="BoxWrapper">
        <style>
          <class name="box-wrapper"></class>
        </style>
        <property name="width-request">644</property>
        <property name="overflow">hidden</property>
        <property name="orientation">horizontal</property>
        <property name="valign">center</property>
        <property name="halign">center</property>
        <child>
          <object class="GtkBox" id="Box">
            <style>
              <class name="box"></class>
            </style>
            <property name="orientation">vertical</property>
            <property name="hexpand-set">true</property>
            <property name="hexpand">true</property>
            <property name="spacing">10</property>
            <child>
              <object class="GtkBox" id="SearchContainer">
                <style>
                  <class name="search-container"></class>
                </style>
                <property name="overflow">hidden</property>
                <property name="orientation">horizontal</property>
                <property name="halign">fill</property>
                <property name="hexpand-set">true</property>
                <property name="hexpand">true</property>
                <child>
                  <object class="GtkEntry" id="Input">
                    <style>
                      <class name="input"></class>
                    </style>
                    <property name="halign">fill</property>
                    <property name="hexpand-set">true</property>
                    <property name="hexpand">true</property>
                  </object>
                </child>
              </object>
            </child>
            <child>
              <object class="GtkBox" id="ContentContainer">
                <style>
                  <class name="content-container"></class>
                </style>
                <property name="orientation">horizontal</property>
                <property name="spacing">10</property>
                <property name="vexpand">true</property>
                <property name="vexpand-set">true</property>
                <child>
                  <object class="GtkLabel" id="ElephantHint">
                    <style>
                      <class name="elephant-hint"></class>
                    </style>
                    <property name="hexpand">true</property>
                    <property name="height-request">100</property>
                    <property name="label">Waiting for elephant...</property>
                  </object>
                </child>
                <child>
                  <object class="GtkLabel" id="Placeholder">
                    <style>
                      <class name="placeholder"></class>
                    </style>
                    <property name="label">No Results</property>
                    <property name="yalign">0.0</property>
                    <property name="hexpand">true</property>
                  </object>
                </child>
                <child>
                  <object class="GtkScrolledWindow" id="Scroll">
                    <style>
                      <class name="scroll"></class>
                    </style>
                    <property name="hexpand">true</property>
                    <property name="can_focus">false</property>
                    <property name="overlay-scrolling">true</property>
                    <property name="max-content-width">600</property>
                    <property name="max-content-height">300</property>
                    <property name="min-content-height">0</property>
                    <property name="propagate-natural-height">true</property>
                    <property name="propagate-natural-width">true</property>
                    <property name="hscrollbar-policy">automatic</property>
                    <property name="vscrollbar-policy">automatic</property>
                    <child>
                      <object class="GtkGridView" id="List">
                        <style>
                          <class name="list"></class>
                        </style>
                        <property name="max_columns">1</property>
                        <property name="can_focus">false</property>
                      </object>
                    </child>
                  </object>
                </child>
                <child>
                  <object class="GtkBox" id="Preview">
                    <style>
                      <class name="preview"></class>
                    </style>
                  </object>
                </child>
              </object>
            </child>
            <child>
              <object class="GtkBox" id="Keybinds">
                <property name="hexpand">true</property>
                <property name="margin-top">10</property>
                <style>
                  <class name="keybinds"></class>
                </style>
                <child>
                  <object class="GtkBox" id="GlobalKeybinds">
                    <property name="spacing">10</property>
                    <style>
                      <class name="global-keybinds"></class>
                    </style>
                  </object>
                </child>
                <child>
                  <object class="GtkBox" id="ItemKeybinds">
                    <property name="hexpand">true</property>
                    <property name="halign">end</property>
                    <property name="spacing">10</property>
                    <style>
                      <class name="item-keybinds"></class>
                    </style>
                  </object>
                </child>
              </object>
            </child>
            <child>
              <object class="GtkLabel" id="Error">
                <style>
                  <class name="error"></class>
                </style>
                <property name="xalign">0</property>
                <property name="visible">false</property>
              </object>
            </child>
          </object>
        </child>
      </object>
    </child>
  </object>
</interface>
                    '';
                    "item_calc" = " <!-- xml --> ";
                };
            };
        };
    };
}
