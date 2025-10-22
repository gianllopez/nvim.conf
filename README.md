# `neovim.conf`

A personal and minimal *Neovim* setup for software development.

---

## Dependencies

| What | Why it’s needed | Installation (Linux) |
|------|-----------------|---------------|
| `fzf` | Fuzzy-finder backend for *Telescope* | ```$ sudo apt install fzf``` |
| `python3-venv` | Virtual environment creation tool | ```$ sudo apt install python3-venv``` |
| `nodejs` | JavaScript runtime environment | [Official documentation](https://nodejs.org/en/download) |

---

## Installation steps

Complete the steps below to clone and configure the project.

### 1. Clone the repository

```bash
$ git clone https://github.com/gianllopez/neovim.conf ~/.config/nvim
```

### 3. Install `starship` (optional)

```bash
$ curl -sS https://starship.rs/install.sh | sh
```

### 3. Configure `starship` (optional)

```bash
$ vim ~/.config/starship.toml
```

And paste the following configuration:


```toml
add_newline = false

format = "$directory$git_branch$git_status$python->"

[python]
format = "(and \\[$virtualenv\\] )"

[battery]
disabled = true

[line_break]
disabled = true
```

