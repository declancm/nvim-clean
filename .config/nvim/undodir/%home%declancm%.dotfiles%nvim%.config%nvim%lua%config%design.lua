Vim�UnDo� �c������Jq��dN��\��:�Kڸ5�   P                                   b&+    _�                     +        ����                                                                                                                                                                                                                                                                                                                                                             b%C     �   +            �   +            5��    +               #                     y      5�_�                    +       ����                                                                                                                                                                                                                                                                                                                            ,           N          v       b%G     �   +   .   O       �   +   -   N    5��    +                                           �    +                                           �    ,                                           �    ,                                        �    ,                                        �    ,                                        �    ,                                        �    ,   	                                     5�_�                    -   
    ����                                                                                                                                                                                                                                                                                                                            .           P          v       b%J    �   N   P   P      	extensions = { "fugitive" },�   M   O   P      	tabline = {},�   L   N   P      	},�   K   M   P      		lualine_z = {},�   J   L   P      		lualine_y = {},�   I   K   P      		lualine_x = { "location" },�   H   J   P      		lualine_c = { "filename" },�   G   I   P      		lualine_b = {},�   F   H   P      		lualine_a = {},�   E   G   P      	inactive_sections = {�   D   F   P      	},�   C   E   P      		lualine_z = { "location" },�   B   D   P      		lualine_y = { "progress" },�   A   C   P      		},�   @   B   P      			"filetype",�   ?   A   P      			"encoding",�   >   @   P      			},�   =   ?   P      N				symbols = { error = " ", warn = " ", info = " ", hint = " " },�   <   >   P      $				sources = { "nvim_diagnostic" },�   ;   =   P      				"diagnostics",�   :   <   P      			{�   9   ;   P      		lualine_x = {�   8   :   P      		lualine_c = { "filename" },�   7   9   P      		lualine_b = { "branch" },�   6   8   P      		lualine_a = { "mode" },�   5   7   P      	sections = {�   4   6   P      	},�   3   5   P      		disabled_filetypes = {},�   2   4   P      7		section_separators = { left = "", right = "" },�   1   3   P      9		component_separators = { left = "", right = "" },�   0   2   P      -		theme = "tokyonight", --onedark, tokyonight�   /   1   P      		icons_enabled = true,�   .   0   P      	options = {�   )   +   P      	Hint = "#10B981",�   (   *   P      	Information = "#0db9d7",�   '   )   P      	Warning = "#e0af68",�   &   (   P      	Error = "#db4b4b",�   &   P   P   )     Error = "#db4b4b",     Warning = "#e0af68",     Information = "#0db9d7",     Hint = "#10B981",   })       -- LUALINE:   require("lualine").setup({     options = {       icons_enabled = true,   /    theme = "tokyonight", --onedark, tokyonight   ;    component_separators = { left = "", right = "" },   9    section_separators = { left = "", right = "" },       disabled_filetypes = {},     },     sections = {       lualine_a = { "mode" },       lualine_b = { "branch" },       lualine_c = { "filename" },       lualine_x = {         {           "diagnostics",   (        sources = { "nvim_diagnostic" },   R        symbols = { error = " ", warn = " ", info = " ", hint = " " },         },         "encoding",         "filetype",       },       lualine_y = { "progress" },       lualine_z = { "location" },     },     inactive_sections = {       lualine_a = {},       lualine_b = {},       lualine_c = { "filename" },       lualine_x = { "location" },       lualine_y = {},       lualine_z = {},     },     tabline = {},     extensions = { "fugitive" },5��    &       (      (      �      �      |      �    &                     �                    �    '                     �                    �    (                     �                    �    )                     �                    �    .                     /                    �    /                     =                    �    0           -       /   W      -       /       �    1           9       ;   �      9       ;       �    2           7       9   �      7       9       �    3                     �                    �    4                                         �    5                                         �    6                     .                    �    7                     J                    �    8                     h                    �    9                     �                    �    :                     �                    �    ;                     �                    �    <           $       (   �      $       (       �    =           N       R   �      N       R       �    >                     5                    �    ?                     >                    �    @                     P                    �    A                     b                    �    B                     i                    �    C                     �                    �    D                     �                    �    E                     �                    �    F                     �                    �    G                     �                    �    H                     �                    �    I                                         �    J                     .                    �    K                     B                    �    L                     V                    �    M                     [                    �    N                     k                    5�_�                    9   
    ����                                                                                                                                                                                                                                                                                                                            '           P          v       b%O    �   N   P   P      	extensions = { "fugitive" },�   M   O   P      	tabline = {},�   L   N   P      	},�   K   M   P      		lualine_z = {},�   J   L   P      		lualine_y = {},�   I   K   P      		lualine_x = { "location" },�   H   J   P      		lualine_c = { "filename" },�   G   I   P      		lualine_b = {},�   F   H   P      		lualine_a = {},�   E   G   P      	inactive_sections = {�   D   F   P      	},�   C   E   P      		lualine_z = { "location" },�   B   D   P      		lualine_y = { "progress" },�   A   C   P      		},�   @   B   P      			"filetype",�   ?   A   P      			"encoding",�   >   @   P      			},�   =   ?   P      N				symbols = { error = " ", warn = " ", info = " ", hint = " " },�   <   >   P      $				sources = { "nvim_diagnostic" },�   ;   =   P      				"diagnostics",�   :   <   P      			{�   9   ;   P      		lualine_x = {�   8   :   P      		lualine_c = { "filename" },�   7   9   P      		lualine_b = { "branch" },�   6   8   P      		lualine_a = { "mode" },�   5   7   P      	sections = {�   4   6   P      	},�   3   5   P      		disabled_filetypes = {},�   2   4   P      7		section_separators = { left = "", right = "" },�   1   3   P      9		component_separators = { left = "", right = "" },�   0   2   P      -		theme = "tokyonight", --onedark, tokyonight�   /   1   P      		icons_enabled = true,�   .   0   P      	options = {�   )   +   P      	Hint = "#10B981",�   (   *   P      	Information = "#0db9d7",�   '   )   P      	Warning = "#e0af68",�   &   (   P      	Error = "#db4b4b",�   &   P   P   )     Error = "#db4b4b",     Warning = "#e0af68",     Information = "#0db9d7",     Hint = "#10B981",   })       -- LUALINE:   require("lualine").setup({     options = {       icons_enabled = true,   /    theme = "tokyonight", --onedark, tokyonight   ;    component_separators = { left = "", right = "" },   9    section_separators = { left = "", right = "" },       disabled_filetypes = {},     },     sections = {       lualine_a = { "mode" },       lualine_b = { "branch" },       lualine_c = { "filename" },       lualine_x = {         {           "diagnostics",   (        sources = { "nvim_diagnostic" },   R        symbols = { error = " ", warn = " ", info = " ", hint = " " },         },         "encoding",         "filetype",       },       lualine_y = { "progress" },       lualine_z = { "location" },     },     inactive_sections = {       lualine_a = {},       lualine_b = {},       lualine_c = { "filename" },       lualine_x = { "location" },       lualine_y = {},       lualine_z = {},     },     tabline = {},     extensions = { "fugitive" },5��    &       (      (      �      �      |      �    &                     �                    �    '                     �                    �    (                     �                    �    )                     �                    �    .                     /                    �    /                     =                    �    0           -       /   W      -       /       �    1           9       ;   �      9       ;       �    2           7       9   �      7       9       �    3                     �                    �    4                                         �    5                                         �    6                     .                    �    7                     J                    �    8                     h                    �    9                     �                    �    :                     �                    �    ;                     �                    �    <           $       (   �      $       (       �    =           N       R   �      N       R       �    >                     5                    �    ?                     >                    �    @                     P                    �    A                     b                    �    B                     i                    �    C                     �                    �    D                     �                    �    E                     �                    �    F                     �                    �    G                     �                    �    H                     �                    �    I                                         �    J                     .                    �    K                     B                    �    L                     V                    �    M                     [                    �    N                     k                    5�_�                       	    ����                                                                                                                                                                                                                                                                                                                            '           P          v       b%X    �   N   P   P      	extensions = { "fugitive" },�   M   O   P      	tabline = {},�   L   N   P      	},�   K   M   P      		lualine_z = {},�   J   L   P      		lualine_y = {},�   I   K   P      		lualine_x = { "location" },�   H   J   P      		lualine_c = { "filename" },�   G   I   P      		lualine_b = {},�   F   H   P      		lualine_a = {},�   E   G   P      	inactive_sections = {�   D   F   P      	},�   C   E   P      		lualine_z = { "location" },�   B   D   P      		lualine_y = { "progress" },�   A   C   P      		},�   @   B   P      			"filetype",�   ?   A   P      			"encoding",�   >   @   P      			},�   =   ?   P      N				symbols = { error = " ", warn = " ", info = " ", hint = " " },�   <   >   P      $				sources = { "nvim_diagnostic" },�   ;   =   P      				"diagnostics",�   :   <   P      			{�   9   ;   P      		lualine_x = {�   8   :   P      		lualine_c = { "filename" },�   7   9   P      		lualine_b = { "branch" },�   6   8   P      		lualine_a = { "mode" },�   5   7   P      	sections = {�   4   6   P      	},�   3   5   P      		disabled_filetypes = {},�   2   4   P      7		section_separators = { left = "", right = "" },�   1   3   P      9		component_separators = { left = "", right = "" },�   0   2   P      -		theme = "tokyonight", --onedark, tokyonight�   /   1   P      		icons_enabled = true,�   .   0   P      	options = {�   )   +   P      	Hint = "#10B981",�   (   *   P      	Information = "#0db9d7",�   '   )   P      	Warning = "#e0af68",�   &   (   P      	Error = "#db4b4b",�   &   P   P   )     Error = "#db4b4b",     Warning = "#e0af68",     Information = "#0db9d7",     Hint = "#10B981",   })       -- LUALINE:   require("lualine").setup({     options = {       icons_enabled = true,   /    theme = "tokyonight", --onedark, tokyonight   ;    component_separators = { left = "", right = "" },   9    section_separators = { left = "", right = "" },       disabled_filetypes = {},     },     sections = {       lualine_a = { "mode" },       lualine_b = { "branch" },       lualine_c = { "filename" },       lualine_x = {         {           "diagnostics",   (        sources = { "nvim_diagnostic" },   R        symbols = { error = " ", warn = " ", info = " ", hint = " " },         },         "encoding",         "filetype",       },       lualine_y = { "progress" },       lualine_z = { "location" },     },     inactive_sections = {       lualine_a = {},       lualine_b = {},       lualine_c = { "filename" },       lualine_x = { "location" },       lualine_y = {},       lualine_z = {},     },     tabline = {},     extensions = { "fugitive" },5��    &       (      (      �      �      |      �    &                     �                    �    '                     �                    �    (                     �                    �    )                     �                    �    .                     /                    �    /                     =                    �    0           -       /   W      -       /       �    1           9       ;   �      9       ;       �    2           7       9   �      7       9       �    3                     �                    �    4                                         �    5                                         �    6                     .                    �    7                     J                    �    8                     h                    �    9                     �                    �    :                     �                    �    ;                     �                    �    <           $       (   �      $       (       �    =           N       R   �      N       R       �    >                     5                    �    ?                     >                    �    @                     P                    �    A                     b                    �    B                     i                    �    C                     �                    �    D                     �                    �    E                     �                    �    F                     �                    �    G                     �                    �    H                     �                    �    I                                         �    J                     .                    �    K                     B                    �    L                     V                    �    M                     [                    �    N                     k                    5�_�                       	    ����                                                                                                                                                                                                                                                                                                                            '           P          v       b&    �   N   P   P      	extensions = { "fugitive" },�   M   O   P      	tabline = {},�   L   N   P      	},�   K   M   P      		lualine_z = {},�   J   L   P      		lualine_y = {},�   I   K   P      		lualine_x = { "location" },�   H   J   P      		lualine_c = { "filename" },�   G   I   P      		lualine_b = {},�   F   H   P      		lualine_a = {},�   E   G   P      	inactive_sections = {�   D   F   P      	},�   C   E   P      		lualine_z = { "location" },�   B   D   P      		lualine_y = { "progress" },�   A   C   P      		},�   @   B   P      			"filetype",�   ?   A   P      			"encoding",�   >   @   P      			},�   =   ?   P      N				symbols = { error = " ", warn = " ", info = " ", hint = " " },�   <   >   P      $				sources = { "nvim_diagnostic" },�   ;   =   P      				"diagnostics",�   :   <   P      			{�   9   ;   P      		lualine_x = {�   8   :   P      		lualine_c = { "filename" },�   7   9   P      		lualine_b = { "branch" },�   6   8   P      		lualine_a = { "mode" },�   5   7   P      	sections = {�   4   6   P      	},�   3   5   P      		disabled_filetypes = {},�   2   4   P      7		section_separators = { left = "", right = "" },�   1   3   P      9		component_separators = { left = "", right = "" },�   0   2   P      -		theme = "tokyonight", --onedark, tokyonight�   /   1   P      		icons_enabled = true,�   .   0   P      	options = {�   )   +   P      	Hint = "#10B981",�   (   *   P      	Information = "#0db9d7",�   '   )   P      	Warning = "#e0af68",�   &   (   P      	Error = "#db4b4b",�   &   P   P   )     Error = "#db4b4b",     Warning = "#e0af68",     Information = "#0db9d7",     Hint = "#10B981",   })       -- LUALINE:   require("lualine").setup({     options = {       icons_enabled = true,   /    theme = "tokyonight", --onedark, tokyonight   ;    component_separators = { left = "", right = "" },   9    section_separators = { left = "", right = "" },       disabled_filetypes = {},     },     sections = {       lualine_a = { "mode" },       lualine_b = { "branch" },       lualine_c = { "filename" },       lualine_x = {         {           "diagnostics",   (        sources = { "nvim_diagnostic" },   R        symbols = { error = " ", warn = " ", info = " ", hint = " " },         },         "encoding",         "filetype",       },       lualine_y = { "progress" },       lualine_z = { "location" },     },     inactive_sections = {       lualine_a = {},       lualine_b = {},       lualine_c = { "filename" },       lualine_x = { "location" },       lualine_y = {},       lualine_z = {},     },     tabline = {},     extensions = { "fugitive" },5��    &       (      (      �      �      |      �    &                     �                    �    '                     �                    �    (                     �                    �    )                     �                    �    .                     /                    �    /                     =                    �    0           -       /   W      -       /       �    1           9       ;   �      9       ;       �    2           7       9   �      7       9       �    3                     �                    �    4                                         �    5                                         �    6                     .                    �    7                     J                    �    8                     h                    �    9                     �                    �    :                     �                    �    ;                     �                    �    <           $       (   �      $       (       �    =           N       R   �      N       R       �    >                     5                    �    ?                     >                    �    @                     P                    �    A                     b                    �    B                     i                    �    C                     �                    �    D                     �                    �    E                     �                    �    F                     �                    �    G                     �                    �    H                     �                    �    I                                         �    J                     .                    �    K                     B                    �    L                     V                    �    M                     [                    �    N                     k                    5�_�                        	    ����                                                                                                                                                                                                                                                                                                                            '           P          v       b&*    �   N   P   P      	extensions = { "fugitive" },�   M   O   P      	tabline = {},�   L   N   P      	},�   K   M   P      		lualine_z = {},�   J   L   P      		lualine_y = {},�   I   K   P      		lualine_x = { "location" },�   H   J   P      		lualine_c = { "filename" },�   G   I   P      		lualine_b = {},�   F   H   P      		lualine_a = {},�   E   G   P      	inactive_sections = {�   D   F   P      	},�   C   E   P      		lualine_z = { "location" },�   B   D   P      		lualine_y = { "progress" },�   A   C   P      		},�   @   B   P      			"filetype",�   ?   A   P      			"encoding",�   >   @   P      			},�   =   ?   P      N				symbols = { error = " ", warn = " ", info = " ", hint = " " },�   <   >   P      $				sources = { "nvim_diagnostic" },�   ;   =   P      				"diagnostics",�   :   <   P      			{�   9   ;   P      		lualine_x = {�   8   :   P      		lualine_c = { "filename" },�   7   9   P      		lualine_b = { "branch" },�   6   8   P      		lualine_a = { "mode" },�   5   7   P      	sections = {�   4   6   P      	},�   3   5   P      		disabled_filetypes = {},�   2   4   P      7		section_separators = { left = "", right = "" },�   1   3   P      9		component_separators = { left = "", right = "" },�   0   2   P      -		theme = "tokyonight", --onedark, tokyonight�   /   1   P      		icons_enabled = true,�   .   0   P      	options = {�   )   +   P      	Hint = "#10B981",�   (   *   P      	Information = "#0db9d7",�   '   )   P      	Warning = "#e0af68",�   &   (   P      	Error = "#db4b4b",�   &   P   P   )     Error = "#db4b4b",     Warning = "#e0af68",     Information = "#0db9d7",     Hint = "#10B981",   })       -- LUALINE:   require("lualine").setup({     options = {       icons_enabled = true,   /    theme = "tokyonight", --onedark, tokyonight   ;    component_separators = { left = "", right = "" },   9    section_separators = { left = "", right = "" },       disabled_filetypes = {},     },     sections = {       lualine_a = { "mode" },       lualine_b = { "branch" },       lualine_c = { "filename" },       lualine_x = {         {           "diagnostics",   (        sources = { "nvim_diagnostic" },   R        symbols = { error = " ", warn = " ", info = " ", hint = " " },         },         "encoding",         "filetype",       },       lualine_y = { "progress" },       lualine_z = { "location" },     },     inactive_sections = {       lualine_a = {},       lualine_b = {},       lualine_c = { "filename" },       lualine_x = { "location" },       lualine_y = {},       lualine_z = {},     },     tabline = {},     extensions = { "fugitive" },5��    &       (      (      �      �      |      �    &                     �                    �    '                     �                    �    (                     �                    �    )                     �                    �    .                     /                    �    /                     =                    �    0           -       /   W      -       /       �    1           9       ;   �      9       ;       �    2           7       9   �      7       9       �    3                     �                    �    4                                         �    5                                         �    6                     .                    �    7                     J                    �    8                     h                    �    9                     �                    �    :                     �                    �    ;                     �                    �    <           $       (   �      $       (       �    =           N       R   �      N       R       �    >                     5                    �    ?                     >                    �    @                     P                    �    A                     b                    �    B                     i                    �    C                     �                    �    D                     �                    �    E                     �                    �    F                     �                    �    G                     �                    �    H                     �                    �    I                                         �    J                     .                    �    K                     B                    �    L                     V                    �    M                     [                    �    N                     k                    5��