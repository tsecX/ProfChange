#!/bin/bash

echo -e "\033[1;31m"
echo "░█▀█░█▀▄░█▀█░█▀▀░█▀▀░█░█░█▀█░█▀█░█▀▀░█▀▀"
echo "░█▀▀░█▀▄░█░█░█▀▀░█░░░█▀█░█▀█░█░█░█░█░█▀▀"
echo "░▀░░░▀░▀░▀▀▀░▀░░░▀▀▀░▀░▀░▀░▀░▀░▀░▀▀▀░▀▀▀"
echo -e "\033[0m"

PROFILE_DIR=~/profiles
ACTION=$1
PROFILE_NAME=$2
TERMINAL=$3  # Third argument to specify 'terminator' or 'tmux'

if [ -z "$ACTION" ] || [ -z "$PROFILE_NAME" ] || [ -z "$TERMINAL" ]; then
    echo "Usage: $0 {save|load} profile_name {terminator|tmux}"
    exit 1
fi

if [ "$ACTION" == "save" ]; then
    # Create profile directories
    mkdir -p $PROFILE_DIR/$PROFILE_NAME/{i3,terminator,tmux,wallpapers}

    # Save i3 configuration
    if [ -f ~/.config/i3/config ]; then
        cp ~/.config/i3/config $PROFILE_DIR/$PROFILE_NAME/i3/config
        echo "i3 config saved."
    else
        echo "i3 config not found."
    fi

    # Save terminal configuration
    if [ "$TERMINAL" == "terminator" ]; then
        if [ -f ~/.config/terminator/config ]; then
            cp ~/.config/terminator/config $PROFILE_DIR/$PROFILE_NAME/terminator/config
            echo "Terminator config saved."
        else
            echo "Terminator config not found."
        fi
    elif [ "$TERMINAL" == "tmux" ]; then
        if [ -f ~/.tmux.conf ]; then
            cp ~/.tmux.conf $PROFILE_DIR/$PROFILE_NAME/tmux/tmux.conf
            echo "Tmux config saved."
        else
            echo "Tmux config not found."
        fi
    else
        echo "Invalid terminal option. Use 'terminator' or 'tmux'."
        exit 1
    fi

    # Save wallpaper
    WALLPAPER=$(grep -oP "(?<=feh --no-fehbg --bg-max ').*?(?=')" ~/.fehbg)
    if [ -f "$WALLPAPER" ]; then
        cp "$WALLPAPER" $PROFILE_DIR/$PROFILE_NAME/wallpapers/
        echo "Wallpaper saved."
    else
        echo "Wallpaper file not found: $WALLPAPER"
    fi

    echo "Profile $PROFILE_NAME saved."

elif [ "$ACTION" == "load" ]; then
    # Load i3 configuration
    if [ -f $PROFILE_DIR/$PROFILE_NAME/i3/config ]; then
        cp $PROFILE_DIR/$PROFILE_NAME/i3/config ~/.config/i3/config
        echo "i3 config restored."
    else
        echo "No i3 config found in profile $PROFILE_NAME."
    fi

    # Load terminal configuration
    if [ "$TERMINAL" == "terminator" ]; then
        if [ -f $PROFILE_DIR/$PROFILE_NAME/terminator/config ]; then
            cp $PROFILE_DIR/$PROFILE_NAME/terminator/config ~/.config/terminator/config
            echo "Terminator config restored."
        else
            echo "No Terminator config found in profile $PROFILE_NAME."
        fi
    elif [ "$TERMINAL" == "tmux" ]; then
        if [ -f $PROFILE_DIR/$PROFILE_NAME/tmux/tmux.conf ]; then
            cp $PROFILE_DIR/$PROFILE_NAME/tmux/tmux.conf ~/.tmux.conf
            echo "Tmux config restored."
            tmux source-file ~/.tmux.conf
        else
            echo "No Tmux config found in profile $PROFILE_NAME."
        fi
    else
        echo "Invalid terminal option. Use 'terminator' or 'tmux'."
        exit 1
    fi

    # Load wallpaper
    WALLPAPER=$(ls $PROFILE_DIR/$PROFILE_NAME/wallpapers/* 2>/dev/null)
    if [ -f "$WALLPAPER" ]; then
        feh --bg-max "$WALLPAPER"
        echo "Wallpaper restored."
    else
        echo "No wallpaper found in profile $PROFILE_NAME."
    fi

    # Reload i3 configuration
    i3-msg reload > /dev/null 2>&1
    echo "i3 configuration reloaded."

    echo "Profile $PROFILE_NAME loaded."

else
    echo "Invalid action: $ACTION. Use 'save' or 'load'."
    exit 1
fi
