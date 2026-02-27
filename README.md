# Neovim Configuration

A personal Neovim setup focused on development productivity.

## Setup Overview

- **LSP and autocompletion**: Mason-managed language servers with common LSP navigation/actions.
- **Formatting**: Conform integration with language-specific formatters and format-on-save.
- **Search and navigation**: Telescope bindings for files, grep, and man pages.
- **File management**: Custom bindings to create, rename, and remove files.
- **Debugging**: nvim-dap with UI and Python/Go debugging helpers.
- **Terminal workflow**: Floating terminal toggle for quick shell access.
- **Diagnostics and quality of life**: Diagnostic views, search clear, autosave on focus/buffer leave, and config reload shortcuts.

## Keybindings

### General

| Key | Description |
| --- | --- |
| `<leader><leader>` | Switch to previous buffer |
| `<leader>/` | Clear search highlight |
| `<leader>ss` | Source `init.lua` |
| `<leader>sc` | Source current file |

### LSP and Diagnostics

| Key | Description |
| --- | --- |
| `<leader>sl` | Restart configured LSP servers |
| `K` | Show hover documentation |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `grn` | Rename symbol |
| `gi` | Go to implementation |
| `<leader>e` | Show line diagnostic |
| `<leader>E` | Show diagnostics list |

### Telescope

| Key | Description |
| --- | --- |
| `<leader>ff` | Find files (including hidden) |
| `<leader>fg` | Live grep |
| `<leader>fm` | Browse man pages |

### Formatting

| Key | Description |
| --- | --- |
| `<leader>fb` | Format current buffer |

### File Operations

| Key | Description |
| --- | --- |
| `<leader>tf` | Create a new file in selected folder |
| `<leader>rn` | Rename current file |
| `<leader>rm` | Remove current file |

### Debugging (DAP)

| Key | Description |
| --- | --- |
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue/start debugging |
| `<leader>do` | Step over |
| `<leader>di` | Step into |
| `<leader>dO` | Step out |
| `<leader>dq` | Terminate debugging session |
| `<leader>du` | Toggle DAP UI |

### Terminal

| Key | Description |
| --- | --- |
| `<leader>a` | Toggle floating terminal |

