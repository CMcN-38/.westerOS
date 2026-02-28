# Hardware configuration for lannister
#
# This is a placeholder file. Run the following command on the target machine
# to generate the actual hardware configuration:
#
#   sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
#
# Then copy the generated file to this location.

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  # Placeholder - replace with actual hardware configuration
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

  # Add your hardware-specific configuration here
}
