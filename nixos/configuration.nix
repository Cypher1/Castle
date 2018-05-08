# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
# This value determines the NixOS release with which your system is to be
# compatible, in order to avoid breaking some software such as database
# servers. You should change this only after NixOS release notes say you
# should.
system.stateVersion = "17.09"; # Did you read the comment?

nixpkgs.config.allowUnfree = true;
imports =
[ # Include the results of the hardware scan.
./hardware-configuration.nix
"${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos"
./multi-glibc-locale-paths.nix
    ];

    # Use the systemd-boot EFI boot loader.
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        grub.device = "/dev/sda";
      };
    };

    # Open ports in the firewall.
    networking = {
      hostName = "cortana";
      nameservers = [ "8.8.8.8" "8.8.4.4" ];
      firewall = {
        enable = true;
        allowedTCPPorts = []; # 80 443
        allowPing = true;
      };
      networkmanager.enable = true;
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

    nix.nixPath = [ "/home/cypher/.config" "nixos-config=/etc/nixos/configuration.nix" ];

    environment.systemPackages = with pkgs; [
      fzf
      gnome3.dconf
      wget
      unetbootin
      chromium
      neovim
      git
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
      blueman
      libnotify
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.bash.enableCompletion = true;
    # programs.mtr.enable = true;
    # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.extraUsers.cypher = {
      description = "Cypher";
      isNormalUser = true;
      createHome = true;
      home = "/home/cypher";
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "networkmanager" ];
    };

    hardware.pulseaudio.enable = true;
    hardware.pulseaudio.package = pkgs.pulseaudioFull;

    sound.mediaKeys = {
      enable = true;
      volumeStep = "5%";
    };
    hardware.opengl.driSupport32Bit = true;
    hardware.pulseaudio.support32Bit = true;
    hardware.bluetooth.enable = true;

    # List services that you want to enable:
    # Enable the OpenSSH daemon.
    services = {
      openssh.enable = false;

      logind.extraConfig = "HandleLidSwitchDocked=suspend";

      # Enable CUPS to print documents.
      # printing.enable = true;

      # Enable the X11 windowing system.
      xserver = {
        enable = true;
        layout = "us";
        desktopManager.default = "none";
        desktopManager.xterm.enable = false;
        displayManager.lightdm = {
          enable = true;
          autoLogin.enable = true;
          autoLogin.user = "cypher";
        };
        windowManager = {
          i3.enable = true;
          default = "i3";
        };
        # videoDrivers = [ "nvidia" ];

        # Enable touchpad support.
        #libinput.enable = true;
        synaptics = {
        enable = true;
        twoFingerScroll = true;
        buttonsMap = [ 1 3 2 ];
        minSpeed = "1.0";
        maxSpeed = "1.5";
        };
        };

        # support for games and steam 
        udev.extraRules = ''
        SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
        KERNEL=="uinput", MODE="0660", GROUP="users", OPTIONS+="static_node=uinput"
        '';
      };

    }
