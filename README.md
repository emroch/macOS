# Mac

How I setup a new Mac. Adapted from [Carlos Alexandro Becker](https://github.com/caarlos0/macOS).

## 1. Install brew

```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## 2. Install deps

```sh
git clone https://github.com/emroch/mac.git
cd mac
# edit Brewfile to remove/add things
brew bundle
```

## 3. Install dotfiles
Managed dotfiles reside in [this repo](https://github.com/emroch/dotfiles).

```sh
git clone https://github.com/emroch/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./script/bootstrap
zsh
```

Not so-sensible defaults:

```console
./macos/set-defaults
```

## 4. Setup SSH keys

Create a new SSH key or copy the previous one into `~/.ssh`. That should be
it.

Also fix perms:

```console
$ chmod 0600 ~/.ssh/id_ed25519
```

## 5. Setup GPG signing

Create default config files:

```console
gpg --list-keys
```

Setup pinentry:

```console
$ brew install pinentry-mac  # handled by `brew bundle` in step 2
$ echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
$ killall gpg-agent
```

Setup git:

```console
$ export GPG_TTY=$(tty)
$ git config --global gpg.program $(which gpg)
$ git config --global user.signingkey C14AB940
$ git config --global commit.gpgsign true
```

> Change C14AB940 with your key id.

Test it:

```console
$ mkdir -p /tmp/test
$ cd $_
$ git init
$ git commit --allow-empty -m 'signsss'
$ git log --show-signature
```

That's it!


## 6. Reboot

```console
sudo reboot
```

## 7. Profit!

:beers:
