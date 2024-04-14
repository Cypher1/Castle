vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move the visual selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Buffer management
vim.keymap.set("n", "<leader>n", vim.cmd.bnext)
vim.keymap.set("n", "<leader>m", vim.cmd.bprevious)
vim.keymap.set("n", "<leader>q", vim.cmd.bdelete)

-- Paste over (not working right now?)
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Clipboard control
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "Q", "<nop>") -- no more accidental macros
vim.keymap.set("n", ":", ":nohlsearch<CR>:") -- clear highlight

-- Quick fix
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<C-O>", "<ESC>:GFiles<CR>")
vim.keymap.set("n", "<C-F>", "<ESC>:GGrep<CR>")
vim.keymap.set("n", "<C-G>", "<ESC>:Gblame<CR>")
vim.keymap.set("n", "<C-B>", "<ESC>:Buffers<CR>")

-- Symbols for Maths, Lean, Coq
vim.keymap.set("i", "<A-1>", "⊤")
vim.keymap.set("i", "<A-2>", "⊥")
vim.keymap.set("i", "<A-3>", "⊢")
vim.keymap.set("i", "<A-4>", "⊣")
vim.keymap.set("i", "<A-5>", "→")
vim.keymap.set("i", "<A-6>", "∧")
vim.keymap.set("i", "<A-7>", "Π")
vim.keymap.set("i", "<A-8>", "∀")
vim.keymap.set("i", "<A-9>", "∃")
vim.keymap.set("i", "<A-0>", "λ")
