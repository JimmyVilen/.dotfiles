# dotfiles

Jimmy Vilén's personal dotfiles, managed with [chezmoi](https://chezmoi.io).

## Innehåll

| Kategori | Filer |
|---|---|
| Shell | `.zshrc`, `.bashrc`, `.profile` |
| Git | `.gitconfig`, `.config/git/ignore` |
| SSH | `.ssh/config` (inga privata nycklar) |
| Neovim | `.config/nvim/` (LazyVim) |
| Tmux | `.config/tmux/tmux.conf` |
| GitHub CLI | `.config/gh/config.yml` |
| lazygit | `.config/lazygit/config.yml` |
| htop | `.config/htop/htoprc` |
| Claude Code | `.claude/settings.json`, `.claude/commands/` |

---

## Bootstrap på ny maskin

### 1. Installera chezmoi och applicera dotfiles

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin \
    init --apply JimmyVilen
```

Det här kommandot:
- Installerar chezmoi till `~/.local/bin`
- Klonar detta repo till `~/.local/share/chezmoi/`
- Kör `chezmoi apply` (kopierar alla filer till rätt platser)
- Kör alla `run_once_`-skript: apt-paket, Oh My Zsh, nvm, TPM

### 2. Manuella steg efteråt

```bash
# Sätt zsh som default shell
chsh -s $(which zsh)

# Logga in med GitHub CLI
gh auth login

# Installera Node (via nvm)
source ~/.nvm/nvm.sh
nvm install --lts

# Installera bun
curl -fsSL https://bun.sh/install | bash

# Installera pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Installera uv (Python)
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### 3. SSH-nycklar

SSH-nycklar lagras aldrig i repot. Kopiera dem manuellt från en säker källa:

```bash
# Sätt rätt permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/jimmy-work-github
chmod 600 ~/.ssh/jimmy-work-azure-devops
```

### 4. Tmux-plugins

Starta tmux och tryck `prefix + I` (stort i) för att installera plugins via TPM.

---

## Dagligt workflow

### Synka en befintlig fil till source (vanligaste)

Du har ändrat en fil direkt (`~/.zshrc`, `~/.config/tmux/tmux.conf`, etc.) och vill spara ändringen:

```bash
chezmoi re-add ~/.zshrc
chezmoi re-add ~/.config/tmux/tmux.conf

# Pusha
chezmoi git add -- -A
chezmoi git commit -- -m "Update tmux config"
chezmoi git push
```

### Redigera via chezmoi (öppnar $EDITOR i source-katalogen)

```bash
chezmoi edit ~/.config/tmux/tmux.conf
chezmoi apply ~/.config/tmux/tmux.conf
```

### Dra in ändringar från annan maskin

```bash
chezmoi update   # = git pull + chezmoi apply
```

---

## Lägg till en ny fil

```bash
# Enkel fil
chezmoi add ~/.config/foo/config.toml

# Fil med känsligare permissions (t.ex. SSH-config)
chezmoi add --mode 0600 ~/.ssh/config

# Fil som template (för maskinspecifika värden)
chezmoi add --template ~/.config/foo/config.toml

# Hel katalog
chezmoi add ~/.config/foo/
```

Sedan commit och push:

```bash
chezmoi git add -- -A
chezmoi git commit -- -m "Add foo config"
chezmoi git push
```

### Känsliga filer – lägg till i .chezmoiignore

Filer som aldrig ska committас (SSH-nycklar, tokens, etc.) läggs till i
`~/.local/share/chezmoi/.chezmoiignore`:

```
private_dot_ssh/my-secret-key
dot_config/something/secret.json
```

---

## Struktur i source-katalogen

chezmoi använder ett namnprefix-system för att mappa source → target:

| Source-namn | Target-sökväg |
|---|---|
| `dot_zshrc` | `~/.zshrc` |
| `dot_zshrc.tmpl` | `~/.zshrc` (renderas som template) |
| `dot_config/tmux/tmux.conf` | `~/.config/tmux/tmux.conf` |
| `private_dot_ssh/config` | `~/.ssh/config` (mode 0600) |
| `private_dot_claude/settings.json` | `~/.claude/settings.json` |
| `empty_config.yml` | `config.yml` (tom fil – skapas ändå) |
| `run_once_foo.sh` | Körs en gång vid `chezmoi apply` |
| `run_onchange_foo.sh` | Körs om skriptets innehåll ändras |

Source-katalogen ligger i `~/.local/share/chezmoi/`.

---

## Felsökning

```bash
# Vad skulle chezmoi ändra just nu?
chezmoi diff

# Vilka filer hanteras?
chezmoi managed

# Kontrollera en specifik fils status
chezmoi status ~/.zshrc

# Verifiera att en template renderas rätt
chezmoi execute-template < ~/.local/share/chezmoi/dot_zshrc.tmpl

# Gå till source-katalogen
chezmoi cd        # öppnar nytt shell
# eller
cd $(chezmoi source-path)
```

---

## chezmoi-config (`~/.config/chezmoi/chezmoi.toml`)

Chezmois egna config hanteras **inte** av chezmoi självt (ignoreras via `.chezmoiignore`).
Skapa den manuellt på varje maskin:

```toml
[data]
    name = "Jimmy Vilén"
    email = "jimmy@vilen.nu"
    github_user = "jimmyvilen"
```

Maskinspecifik data (t.ex. annorlunda `$HOME`-sökväg) kan läggas till här under `[data]`
för att overrida värdena i `.chezmoidata.toml`.
