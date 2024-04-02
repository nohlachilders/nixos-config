
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

      nvim-cmp = {
        enable = true;
        autoEnableSources = true;
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
          {name = "luasnip";}
        ];

        mapping = {
          "<C-p>" = {
            action = "cmp.mapping.select_prev_item(cmp_select)";
            modes = [ "i" ];
          };
          "<C-n>" = {
            action = "cmp.mapping.select_next_item(cmp_select)";
            modes = [ "i" ];
          };
          "<C-Space>" = {
            action = "cmp.mapping.confirm({select = true})";
            modes = [ "i" ];
          };
        };
        };
      };

      undotree.enable = true;
      treesitter.enable = true;
      };

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

      vim.opt.nu = true
      vim.opt.relativenumber = true

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
