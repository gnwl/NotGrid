# NotGrid
NotGrid is a party and raid frame addon for Vanilla World of Warcraft (1.12.1). While heavily based off of the original addon Grid, it both lacks some Grid features as well as adds new ones. It supports the default Clique keybinds (no unitdead/advanced macros), Lazyspell, healcomm, eight buff/debuff icons around the unit frame, low mana & aggro warning, proximity checking, and a simple config menu for general resizing/coloring options.

## Usage
Use */notgrid* or */ng* to show the config menu.  
Use */notgrid grid* to generate a style similar to the original grid.  
Use */notgrid reset* to restore the default settings.  
Use | for separating multiple Buffs/Debuffs to track on one icon.  
Use */ngcast spellname* in macros for mouseover casting.  

## Optional Dependencies
[BonusScanner](https://wow.curseforge.com/projects/project-1352): Enables Healcomm to factor in your bonus healing from gear.  
Clique: Enables click-casting on your unit frames.  
[LazySpell](https://github.com/satan666/LazySpell): Enables Clique auto spell rank scaling depending on unit health deficit.

## Additional Note
If you're having issues with the frame borders/edges being un-uniformly sized or appearing clipped by the healthbar make sure to have a proper [UI scale](http://wow.gamepedia.com/UI_Scale) set.  
TLDR: If you play with a 1920x1080 resolution, the correct UI scale would be 768/1080 = 0.7111..., and you would set that by typing */console UIScale 0.7111111111* in the chat.
