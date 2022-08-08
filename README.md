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

Productivity apps:

- https://matthewpalmer.net/vanilla/
- https://rectangleapp.com/
- https://www.alfredapp.com/
- https://meetfranz.com/
- https://alt-tab-macos.netlify.app/
- https://www.keka.io/en/
- https://software.intel.com/content/www/us/en/develop/articles/intel-power-gadget.html

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

### Useful SteamDeck References

- https://flathub.org/apps/collection/popular
- https://github.com/mikeroyal/Steam-Deck-Guide
- https://romsmania.cc/

## Useful Terminal Reference

- https://github.com/haccks/zsh-config
- https://github.com/dkarter/dotfiles
- https://github.com/ryanoasis/nerd-fonts/tree/2.1.0
- https://github.com/ycm-core/YouCompleteMe
