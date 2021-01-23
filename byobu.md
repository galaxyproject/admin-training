## byobu help

GAT virtual machines use byobu.

Byobu has some useful features such as allowing a session to be split into multiple sessions within the same terminal window. Some terminal behaviour may be different from what you are used to, particularly navigation through scrollback in the terminal. Some key bindings are listed here including instructions for scrolling in the terminal.

#### Scrolling
```
  F7                            Enter scroll mode
  Enter, Ctrl-C                 Exit scroll mode
  Up/Down                       Scroll up/down one line while in scroll mode
  PgUp/PgDown                   Scroll up/down one page while in scroll mode
  Fn+Up/Down                    (Mac users) Scroll up/down one page while in scroll mode
```

More byobu keybindings (from https://github.com/dustinkirkland/byobu/blob/master/usr/share/doc/byobu/help.tmux.txt)

```
  F1                             * Used by X11 *
    Shift-F1                     Display this help

  F2                             Create a new window
    Shift-F2                     Create a horizontal split
    Ctrl-F2                      Create a vertical split
    Ctrl-Shift-F2                Create a new session

  F3/F4                          Move focus among windows
    Alt-Left/Right               Move focus among windows
    Alt-Up/Down                  Move focus among sessions
    Shift-Left/Right/Up/Down     Move focus among splits
    Shift-F3/F4                  Move focus among splits

  F6                             Detach session and then logout
    Shift-F6                     Detach session and do not logout
    Alt-F6                       Detach all clients but yourself
    Ctrl-F6                      Kill split in focus

  F7                             Enter scrollback history
    Alt-PageUp/PageDown          Enter and move through scrollback
    Shift-F7                     Save history to $BYOBU_RUN_DIR/printscreen
```

[<- back to main page](https://github.com/galaxyproject/admin-training)