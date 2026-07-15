# Dotfiles Strategy

A plan to evolve this repo from "manual symlinks + a brew bundle" into something you can clone and bootstrap with one command on any of your machines (primary mac, secondary macs, Ubuntu desktop, various Linux servers), while keeping configs shared, overridable, and selectable.

---

## 1. Pick the right level of tooling

You have three reasonable tiers. Pick the simplest one that solves your problem; the trap is reaching for the heaviest tool first.

### Tier A — GNU `stow` + a `bootstrap.sh`
- `stow` just creates symlinks based on directory structure. `stow zsh` symlinks `zsh/.zshrc` to `$HOME/.zshrc`, etc.
- You keep your current "files in folders" mental model. No templating, no DSL.
- OS differences and profiles are handled by your `bootstrap.sh` (which packages to `stow`, which package manager to invoke).
- **Best when:** configs are mostly identical across machines and per-machine differences are small (a few env vars, a few extra plugins).

### Tier B — `chezmoi`
- Single binary, written in Go, runs on macOS/Linux/BSD with no runtime deps.
- Built-in templating (`{{ if eq .chezmoi.os "darwin" }}`), per-machine data, secret handling, encrypted files, and `chezmoi apply` is idempotent.
- Has a real model for "this file is mostly shared but slightly different on Linux."
- **Best when:** you have meaningful divergence between machines (different paths, different package managers inline in configs, machine-class differences like "server vs workstation").

### Tier C — Ansible / Nix / home-manager
- Overkill for your stated needs and a much bigger maintenance burden. Skip unless you actually want declarative system state.

