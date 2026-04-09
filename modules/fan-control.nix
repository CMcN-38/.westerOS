{ config, lib, pkgs, ... }:

{
  # Install Framework fan control tool
  environment.systemPackages = with pkgs; [
    fw-fanctrl  # Framework-specific fan control daemon
    fw-ectool   # Framework EC tool for debugging
    lm_sensors  # Hardware monitoring sensors
  ];

  # Configure fw-fanctrl service
  # The tool uses a config file at /etc/fw-fanctrl/config.json
  environment.etc."fw-fanctrl/config.json".text = builtins.toJSON {
    # Default strategy for all power states
    defaultStrategy = "custom";

    # Strategy to use when on battery (empty = use defaultStrategy)
    strategyOnDischarging = "";

    # Custom fan curve configuration
    # Strategies define fan behavior based on CPU temperature
    strategies = {
      # Quiet-aggressive: Silent at low temps, aggressive when hot
      custom = {
        # Temperature thresholds and corresponding fan speeds
        speedCurve = [
          { temp = 0;  speed = 0; }    # Idle: Completely silent (0%)
          { temp = 45; speed = 0; }    # Light use: Still silent
          { temp = 55; speed = 15; }   # Warming up: Barely audible
          { temp = 65; speed = 25; }   # Medium load: Low speed
          { temp = 70; speed = 45; }   # Getting hot: Start ramping
          { temp = 75; speed = 70; }   # Heavy load: Aggressive cooling
          { temp = 80; speed = 90; }   # Very hot: Near max
          { temp = 85; speed = 100; }  # Max: Full blast to prevent throttling
        ];

        # Slower response for smoother transitions
        fanSpeedUpdateFrequency = 5;

        # Longer averaging for stability (prevents fan ramping on brief spikes)
        movingAverageInterval = 40;
      };

      # Built-in lazy profile (reference - you can switch to this)
      lazy = {
        speedCurve = [
          { temp = 0;  speed = 0; }
          { temp = 50; speed = 20; }
          { temp = 65; speed = 35; }
          { temp = 70; speed = 50; }
          { temp = 75; speed = 65; }
          { temp = 80; speed = 80; }
          { temp = 85; speed = 100; }
        ];
        fanSpeedUpdateFrequency = 5;
        movingAverageInterval = 30;
      };

      # Built-in aggressive profile (for maximum cooling)
      aggressive = {
        speedCurve = [
          { temp = 0;  speed = 35; }
          { temp = 50; speed = 50; }
          { temp = 60; speed = 65; }
          { temp = 65; speed = 75; }
          { temp = 70; speed = 85; }
          { temp = 75; speed = 100; }
        ];
        fanSpeedUpdateFrequency = 2;
        movingAverageInterval = 15;
      };
    };
  };

  # Enable and configure the fw-fanctrl systemd service
  systemd.services.fw-fanctrl = {
    description = "Framework Laptop Fan Control";
    wantedBy = [ "multi-user.target" ];
    after = [ "system-setup.service" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.fw-fanctrl}/bin/fw-fanctrl run";
      Restart = "on-failure";
      RestartSec = "10s";

      # Service needs root to access EC
      User = "root";

      # Runtime directory for sockets
      RuntimeDirectory = "fw-fanctrl";
      RuntimeDirectoryMode = "0755";

      # Security hardening
      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ReadWritePaths = [ "/sys" "/dev" ];
    };
  };

  # Load necessary kernel modules for EC access
  boot.kernelModules = [ "cros_ec" "cros_ec_lpcs" ];

  # Ensure proper permissions for EC device
  services.udev.extraRules = ''
    # Framework EC device permissions
    KERNEL=="cros_ec", MODE="0660", GROUP="wheel"
  '';
}
