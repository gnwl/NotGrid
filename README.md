# NotGrid
NotGrid is a party and raid frame addon for Vanilla World of Warcraft (1.12.1). While heavily based off of the original addon Grid, it both lacks some Grid features as well as adds new ones. It supports the default Clique keybinds (no unitdead/advanced macros), Lazyspell, healcomm, eight buff/debuff icons around the unit frame, low mana & aggro warning, proximity checking, and a simple config menu for general resizing/coloring options.

## Usage
Use */notgrid* or */ng* to show the config menu.  
use */notgrid reset* to restore the default settings.

## Optional Dependencies
BonusScanner: Required for Healcomm to factor in your bonus healing from gear. https://wow.curseforge.com/projects/project-1352  
Clique: Enables click-casting and hover-casting on your unit frames.  
LazySpell: Enables auto healing spell rank scale for Clique depending on unit health deficit. https://github.com/satan666/LazySpell  

### Additional Note
If you're having issues with the frame borders/edges being un-uniformly sized or appearing clipped by the healthbar make sure to have a proper UI scale set: http://wow.gamepedia.com/UI_Scale  
TLDR: If you play with a 1920x1080 resolution, the correct UI scale would be 768/1080 = 0.7111..., and you would set that by typing */console UIScale 0.7111111111* in the chat.