**Recommendation:** start with **Tier A (stow + bash bootstrap)**. It maps cleanly onto what you already do (you're already symlinking by hand), and you can graduate to `chezmoi` later without throwing work away — the directory layout is similar. If you already know your configs need templating (e.g., a `.zshrc` that branches heavily on OS), jump straight to `chezmoi`.

The rest of this doc assumes Tier A and calls out where chezmoi would change things.

---

## 2. Repo layout

Reorganize around two ideas: **packages** (a stow-able unit) and **profiles** (which packages a machine wants).

```
dotfiles/
├── install.sh                  # the single entrypoint
├── lib/
│   ├── common.sh               # logging, OS detection, helpers
│   ├── pkg_macos.sh            # brew install foo
│   ├── pkg_debian.sh           # apt install foo
│   └── pkg_arch.sh             # pacman -S foo (if relevant)
├── profiles/
│   ├── workstation-mac.txt     # list of packages + stow modules
│   ├── workstation-linux.txt
│   ├── server.txt              # minimal: zsh, tmux, git, maybe tiny vim
│   └── default.txt
├── packages/                   # each subdir is a stow module
│   ├── zsh/
│   │   ├── .zshenv
│   │   └── .config/zsh/{zshrc,zprofile,...}
│   ├── tmux/
│   │   └── .config/tmux/tmux.conf
│   ├── nvim/
│   │   └── .config/nvim/...
│   ├── nvim-minimal/           # stripped-down vim for servers
│   │   └── .config/nvim/init.lua
│   ├── ghostty/
│   ├── alacritty/
│   ├── git/
│   │   └── .config/git/config
│   └── bin/
│       └── .local/bin/*
├── os/
│   ├── macos/
│   │   ├── Brewfile
│   │   ├── karabiner.json
│   │   └── defaults.sh         # `defaults write ...`
│   └── linux/
│       ├── apt-packages.txt
│       └── post-install.sh
└── scripts/                    # the things you already have
```

Key properties:
- Each `packages/<name>/` is a self-contained stow module. Running `stow -d packages -t $HOME nvim` materializes it.
- `packages/<name>/` mirrors the **target** layout. A file at `packages/zsh/.config/zsh/zshrc` ends up at `$HOME/.config/zsh/zshrc`.
- OS-specific stuff lives in `os/<os>/` and is invoked by `install.sh`, not stowed.
- A "profile" is just a list of package names to stow + package-manager packages to install.

---

## 3. The single-command bootstrap

The goal: on any machine, the entire setup is

```sh
git clone https://github.com/canta2899/dotfiles ~/.dotfiles && ~/.dotfiles/install.sh
```

What `install.sh` does, in order:

1. **Detect environment.** OS (`uname`), distro (`/etc/os-release`), arch, and machine class. Machine class can be a flag (`--profile server`) or inferred (no `$DISPLAY` and `uname -s = Linux` → likely server).
2. **Bootstrap the package manager.** Install Homebrew on macOS if missing; `apt update` on Debian/Ubuntu; etc. This is the one place where "install dependencies" is allowed to be imperative.
3. **Install packages from the profile.** `brew bundle --file=os/macos/Brewfile` on mac; `xargs apt install` on Debian. The profile file lists which package groups to pull.
4. **Stow the dotfile packages.** For each package in the profile, `stow -d packages -t $HOME <pkg>`. Stow's `--adopt` and `--restow` flags handle existing files gracefully.
5. **Run post-install hooks.** OS defaults, Karabiner import on mac, `chsh -s $(which zsh)`, tmux plugin install, `nvim --headless "+Lazy! sync" +qa`, etc.
6. **Be idempotent.** Running `install.sh` twice should be a no-op the second time. This is non-negotiable — it's what lets you treat it as "sync my machine" rather than "set up once and pray."

Flags worth supporting from day one:
- `--profile NAME` — override auto-detection.
- `--dry-run` — print actions without doing them.
- `--only zsh,tmux` — stow just these packages (useful when iterating).
- `--no-packages` — skip the package-manager step (useful on servers where you don't have sudo).

---

## 4. Handling shared vs OS-specific config

Three patterns, in order of preference:

### 4a. Sourced overlay files
Your `.zshrc` ends with:
```sh
[ -f ~/.config/zsh/zshrc.$(uname -s) ] && source ~/.config/zsh/zshrc.$(uname -s)
[ -f ~/.config/zsh/zshrc.local ]      && source ~/.config/zsh/zshrc.local
```
- `zshrc.Darwin` and `zshrc.Linux` ship in the repo and contain OS-specific PATH/aliases.
- `zshrc.local` is **gitignored** and holds per-machine secrets, work configs, hostname-specific tweaks.
- Same pattern for tmux (`source-file -F` with conditionals), git (`includeIf`), etc.

This pattern alone covers ~90% of cross-OS divergence without any templating.

### 4b. Per-OS stow packages
If a config diverges *a lot* between OSes, just have two packages: `nvim-mac` and `nvim-linux`, and let the profile pick. Don't try to make one file do both jobs if it gets ugly.

### 4c. Templating (only with chezmoi)
If you find yourself writing `if [ "$(uname)" = ... ]` inside many config files, that's the signal to migrate to chezmoi and use real templates. Don't pre-emptively template — it adds friction every time you edit a config.

---

## 5. Profiles: include/exclude per machine

A profile is just a text file. Example `profiles/server.txt`:
```
# stow modules
zsh
tmux
git
nvim-minimal
bin

# packages (resolved by lib/pkg_*.sh)
@core
@cli
```
And `profiles/workstation-mac.txt`:
```
zsh
tmux
git
nvim
ghostty
alacritty
bin

@core
@cli
@gui-mac
```

The `@group` syntax lets you define groups once in `lib/pkg_macos.sh` (`@gui-mac` → `karabiner-elements amethyst ghostty ...`) and reference them from any profile. Keeps profiles readable.

On first run, `install.sh` writes the chosen profile name to `~/.config/dotfiles/profile` so subsequent runs don't need the flag.

---

## 6. Things that are not "config files"

Several items in your current setup aren't really dotfiles and shouldn't be stowed:

- **Brewfile / apt list** → invoked by the bootstrap, not symlinked.
- **macOS `defaults write` commands** → a script in `os/macos/defaults.sh`, run once per machine, with a guard file (`~/.config/dotfiles/.macos-defaults-applied`) so you can re-run `install.sh` cheaply.
- **GUI app preferences (Karabiner, iTerm)** → symlink the JSON/plist into the app's config directory. Karabiner reads `~/.config/karabiner/karabiner.json`, so put it in a `packages/karabiner/` stow module.
- **Fonts, Nerd Fonts** → install via package manager (`brew install --cask font-...`, `apt install fonts-...`), don't ship binaries in the repo.
- **Neovim plugins** → don't vendor them. `lazy.nvim` will sync them on first run; the bootstrap can trigger it headlessly.

---

## 7. Secrets

Never commit them. Use one of:
- `~/.zshrc.local` (gitignored, hand-managed).
- A separate private repo cloned to `~/.dotfiles-private/` and stowed by `install.sh` if present.
- `chezmoi` with age/gpg encryption, if you migrate later.

Your existing `scripts/makenotesenv.sh` suggests you already think this way — formalize it.

---

## 8. Concrete migration path

You can do this incrementally without breaking your current setup:

1. **Move to XDG paths first.** You're already on `.config/zsh`, `.config/tmux`, `.config/nvim` — good. Move anything still in `$HOME` (like `.zshenv`) into the right place; `.zshenv` is the one file that *must* be in `$HOME`, everything else can move.
2. **Introduce the `packages/` directory.** Restructure your existing folders so each is a valid stow module. Test with `stow -nv` (dry-run, verbose) before applying.
3. **Write `install.sh` minimally.** First version: detect OS, run brew/apt, loop over a hard-coded package list, `stow` each. ~50 lines of bash.
4. **Add profiles.** Once you have two profiles (mac workstation + linux server) you'll feel the abstraction earn its keep.
5. **Add OS overlays in your shell configs.** Move the OS-specific bits of `.zshrc` into `zshrc.Darwin` / `zshrc.Linux`.
6. **Add a `Makefile`** as a thin convenience wrapper: `make install`, `make update`, `make stow PKG=nvim`, `make unstow PKG=nvim`. Easier to remember than flag combinations.
7. **CI smoke test (optional, high value).** A GitHub Actions job that runs `install.sh --profile server` inside an Ubuntu container and `install.sh --profile workstation-mac` on a macOS runner. Catches breakage before you hit it on a real machine.

---

## 9. What this gets you

- **One command per machine.** `git clone … && ./install.sh` — picks the right profile, installs the right packages, symlinks the right configs.
- **Same source of truth everywhere.** No more "which laptop has the good `.zshrc`."
- **Servers stay lean.** A `server` profile skips ghostty, karabiner, the full nvim setup; ships a minimal vim and basic shell.
- **Adding a new machine class is cheap.** Write a new profile file; reuse all existing packages.
- **Existing patterns still work.** stow is just symlinks under the hood, so you can debug with `ls -l` and you can stop using the tool any time without rewriting your configs.

---

## 10. When to graduate to chezmoi

Migrate when any of these become true:
- You have more than ~3 OS-conditional branches inside a single config file.
- You want encrypted secrets in the repo itself.
- You want a real `chezmoi diff` / `chezmoi apply` workflow rather than "stow and hope."
- You start managing config for non-technical machines (a partner's laptop, a VM you rarely touch) where you want the tool to be more careful.

Until then, stow + bash is the lower-friction answer.
