## OSX

- Go to System Preferences -> Keyboard -> Shortcuts -> Services -> Files and Folders
  - Set open new iterm tab here -> cmd + shift + T
  - Set open new iterm window here -> cmd + ctrl + alt + T
- Setup Open Iterm in Finder
  - Run application `Automator`
  - file -> New -> Application -> Choose `Run Apple Script`
  - Copy paste `open_iterm_tab.scpt`
  - file -> export -> choose Application
  - hold cmd, drag the application to the finder toolbar
  - (Optional) right click iterm -> get info, right click the new tab application -> get info, drag iterm preview image to the new tab application icon to change the application icon similiar to iterm icon
- Update default setting
  - https://www.youtube.com/watch?v=psPgSN1bPLY
  


## Apps:

- https://iterm2.com/ - terminal
- https://matthewpalmer.net/vanilla/ - task icon manager
- https://rectangleapp.com/ - window manager
- https://www.keka.io/en/ - file archiver
- https://apps.apple.com/us/app/amphetamine/id937984704 - keep awake
- Install system monitor in menu bar 
run `brew install --cask stats` to install https://github.com/exelban/stats

Optional:
- https://www.alfredapp.com/ - finder
- https://meetfranz.com/ - omni channel messenger / email
- http://maddin.io/gestimer/ - small reminder
- https://aptonic.com/ - dragdrop clipboard
- https://tableplus.com/ - database client


### Installation commands
```
brew tap homebrew/cask-fonts
brew tap sambadevi/powerlevel9k
brew install --cask font-hack-nerd-font


# https://www.lunarvim.org/docs/installation
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

# Brew
brew install lazygit lazydocker ripgrep fzf gnu-sed neovim git powerlevel9k wget cmake putty kubectl redis redis-pro gradle helm terraform jenv jq antibody php@7.4 shivammathur/php/php@7.4 cocoapods rbenv ruby-build chruby ruby-install chruby keychain font-hack-nerd-font zsh nodejs python cmake

# Golang
brew install go
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
brew install golangci-lint

# Java
brew install java
sudo ln -sfn $(brew --prefix java)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# zsh, oh-my-zsh and terminal see terminal section


```

##  Terminal Reference

- https://github.com/haccks/zsh-config
- https://github.com/hyperupcall/autoenv
`brew install 'autoenv'`
- https://github.com/dkarter/dotfiles
- https://github.com/ryanoasis/nerd-fonts/tree/2.1.0
- https://github.com/ycm-core/YouCompleteMe


## Jetbrains

- Set ~/.vimrc
- Update ~/.ideavimrc

## Windows

### Change Skype annoying Ringtone

- `npm run -g asar`
- `cd /Applications/Skype.app/Contents/Resources`
- `asar extract app.asar app`
- `mv app.asar app.asar.bak`
- replace the media inside `/Applications/Skype.app/Contents/Resources/app/media`

## SteamDeck - Arch Linux

### Enable steam deck

#### Enable package manager:

```
sudo steamos-readonly disable
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman -Syu
yay -S debtap

sudo pacman -S flatpak
flatpak install flathub org.gnome.Platform.Compat.i386 org.freedesktop.Platform.GL32.default org.freedesktop.Platform.GL.default
```

#### Install Deb file

```
sudo debtap -u deck <installationfile>.deb
```

#### Basic Configuration

```
# run vscode from terminal
sudo ln -s /path/to/vscode/Code /usr/local/bin/code

# change password
passwd

# enable midclick scroll - see linux/mouse/midclick-scroll section

# configure git
git config --global user.email "you@example.com"
git config --global user.name "Your Name"

# mouse
sudo pacman -S piper
# if PGP issue, run:
sudo pacman-key --refresh-keys
# install piper
# https://flathub.org/apps/details/org.freedesktop.Piper
# set left mouse 5 button to ctrl+w

# disable middle click paste
# System tray > right click > Configure Clipboard. Uncheck the option 'Prevent empty clipboard'.

# Terminal - Konsole
# Setting -> configure shortcut
# Add ctrl+w to close window
# Add ctrl+d to Split view left
# Add ctrl+shift+d to Split view top
```

#### Optimize Battery

https://github.com/AdnanHodzic/auto-cpufreq#auto-cpufreq-installer

```
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && sudo ./auto-cpufreq-installer

systemctl start auto-cpufreq
systemctl status auto-cpufreq
systemctl enable auto-cpufreq

```

#### Steam deck as controller
https://www.reddit.com/r/SteamDeck/comments/v22ddf/guide_how_to_use_your_deck_as_a_steam_input/

### Useful SteamDeck References

- https://flathub.org/apps/collection/popular
- https://github.com/mikeroyal/Steam-Deck-Guide
- https://romsmania.cc/



