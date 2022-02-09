# Changelog
## v0.133
- added option to switch logo variants between region specific versions (snes, megadrive, pcengine...)
- added french translations,
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
