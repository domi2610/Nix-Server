{ ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l --color=auto";
      l = "ll";
      la = "ls -A --color=auto";
      lla = "ls -lA --color=auto";
      nix-update = "nix flake update --flake ~/Projects/Nix-Server/.";
      webserver-ssh = "ssh ubuntu@144.24.186.232";
      webserver-mount = "sshfs ubuntu@144.24.186.232:/home/ubuntu ~/mnt";
    };
  };
}
