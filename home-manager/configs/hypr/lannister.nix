# home.nix
{
  config,
  pkgs,
  ...
}: {
wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    configType = "lua";
    extraConfig =
        ''
          --------------------
          ---- MONITOR -------
          --------------------

          hl.monitor({
              output   = "",
              mode     = "preferred",
              position = "auto",
              scale    = 1.5,
          })

          --------------------
          ---- PROGRAMS ------
          --------------------

          local terminal    = "kitty"
          local fileManager = "thunar"
          local menu        = "rofi -show drun"
          local browser     = "appimage-run -d /home/cameron/2_desktop/zen-specific.AppImage"
          local mainMod     = "SUPER"
          local osdclient   = [[swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"]]

          -------------------
          ---- ENV VARS ------
          -------------------

          hl.env("NIXOS_OZONE_WL", "1")
          hl.env("NIXPKGS_ALLOW_UNFREE", "1")
          hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
          hl.env("XDG_SESSION_TYPE", "wayland")
          hl.env("XDG_SESSION_DESKTOP", "Hyprland")
          hl.env("GDK_BACKEND", "wayland,x11")
          hl.env("CLUTTER_BACKEND", "wayland")
          hl.env("QT_QPA_PLATFORM", "wayland;xcb")
          hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
          hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
          hl.env("SDL_VIDEODRIVER", "x11")
          hl.env("MOZ_ENABLE_WAYLAND", "1")

          -------------------
          ---- AUTOSTART ----
          -------------------

          hl.on("hyprland.start", function()
              hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_RUNTIME_DIR DISPLAY")
              hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_RUNTIME_DIR DISPLAY")
              hl.exec_cmd("nm-applet --indicator")
              hl.exec_cmd("lxqt-policykit-agent")
              hl.exec_cmd("waybar")
              hl.exec_cmd("swaync")
              hl.exec_cmd("swaybg -i /home/cameron/.omarchy/current/background")
              hl.exec_cmd("hypridle")
              hl.exec_cmd("thunar --daemon")
              hl.exec_cmd("solaar -w hide")
              hl.exec_cmd(terminal)
              hl.exec_cmd(browser)
              hl.exec_cmd("[workspace 5 silent] obsidian")
          end)

          -----------------------
          ---- LOOK AND FEEL ----
          -----------------------

          hl.config({
              general = {
                  gaps_in          = 5,
                  gaps_out         = 5,
                  border_size      = 3,
                  layout           = "dwindle",
                  resize_on_border = true,
                  col = {
                      active_border   = "rgba(6ee9f8ff)",
                      inactive_border = "rgba(4e112aff)",
                  },
              },

              decoration = {
                  rounding = 8,
                  blur = {
                      enabled = false,
                      size    = 3,
                      passes  = 1,
                  },
                  shadow = {
                      enabled      = true,
                      range        = 4,
                      render_power = 3,
                      color        = "rgba(1a1a1aee)",
                  },
              },

              animations = {
                  enabled = true,
              },

              input = {
                  kb_variant    = "dvorak",
                  kb_options    = "grp:alt_shift_toggle,caps:super",
                  follow_mouse  = 1,
                  sensitivity   = 1,
                  accel_profile = "flat",
                  touchpad = {
                      natural_scroll       = true,
                      disable_while_typing = false,
                      scroll_factor        = 0.2,
                  },
              },

              gestures = {
                  workspace_swipe_distance = 1200,
              },

              misc = {
                  initial_workspace_tracking = 0,
                  mouse_move_enables_dpms    = true,
                  key_press_enables_dpms     = false,
                  force_default_wallpaper    = 0,
              },

              ecosystem = {
                  no_update_news = true,
              },

              dwindle = {
                  preserve_split = true,
              },

              plugin = {
                  hyprtrails = {},
              },
          })

          --------------------
          ---- ANIMATIONS ----
          --------------------

          hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

          hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
          hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default",  style = "popin 80%" })
          hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
          hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
          hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
          hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

          -----------------------
          ---- WINDOW RULES -----
          -----------------------

          hl.window_rule({ match = { class = "thunar" },              float = true, center = true, size = "2500 1000" })
          hl.window_rule({ match = { class = "^(Volume Control)$" },  float = true, move = "83% 2.5%", size = "600 1000" })
          hl.window_rule({ match = { class = "^(Rofi)$" },            float = true, center = true })

          -- Workspace assignments
          hl.window_rule({ match = { class = "^(kitty)$" },           workspace = 1 })
          hl.window_rule({ match = { class = "^(zen)$" },             workspace = 2 })
          hl.window_rule({ match = { class = "^(Cider)$" },           workspace = 3 })
          hl.window_rule({ match = { class = "^(discord)$" },         workspace = 4 })
          hl.window_rule({ match = { class = "obsidian" },            workspace = 5 })
          hl.window_rule({ match = { class = "transmission-gtk" },    workspace = 9 })

          -- Transparency
          hl.window_rule({ match = { class = "^(zen)$" },             opacity = 0.95 })
          hl.window_rule({ match = { class = "^(discord)$" },         opacity = 0.95 })
          hl.window_rule({ match = { class = "^(Cider)$" },           opacity = 0.95 })

          -- Layer rules
          hl.layer_rule({ match = { namespace = "^(swaync)$" }, blur = true })
          hl.layer_rule({ match = { namespace = "^(waybar)$" },  blur = true })

          ---------------------
          ---- KEYBINDINGS ----
          ---------------------

          -- Basic controls
          hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
          hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
          hl.bind(mainMod .. " + F",      hl.dsp.exec_cmd(fileManager))
          hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
          hl.bind(mainMod .. " + SPACE",  hl.dsp.exec_cmd(menu))
          hl.bind(mainMod .. " + P",      hl.dsp.window.pseudo())
          hl.bind(mainMod .. " + J",      hl.dsp.layout("togglesplit"))
          hl.bind(mainMod .. " + Z",      hl.dsp.exec_cmd(browser))
          hl.bind(mainMod .. " + O",      hl.dsp.exec_cmd("obsidian"))
          hl.bind(mainMod .. " + C",      hl.dsp.exec_cmd("Cider"))
          hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd("discordptb"))

          -- Focus
          hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
          hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
          hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
          hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

          -- Workspaces
          for i = 1, 9 do
              hl.bind(mainMod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
              hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
          end
          hl.bind(mainMod .. " + 0",         hl.dsp.focus({ workspace = 10 }))
          hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

          -- Workspace scroll
          hl.bind(mainMod .. " + mouse_down",   hl.dsp.focus({ workspace = "e+1" }))
          hl.bind(mainMod .. " + mouse_up",     hl.dsp.focus({ workspace = "e-1" }))
          hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "e+1" }))
          hl.bind(mainMod .. " + CTRL + left",  hl.dsp.focus({ workspace = "e-1" }))

          -- Move/resize with mouse
          hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
          hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

          -- Wallpaper / theme
          hl.bind(mainMod .. " + W",         hl.dsp.exec_cmd("westerOS_bg_next"))
          hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("westerOS_theme_set catppuccin"))
          hl.bind(mainMod .. " + Delete",    hl.dsp.exec_cmd("snippetexpandergui -s"))

          -- Screenshot
          hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("westerOS_screenshot"))

          -- OSD / Media keys
          hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(osdclient .. " --output-volume raise"),       { locked = true, repeating = true })
          hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(osdclient .. " --output-volume lower"),       { locked = true, repeating = true })
          hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(osdclient .. " --output-volume mute-toggle"), { locked = true, repeating = true })
          hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("westerOS_brightness_display +10%"),          { locked = true, repeating = true })
          hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("westerOS_brightness_display -10%"),          { locked = true, repeating = true })
        '';
};
        services.hypridle = {
                enable = true;
                settings = {
                        general = {
                                before_sleep_cmd = "loginctl lock-session";
                                inhibit_sleep = 3;
                                after_sleep_cmd = "hyprctl dispatch dpms on";
                                ignore_dbus_inhibit = false;
                                lock_cmd = "hyprlock";
                        };

                        listener = [
                                {
                                        timeout = 300;
                                        on-timeout = "hyprlock";
                                        condition = "! westerOS_check_audio";
                                }
                                {
                                        timeout = 600;
                                        on-timeout = "hyprctl dispatch dpms off";
                                        on-resume = "hyprctl dispatch dpms on";
                                        condition = "! westerOS_check_audio";
                                }
                        ];
                };
        };

        programs.hyprlock = {
                enable = true;
                settings = {
                        general = {
                                hide_cursor = true;
                                ignore_empty_input = true;
                        };

                        animations = {
                                enabled = true;
                                fade_in = {
                                        duration = 300;
                                        bezier = "easeOutQuint";
                                };
                                fade_out = {
                                        duration = 300;
                                        bezier = "easeOutQuint";
                                };
                        };
                };
        };
}
