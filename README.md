
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


## Useful Reference

- https://github.com/haccks/zsh-config
- https://github.com/dkarter/dotfiles
- https://github.com/ryanoasis/nerd-fonts/tree/2.1.0
- https://github.com/ycm-core/YouCompleteMe