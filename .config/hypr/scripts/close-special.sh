#!/bin/sh
# Close the special workspace (scratchpad) open on the focused monitor, if any.
# `hyprctl monitors` prints "special workspace: <id> (<name>)" before "focused: yes"
# in each monitor block; the name is empty when none is open.

name=$(hyprctl monitors | sed -n '
/^[[:space:]]*special workspace:/{
    s/^[^(]*(\(.*\))[[:space:]]*$/\1/
    h
}
/^[[:space:]]*focused: yes/{
    x
    p
    q
}')

[ -n "$name" ] || exit 0

# Lua config (0.56+): `hyprctl dispatch` takes a Lua dispatcher expression,
# the legacy `togglespecialworkspace <name>` form is rejected.
hyprctl dispatch "hl.dsp.workspace.toggle_special(\"${name#special:}\")" >/dev/null
