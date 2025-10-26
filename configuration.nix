{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vm";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Shanghai";

  services.getty.autologinUser = "syaofox";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  users.users.syaofox = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    foot
    kitty
    waybar
    git
    hyprpaper
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    wqy_microhei  # 文泉驿微米黑
    wqy_zenhei    # 文泉驿正黑
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "WenQuanYi Zen Hei" "DejaVu Serif" ];
      sansSerif = [ "WenQuanYi Micro Hei" "DejaVu Sans" ];
      monospace = [ "WenQuanYi Micro Hei Mono" "DejaVu Sans Mono" ];
    };
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-chinese-addons
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";

}

