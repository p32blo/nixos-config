{
  config,
  pkgs,
  lib,
  ...
}: {
  home.username = "andre";
  home.homeDirectory = "/home/andre";

  home.packages = with pkgs; [
    firefox
    thunderbird
    discord
    spotify

    jetbrains.pycharm-professional
    unstable.vscode
    unstable.obsidian

    insomnia
    (let
      brunoLockfilePatch_1_12_2 = fetchpatch {
        url = "https://github.com/usebruno/bruno/pull/1894/commits/e3bab23446623315ee674283285a86e210778fe7.patch";
        hash = "sha256-8rYBvgu9ZLXjb9AFyk4yMBVjcyFPmlNi66YEaQGQaKw=";
      };
    in
      unstable.bruno.overrideAttrs (
        oldAttrs: rec {
          pname = "bruno";
          version = "1.12.2";
          name = "${pname}-${version}";
          src = fetchFromGitHub {
            owner = "usebruno";
            repo = "bruno";
            rev = "v${version}";
            hash = "sha256-C/WeEloUGF0PEfeanm6lHe/MgpcF+g/ZY2tnqXFl9LA=";
            postFetch = ''
              patch -d $out <${brunoLockfilePatch_1_12_2}
              ${lib.getExe pkgs.unstable.npm-lockfile-fix} $out/package-lock.json
            '';
          };
          npmDepsHash = "sha256-Zt5cVB1S86iPYKOUj7FwyR97lwmnFz6sZ+S3Ms/b9+o=";

          npmDeps = fetchNpmDeps {
            inherit src;
            name = "${name}-npm-deps";
            hash = npmDepsHash;
          };
          makeCacheWritable = true;
        }
      ))

    blender
    gimp
    wireshark
    vlc

    rpi-imager
    local.mqtt-explorer
    gupnp-tools # SSDP CLI
    gssdp-tools # SSDP GUI
  ];

  programs.bash = {
    enable = true;
    shellAliases = let
      eza-sort-args = "--git --group --group-directories-first --header --sort=extension";
    in {
      ll = "eza -l ${eza-sort-args}";
      l = "eza -la ${eza-sort-args}";
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "André Oliveira";
    userEmail = "p32blo@gmail.com";
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch --column";
      tree = "log --graph --oneline --decorate";
    };
    extraConfig = {
      rerere = {
        enable = true;
      };
      init = {
        defaultBranch = "main";
      };
      diff = {
        algorithm = "histogram";
      };
      branch = {
        sort = "-committerdate";
      };
    };
    includes = [
      {
        condition = "gitdir:~/Work/";
        contents = {
          user = {
            name = "André Oliveira";
            email = "andre.oliveira@q-better.com";
          };
        };
      }
    ];
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "qube*.local" = {
        user = "qube";
        extraOptions = {
          StrictHostKeyChecking = "no";
        };
      };
      "qube-gh-action-vpn" = {
        user = "qbetter";
        hostname = "192.168.154.184";
      };
      "qube-ssh" = {
        user = "ec2-user";
        hostname = "ssh.myqube.io"; # this will be changed soon to ssh.qube.q-better.com
        identityFile = "~/.ssh/aws_admin_rsa";
      };
      "qube-dev-aux" = {
        user = "ubuntu";
        hostname = "ec2-3-248-205-52.eu-west-1.compute.amazonaws.com";
        identityFile = "~/.ssh/aws_rsa";
      };
      "qube-preview" = {
        user = "ec2-user";
        hostname = "ec2-34-240-12-31.eu-west-1.compute.amazonaws.com";
        identityFile = "~/.ssh/aws_admin_rsa";
      };
    };
  };

  home.file = {
    ".config/MQTT-Explorer/settings.json" = {
      source = ./mqtt-explorer/settings.json;
      force = true;
    };
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
