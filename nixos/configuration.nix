# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./home-manager
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.device = "/dev/sda";
    };
  };

  networking = {
    hostName = "cortana";
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    firewall = {
      enable = true;
      allowedTCPPorts = []; # 80 443
      allowPing = true;
    };
    wireless = {
      enable = true;  # Enables wireless support via wpa_supplicant.
      networks = {
        "Hotel Strata" = {};
      };
    };
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      fira
      fira-code 
      fira-mono
      font-awesome-ttf
      cantarell_fonts
      corefonts
      dejavu_fonts
      gentium
      inconsolata
      noto-fonts
      opensans-ttf
      freefont_ttf
      liberation_ttf
      xorg.fontmiscmisc
      ubuntu_font_family
      dejavu_fonts
    ];
  };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    fzf
    ripgrep
    gnome3.dconf
    wget
    unetbootin
    chromium
    htop
    mosh
    tree
    which
    i3
    i3lock
    i3status
    networkmanagerapplet
    networkmanager_openvpn
    xfontsel
    xdg_utils
    xautolock
    libnotify
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.i3.enable = true;
  # services.xserver.videoDrivers = [ "nvidia" ];

  hardware.opengl.driSupport32Bit = true;

  # Enable touchpad support.
  #services.xserver.libinput.enable = true;
  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.cypher = {
    description = "Cypher";
    isNormalUser = true;
    createHome = true;
    home = "/home/cypher";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
