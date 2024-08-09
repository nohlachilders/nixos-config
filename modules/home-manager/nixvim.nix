
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
          nil-ls.enable = true;
          gopls.enable = true;
          bashls.enable = true;
          cssls.enable = true;
          gdscript.enable = true;
          html.enable = true;
          jsonls.enable = true;
          tsserver.enable = true;
          pylsp.enable = true;
        };
      
      keymaps = {
          lspBuf = {
            "gd" = "definition";
            "vh" = "hover";
            "<leader>vca" = "code_action";
            "<leader>vrr" = "references";
            "<leader>vrn" = "rename";
          };

          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
          };
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>f" = "find_files";
          "<leader>g" = "live_grep";
        };
      };

      harpoon = {
        enable = true;
        keymaps = {
          addFile = "<leader>a";
          toggleQuickMenu = "<leader>e";
          navFile = {
            "1" = "<C-h>";
            "2" = "<C-j>";
            "3" = "<C-k>";
            "4" = "<C-l>";
          };
        };
      };

#      cmp = {
#        enable = true;
#        autoEnableSources = true;
#        settings.sources = [
#          {name = "nvim_lsp";}
#          {name = "path";}
#          {name = "buffer";}
#          {name = "luasnip";}
#        ];
#
#        settings.mapping = {
#          "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(cmp_select), {'i'})";
#          "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(cmp_select), {'i'})";
#          "<C-Space>" = "cmp.mapping(cmp.mapping.confirm({select = true}), {'i'})";
#        };
#      };

      undotree.enable = true;
      treesitter.enable = true;
      rainbow-delimiters.enable = true;
      };

    colorschemes.gruvbox.enable = true;

    globals.mapleader = " ";

    extraConfigLua = /*lua*/ ''
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

      vim.opt.nu = true
      vim.opt.relativenumber = true
      vim.opt.clipboard = unnamedplus
      vim.opt.selection = "exclusive"

      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.opt.wrap = false
      vim.opt.hlsearch = false
      vim.opt.incsearch = true
      vim.opt.termguicolors = true
      vim.opt.scrolloff = 8
      vim.opt.signcolumn = "yes"
      vim.opt.isfname:append("@-@")
      vim.opt.updatetime = 50
      vim.opt.colorcolumn = "80"

      function fix_transparency()
        vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
        vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
      end

      fix_transparency()

    '';
  };
}
