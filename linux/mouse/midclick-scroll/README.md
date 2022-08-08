


```
# Install sxhkd
sudo pacman -S xdotool xsel sxhkd xorg-xinput

# Add env variable to .bashrc
export XDG_CONFIG_HOME=/home/deck/.config

# Copy configurations config directory

cp autoscroll.sh $XDG_CONFIG_HOME/sxhkd/
cp sxhkdrc $XDG_CONFIG_HOME/sxhkd/

cp sxhkd.desktop ~/.config/autostart/

```