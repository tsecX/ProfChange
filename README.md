# ProfChange

Quick bash script to save and load profiles in Kali i3 desktop environment, with terminator/tmux and feh.

Allows you to save terminal options like color and fonts, backgrounds, and i3 config settings to a single profile(if you are indecisive like me and like to change these things around) simple, but I found it relatively useful =)!


### The script is being used on the environment based on xct's i3 setup script https://github.com/xct/kali-clean.

You will need terminator/tmux, i3 on Kali, feh.


### Currently the script will create a `profiles` directory in `~/`, but this can be changed.

## Make Executable
```
chmod +x prof_change.sh
```

## Save Profile
```
./prof_change.sh save <name of profile> <tmux/terminator>
```

## Load Profile
```
./prof_change.sh load <name of profile> <tmux/terminator>
```

You will see the i3/background change, and when you open terminator/tmux again, your settings will be set to the loaded profile.
