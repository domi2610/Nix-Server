{ pkgs, ... }:

let
  concatFiles = files:
    pkgs.lib.strings.concatMapStringsSep "\n" builtins.readFile files;
in {

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    extraLuaConfig = (concatFiles [
      ./luafiles/set.lua
      ./luafiles/remap.lua
      ./luafiles/copilot.lua
    ]);
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      telescope-fzf-native-nvim
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = ''
          	        require("catppuccin").setup({
                          integrations = {
                              cmp = true,
                              gitsigns = true,
                              nvimtree = false,
                              telescope = true,
                              fidget = false,
                              treesitter = true,
                              illuminate = true,
                              lsp_saga = true,
                          }
                      })
          	        vim.cmd.colorscheme "catppuccin"
          	      '';
      }
      {
        plugin = (nvim-treesitter.withPlugins (plugins:
          with plugins; [
            tree-sitter-bash
            tree-sitter-c
            tree-sitter-cpp
            tree-sitter-go
            tree-sitter-python
            tree-sitter-latex
            tree-sitter-lua
            tree-sitter-rust
            tree-sitter-scss
            tree-sitter-typescript
            tree-sitter-html
            tree-sitter-css
            tree-sitter-javascript
            tree-sitter-yaml
            tree-sitter-toml
            tree-sitter-markdown
            tree-sitter-markdown-inline
            tree-sitter-nix
          ]));
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup {
              highlight = {
                  enable = true,
                  additional_vim_regex_highlighting = false,
              },
          }
        '';
      }
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config =
          "  vim.g.loaded_netrw = 1\n  vim.g.loaded_netrwPlugin = 1\n  vim.opt.termguicolors = true\n  require(\"nvim-tree\").setup()\n";
      }
      nvim-web-devicons
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          	        require("lualine").setup {
          	          options = {
          	            theme = "catppuccin",
          	          },
                        extensions = {
                            'nvim-tree',
                            'symbols-outline',
                        },
          	        }
          	      '';
      }
      vim-fugitive
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = "require('nvim-autopairs').setup()";
      }
      nvim-surround
      vim-illuminate
      {
        plugin = nvim-colorizer-lua;
        type = "lua";
        config = ''require("colorizer").setup()'';
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = "require('gitsigns').setup()";
      }
      {
        plugin = dashboard-nvim;
        type = "lua";
        config = "require('dashboard').setup {}";
      }
      copilot-vim
      # completion plugin setup
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets
      lspkind-nvim
      {
        plugin = crates-nvim;
        type = "lua";
        config = ''
          require('crates').setup()
          require('crates').show()
        '';
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile (./luafiles/cmp.lua);
      }
      # LSP Setup
      {
        plugin = lspsaga-nvim;
        type = "lua";
        config = ''
          require('lspsaga').setup({
              ui = {
                  title = true,
                  border = 'rounded',
                  kind = require('catppuccin.groups.integrations.lsp_saga').custom_kind(),
              },
              definition = {
                  edit = '<CR>',
              },
          })
        '';
      }
      typescript-nvim
      rust-tools-nvim
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile (./luafiles/lsp-config.lua);
      }
      {
        plugin = null-ls-nvim;
        type = "lua";
        config = builtins.readFile (./luafiles/null-ls.lua);
      }
      vim-tmux-navigator
      vim-tmux-clipboard
    ];
  };
}
