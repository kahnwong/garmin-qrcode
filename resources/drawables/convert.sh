#!/bin/bash

magick \( -size 1x1 \
xc:#000000 xc:#000055 xc:#0000aa xc:#0000ff \
xc:#005500 xc:#005555 xc:#0055aa xc:#0055ff \
xc:#00aa00 xc:#00aa55 xc:#00aaaa xc:#00aaff \
xc:#00ff00 xc:#00ff55 xc:#00ffaa xc:#00ffff \
xc:#550000 xc:#550055 xc:#5500aa xc:#5500ff \
xc:#555500 xc:#555555 xc:#5555aa xc:#5555ff \
xc:#55aa00 xc:#55aa55 xc:#55aaaa xc:#55aaff \
xc:#55ff00 xc:#55ff55 xc:#55ffaa xc:#55ffff \
xc:#aa0000 xc:#aa0055 xc:#aa00aa xc:#aa00ff \
xc:#aa5500 xc:#aa5555 xc:#aa55aa xc:#aa55ff \
xc:#aaaa00 xc:#aaaa55 xc:#aaaaaa xc:#aaaaff \
xc:#aaff00 xc:#aaff55 xc:#aaffaa xc:#aaffff \
xc:#ff0000 xc:#ff0055 xc:#ff00aa xc:#ff00ff \
xc:#ff5500 xc:#ff5555 xc:#ff55aa xc:#ff55ff \
xc:#ffaa00 xc:#ffaa55 xc:#ffaaaa xc:#ffaaff \
xc:#ffff00 xc:#ffff55 xc:#ffffaa xc:#ffffff \
+append -write mpr:garmin_palette +delete \) \
icon.png \
-resize 128x128^ -gravity center -extent 128x128 \
+dither -remap mpr:garmin_palette \
-define png:color-type=3 \
launcher_icon.png
