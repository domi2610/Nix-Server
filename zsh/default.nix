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
      nix-update =
        "nix flake update ~/.config/home-manager/ && home-manager switch";
    };
  };
}
