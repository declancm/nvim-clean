Vim�UnDo� �,l;c\��z"pu��<ay��u��	(����                                      b%/    _�                             ����                                                                                                                                                                                                                                                                                                                                                  V        b%,     �                "  -- your configuration comes here   2  -- or leave it empty to use the default settings   -  -- refer to the configuration section below5��                                 �               5�_�                             ����                                                                                                                                                                                                                                                                                                                                                  V        b%.    �               "	{ silent = true, noremap = true }�               -	"<cmd>Trouble lsp_document_diagnostics<cr>",�               	"<leader>xd",�   
            	"n",�      	         "	{ silent = true, noremap = true }�               .	"<cmd>Trouble lsp_workspace_diagnostics<cr>",�               	"<leader>xw",�               	"n",�                require("trouble").setup({   })       avim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })   vim.api.nvim_set_keymap(     "n",     "<leader>xw",   /  "<cmd>Trouble lsp_workspace_diagnostics<cr>",   #  { silent = true, noremap = true }   )   vim.api.nvim_set_keymap(     "n",     "<leader>xd",   .  "<cmd>Trouble lsp_document_diagnostics<cr>",   #  { silent = true, noremap = true }5��                              N      E      �                         �                     �                         �                     �               .       /   �       .       /       �               "       #   �       "       #       �    
                                         �                         &                    �               -       .   6      -       .       �               "       #   e      "       #       5��