# Changelog
## v0.200

**Optical changes**
 - Changed favorites badge design based from the gameOS theme (https://github.com/PlayingKarrde/gameOS)
 - Changed the currently selected game border to use a color cycle animation to make it more clear. The color of the border can either be consistent across the color theme, or can change based on the particular collection (settings option)
 - New option for colorfull manufacturer logos shown on the Collections screen
 - New/ Updated background art/logos or color theme choices for the various collections or base themes
 - Option to disable background image

**Usability/Performance Adjustments**
 - Page up/Page down can be configured via settings to either skip to next/previous collection when in the game grid view (default), or can instead be used to rapidly scroll up/down the games list for quicker navigation of large collections
 - The collections carousel now supports press & hold to quickly scroll through the list
 - Several updates to improve performance so no stutters or delays when scrolling through collections or games, or loading the theme etc
 - Will automatically render the game title, year and detail text as either dark or light color depending on the background color to ensure readability in all configurations
- optimized svg graphics

**New Features**
- Dedicated Last Played + Favorites collections can be enabled or disabled via Settings menu
- Collection Category support (requires custom metadata) - able to group collections into Categories - use the Filters key to toggle each category in the collections view
- Games Sorting - Use the Select/Back button on the controller to toggle sorting game grid by Title/Last Played/Favorite/Genre or Rating.
- Custom Sorting (requires custom metadata) - define a custom sort order for specific collections based on game metadata values
- Completed Game Ribbon (requires custom metadata) - Adds a "Completed" ribbon to games you've marked as complete in your game metadata
- Arcade Port tag (requires custom metadata) - Adds an "Arcade Port" icon to the games detail view if you've marked the game as an arcade port in your game metadata

## v0.138
- Fix: missing last collection when switching between collections from the games screen with 'All games' collection on
- new filtering menu for games screen
- Fix: grid incorrect list focus on return from game
- updated logos
- RoeTaKa's custom sfx & bgm music
- more translations
## v0.137
- changed icons for osc and others from svg to custom font for better rendering on Android
- fallback artwork for steam games without portrait
- option for dynamic font scaling
- layout jumping fix, thx to [sargant](https://github.com/sargant)
- japanese like osc (swapped Accept / Back), thx to [sargant](https://github.com/sargant)
## v0.136
- portuguese translation, thx to [RickEves](https://github.com/RickEves)

## v0.135
- SteamOS3 (steam deck) inspired color scheme

## v0.134
- smaler fixes
- dynamic layout for game screen based on displayed grid rows
- dynamic game screen grid rows option based on the number of items in the current collection

## v0.133
- added option to switch logo variants between region specific versions (snes, megadrive, pcengine...)
- added french translations, thx to [HunkDeath](https://github.com/HunkDeath)  & [fansubmaniac](https://github.com/fansubmaniac)
- added collection video support
  - for now no videos are bundled with the theme since I'm not sure if it's allowed to include them if they are created by other sources like emumovies or screenscraper
  - users can provide their collection videos by setting a default collection video in their [Pegasus metadata](https://pegasus-frontend.org/docs/user-guide/meta-assets/#collection-assets-in-the-metadata-file), so no tinkering with the theme files is needed
## v0.132
- video playback support
- background image support
- changed sound assets
- save game index for returning after gaming
- fix for sensible analogue triggers
- a `all Games` collection
- filter for multiplayer games
- added new collections and updated existing collections assets (logo + art) and information
- added a badge for favorited games on the grid on the `games` screen
- color scheme support with three colorschemesso far: `dark`, `light` and `ozoneDark` (changeable in new settings menu)
- translations support
- customizable theme settings
  - change the grid size of the `games` screen
  - select between two views for `games` screen grid: screenshots with logo or boxart
  - mute videos / disable video playback at all
  - mute sounds
  - hide onscreen controls / use different layouts (xbox , playstation, universal)
  - select between colorful or monochrome icons for your collections
  - customize the collections colors: dimm or bright variants / one color tone per collection or two colors
- other layout optimisations
- cleanups

## v0.131
- fix looping bug #5

## v0.13
- add assets for new systems (ps3, switch, wiiware)
- few hotfixes (may break things later...)

## v0.12
- remove unused code blocks
- downgrade QT modules
- fix Launchbox shortname function
- fix collection logo not showing in the menu

## v0.11
- new collections backgrounds and logos
- preparation for future "all games" and/or "favorites" collections
- launchbox shortName now compatible (for a certain amount of systems)

## v0.1
- Initial commit.
- Theme fully working.
