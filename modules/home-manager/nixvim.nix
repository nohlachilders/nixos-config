
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  #programs.neovim.enable = true;

  programs.nixvim = {
    enable = true;

    plugins = {
      lsp= {
        enable = true;
        servers = {
          nil_ls.enable = true;
        };
      };

      treesitter.enable = true;

      telescope = {
        enable = true;
        keymaps = {
          "<leader>f" = "find_files";
          "<leader>g" = "live_grep";
        };

      };
    };

    keymaps = [
      #{}
    ];

    colorschemes.gruvbox.enable = true;

    globals.mapleader = " ";

    extraConfigLua = ''
      vim.keymap.set("i","jk", "<Esc>")
      vim.keymap.set("v","jk", "<Esc>")
      vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
      vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
      vim.keymap.set("n", "J", "mzJ`z")
      vim.keymap.set("n", "<C-d>", "<C-d>zz")
      vim.keymap.set("n", "<C-u>", "<C-u>zz")
      vim.keymap.set("n", "n", "nzzzv")
      vim.keymap.set("n", "N", "Nzzzv")
      vim.keymap.set("x", "<leader>p", "\"_dP")
      vim.keymap.set("n", "Q", "<nop>")
      vim.keymap.set("n", "<leader>w", vim.cmd.w)
      vim.keymap.set("n", "<leader>x", vim.cmd.Ex)
    '';
  };

}