<img src="assets/logo_shinretro.png" width="55%" title="shinretro logo" />

# shinretro

Current Version: [0.134](CHANGELOG.md) [![GPLv3 license](https://img.shields.io/badge/license-GPLv3-blue.svg)](LICENSE)

A flexible and tweakable theme for [Pegasus Frontend](http://pegasus-frontend.org).
Forked from [Valentin MEZIN](https://github.com/valsou)'s theme [neoretrō](https://github.com/valsou/neoretro) v0.131 and [Luciano Oliveira](https://github.com/luciano-work)'s dark variant.

***

<details>
  <summary><b>Screenshots</b></summary>
  <img src="assets/screenshot/home_dark.png"  title="home"/>
  <img src="assets/screenshot/home_light.png" title="home"/>
  <img src="assets/screenshot/home_ozonedark.png"  title="home"/>
  <img src="assets/screenshot/collection_dark.png" title="collections" />
  <img src="assets/screenshot/collection_light.png" title="collections" />
  <img src="assets/screenshot/collection_ozonedark.png" title="collections" />
  <img src="assets/screenshot/games_dark.png" title="games" />
  <img src="assets/screenshot/games_light.png" title="games" />
  <img src="assets/screenshot/games_ozonedark.png" title="games" />
  <img src="assets/screenshot/settings_dark.png" title="settings" />
  <img src="assets/screenshot/settings_light.png" title="settings" />
  <img src="assets/screenshot/settings_ozonedark.png" title="settings" />
</details>

***

<details>
  <summary><b>Videos</b></summary>
  
  Theme review by [Retro Gaming Replay](https://www.youtube.com/channel/UC_9gbkxeMk3usXvSzYzimMw)
  
  [![new Pegasus front end theme neo retro dark - it's a great game display for Android devices](https://img.youtube.com/vi/YbPcsC95Qc0/0.jpg)](http://www.youtube.com/watch?v=YbPcsC95Qc0)
  
</details>
  
***

**Contributions are welcome**

You can code and found a bug in the theme you can fix or want to add a feature to the theme?
Or you can't code but want to add translations for your native language or you can provide some awsome artwork for the theme?

Simply have the courage and make a pull request :relaxed: 
You can find some guidances [here](HACKING.md).

## Features
- selectable color schemes
`dark` `light` `ozone dark`
- costumizable game view
- different onscreen control options
`Universal (Switch like)` `XBOX` `Playstation`
- different languages support
- toggleable video playback options

and more...
You can find explanations for the theme settings [here](SETTINGS.md).
  
## Metadata in use
- boxFront
- screenshot
- titlescreen (fallback for screenshot)
- wheel
- background
- video

## Regarding videos on collection screen
> NOTE: Videos for the collection screen are not included in the theme. You can provide them by setting a default video for your collection in the Pegasus metadata of the collection. EXAMPLE:
> 
    collection: Sony Playstation 2
    shortname: ps2
    assets.video: media/videos/default.mp4

## Work in progress
- [ ] clean the code...
- [ ] add more language options
- [ ] add more color schemes
- [ ] revise and add new or missing backgrounds/logos for collections and manufacturers 

## Considerations / ideas for the future
- [ ] provide some default collection videos
     - probalby need some original assets
- [ ] per collection fallback default background images
- [ ] filter by game genres / rework filtering system
     - The current filter system can only map simple scenarios. An extended filtering system could make it easier to navigate through the collections. A separate filter menu in the game screen instead of the quick button switch would be needed..

## Thanks to:
- [Valentin MEZIN](https://github.com/valsou) : Creator of the original neoretrō which this theme is based on
- [Luciano Oliveira](https://github.com/luciano-work) : Creator of the dark color scheme for neoretrō
- [HunkDeath](https://github.com/HunkDeath)  & [fansubmaniac](https://github.com/fansubmaniac) : french translations