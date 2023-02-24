| Function                    | Hotkey       |
| --------------------------- | ------------ |
| [R]e[n]ame                  | \<leader\>rn |
| [C]ode [A]ction             | \<leader\>ca |
| [G]oto [D]efinition         | gd           |
| [G]oto [R]eferences         | gr           |
| [G]oto [I]mplementation     | gI           |
| Type [D]efinition           | \<leader\>D  |
| [D]ocument [S]ymbols        | \<leader\>ds |
| [W]orkspace [S]ymbols       | \<leader\>ws |
| Hover Documentation         | K            |
| Signature Documentation     | \<C-k\>      |
| [G]oto [D]eclaration        | gD           |
| [W]orkspace [A]dd Folder    | \<leader\>wa |
| [W]orkspace [R]emove Folder | \<leader\>wr |
| [W]orkspace [L]ist Folders  | \<leader\>wl |
| Goto next diagnostic        | ]d           |
| Goto prev diagnostic        | \[d          |
| Open diagnostic float       | \<leader\>e  |
| Set Loc List                | \<leader\>q  |

<hr>

# Treesitter

| Mode   | Function          | Hotkey           |
| ------ | ----------------- | ---------------- |
| Visual | init selection    | CTRL + SPACE     |
| Visual | node incremental  | CTRL + SPACE     |
| Visual | scope incremental | CTRL + S         |
| Visual | node decremental  | CTRL + BACKSPACE |

## Textobjects

### Select

| Mode   | Function         | Hotkey |
| ------ | ---------------- | ------ |
| Visual | @parameter.outer | aa     |
| Visual | @parameter.inner | ia     |
| Visual | @function.outer  | af     |
| Visual | @function.inner  | if     |
| Visual | @class.outer     | ac     |
| Visual | @class.inner     | ic     |

### Move

#### Goto Next Start

| Mode   | Function        | Hotkey |
| ------ | --------------- | ------ |
| Normal | @function.outer | ]m     |
| Normal | @class.outer    | ]]       |

#### Goto Next End

| Mode   | Function        | Hotkey |
| ------ | --------------- | ------ |
| Normal | @function.outer | ]M     |
| Normal | @class.outer    | ]\[    |

#### Goto Previous Start

| Mode   | Function        | Hotkey |
| ------ | --------------- | ------ |
| Normal | @function.outer | ]m     |
| Normal | @class.outer    | \[\[   |

#### Goto Previous End

| Mode   | Function        | Hotkey |
| ------ | --------------- | ------ |
| Normal | @function.outer | \[M    |
| Normal | @class.outer    | \[]    |

### Swap

| Mode   | Function         | Hotkey     | Description
| ------ | ---------------- | ---------- | --- |
| Normal | @parameter.inner | \<leader>a | Swap Next |
| Normal | @parameter.inner | \<leader>A | Swap Previous |

