    #!/bin/bash
    killall waybar
    waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css & disown # Adjust paths as needed
