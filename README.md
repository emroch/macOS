# Mac

How I setup a new Mac. Adapted from [Carlos Alexandro Becker](https://github.com/caarlos0/macOS).

## 1. Install brew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
# This will install Command Line Tools if not already present
```

## 2. Install deps

```sh
git clone https://github.com/emroch/macOS.git ~/.macOS
cd ~/.macOS
# edit Brewfile to remove/add things
brew bundle
```

If installing apps from the Mac App Store, the installation will fail if not
signed into an Apple ID in the store. Running `brew bundle` again after
signing in will complete the installation.

## 3. Install dotfiles
Managed dotfiles reside in [this repo](https://github.com/emroch/dotfiles).

```sh
git clone https://github.com/emroch/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./script/bootstrap
zsh
# optional - may be required to properly configure some features (like vim)
dot_update
```

Zsh may complain about directory permissions being incorrect. Simply run the
following to correct it:
```sh
compaudit | xargs chmod g-w,o-w
```

It is also likely that the necessary fonts are not installed for the
powerlevel10k theme. From iTerm2, run `p10k configure` and select "Yes/Y" to
install the recommended font.

## 4. Reasonable defaults
Configure some reasonable default settings using `defaults write` and `pmset`.

```console
~/.macOS/set-defaults.sh
```

## 5. Setup SSH keys

1Password now supports storing SSH keys, so managing shared keys is very easy.

First, create a new SSH key to be the new Mac's identity. Name this key such that
the hostname and key type are clear (ie host_ed25519).
```console
ssh-keygen -t ed25519 -C "user@host"
```

Optionally, import the machine-specific key to 1Password. This will make it easy
to add the public key to other hosts, but is not required.

Also set up 1Password's SSH agent to provide access to the personal `id_25519`
key. 

1. [Turn on the 1Password SSH Agent](https://developer.1password.com/docs/ssh/get-started#step-3-turn-on-the-1password-ssh-agent)
2. [Configure your SSH or Git client](https://developer.1password.com/docs/ssh/get-started#step-4-configure-your-ssh-or-git-client)

## 6. Setup Git commit signing

1Password can also serve as a GPG signing agent using a particular SSH key.

[Configure Git commit signing with SSH](https://developer.1password.com/docs/ssh/git-commit-signing)

## 7. Reboot

Some steps of this setup may require a reboot to take full effect.

```console
sudo reboot
```

## 8. Profit!

:beers:
