{ pkgs, ... }:

{
  home = {
    packages = [
      pkgs.htop
      pkgs.fortune
      pkgs.zip
      pkgs.unzip
    ];
    file.".ghci".text = ''
      :set prompt "λ> "
    '';
    file.".zshrc".source = ~/.config/zshrc;
    file.".gitconfig".source = ~/.config/gitconfig;
  };

  programs.home-manager = {
    enable = true;
    path = https://github.com/rycee/home-manager/archive/master.tar.gz;
  };

  programs.firefox = {
    enable = true;
    enableIcedTea = true;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  programs.gnome-terminal = {
    enable = true;
    showMenubar = false;
    profile = {
      "5ddfe964-7ee6-4131-b449-26bdd97518f7" = {
        visibleName = "Solarized_Black";
        default = true;
        cursorShape = "ibeam";
        font = "Hack 12";
        showScrollbar = false;
        colors = {
          foregroundColor = "rgb(197,200,198)";
          palette = [
            "rgb(0,0,0)" "rgb(145,34,38)" "rgb(119,137,0)"
            "rgb(174,123,0)" "rgb(103,123,192)" "rgb(104,42,155)"
            "rgb(43,102,81)" "rgb(146,149,147)" "rgb(102,102,102)"
            "rgb(204,102,102)" "rgb(181,189,104)" "rgb(240,198,116)"
            "rgb(140,152,191)" "rgb(178,148,187)" "rgb(138,190,183)"
            "rgb(236,235,236)"
          ];
          boldColor = "rgb(138,186,183)";
          backgroundColor = "rgb(0,0,0)";
          #backgroundColor = "rgb(29,31,33)";
        };
      };
    };
  };
}
