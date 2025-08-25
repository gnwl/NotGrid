# NotGrid
NotGrid is a party and raid frame addon for Vanilla World of Warcraft (1.12.1). While heavily based off of the original addon Grid, it both lacks some Grid features as well as adds new ones. It supports Clique keybinds & macros, Lazyspell, healcomm, eight buff/debuff icons around the unit frame, low mana & aggro warning, proximity checking, pets, and a simple config menu for general resizing/coloring options.

![Screenshot](media/screenshot.jpg)

## Usage
Use */notgrid* or */ng* to show the config menu.  
Use */notgrid grid* to generate a style similar to the original grid.  
Use */notgrid reset* to restore the default settings.  
Use */notgrid profile save <profilename>* to save current settings as a profile (account-wide).  
Use */notgrid profile load <profilename>* to load a saved profile (account-wide).  
Use */notgrid profile delete <profilename>* to delete a saved profile (account-wide).  
Use */notgrid profile list* to show all available profiles (account-wide).  
Use / for separating multiple Buffs/Debuffs to track on one icon.  
Use */ngcast spellname(Rank X)* in macros for mouseover casting.

## Optional Dependencies
Clique: Enables click-casting on your unit frames.  
LazySpell: Enables Clique and /ngcast auto spell rank scaling depending on unit health deficit.

## Additional Note
If you're having issues with the frame borders/edges being un-uniformly sized or appearing clipped by the healthbar make sure to have a proper [UI scale](http://wow.gamepedia.com/UI_Scale) set.  
TLDR: If you play with a 1920x1080 resolution, the correct UI scale would be 768/1080 = 0.7111..., and you would set that by typing */console UIScale 0.7111111111* in the chat.
