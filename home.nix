{
  inputs,
  config,
  protoHost,
  pkgs,
  lib,
  ...
}:

let
  # dotfilesDerivation = pkgs.stdenv.mkDerivation {
  # name =  "${myVar}";
  # src = ./dotfiles; 
  # buildCommand = ''
  #   mkdir -p $out/
  #   cp -r $src/* $out/
  # '';
  # };
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = protoHost.username;
  home.homeDirectory = "/home/${protoHost.username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ./programs/mc.nix
    ./programs/zsh.nix
    ./programs/git.nix
  ] ++ protoHost.hmModules;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  # home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  # ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = {
    #linking those scripts to .local/bin doesn't seem to put them in path
    # ".local/bin/lockscript".source = "${lockscript}/bin/lockscript";
    # ".local/bin/monitorScript".source = "${monitorScript}/bin/monitorScript";
    # ".local/bin/batteryScript".source = "${batteryScript}/bin/batteryScript";
    # ".local/bin/launchPolybar".source = "${launchPolybar}/bin/launchPolybar";
    # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  # };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/myc0plasmus/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    DEVICE_NAME = protoHost.hostname;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
