# Neovim setup (for rust+)

Install the following:

- Neovim >= 0.5
- [rust-analyzer](https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary) (must be in your path). You can use `brew` or `apt` to install for your OS.


## Shortcuts

`<leader> =`        `space` (default is `\`)

`w!!`               save with `sudo`, after opening and editing file without `sudo`    

`gcc`               comment current line or selected lines

`gcap`              comment current block or function

#### Maximizer

`<leader> m`        To maximize split window

#### Neoterm

`<ctrl> t`          Open terminal and toggle

`<leader> x`        Paste current line or selection to terminal

#### Telescope

`<leader><space>`   Git file search

`<leader>ff`        Fuzzy grep file contents in any Directory

`<leader>fn`        Fuzzy file search in current Directory

`<leader>fo`        Open current directory to browse files

`<leader>fd`        Fuzzy filename search in any Directory

`<leader>fD`        Fuzzy grep file contents in any Directory

`<leader>fg`        Git branches

`<leader>fb`        Files in current buffer

`<leader>fs`        Code structure of a file

#### LSP related

<c-]>   Jump to definition
gd      Jump to definition
K       Context menu
gD      Jump to definition
<c-k>   See Signature
1gD     Type definitions
gr      Find all references
g0      Symbols in document
gW      Symbols in workspace



