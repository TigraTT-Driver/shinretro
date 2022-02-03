# Guidance for contributions

## missing collections

Please check first if the collection in question is not already implemented.
First, make sure that you follow the [pegasus shortname guidelines](https://pegasus-frontend.org/docs/user-guide/meta-files/#metadata).

Some collections which are not on the official pegasus guidelines are already implemented and follow the naming convention of [recalbox](https://gitlab.com/recalbox/recalbox-themes), [batocera](https://wiki.batocera.org/systems) or [retropie](https://retropie.org.uk/docs/)
Please check first on these alternate shortnames.

To implement a new collection, please set the shortname as follows:
1. Pegasus guidelines
2. most common name on other named projects

For a new collection you must
1. create a new folder under assets/collections/`shortname` and place the needed image assets there  (logos & artwork).
2. You need to set the extra metadata for the collection in `theme.qml `under the array `dataConsoles`. The syntax is as follows:

> "`shortname`": { manufacturer: "`manufacturer_shortname`", release: "`release_year`", color: "`HTMLColorcode`", altColor: "`HTMLColorcode`" , altColor2: "`HTMLColorcode`" },
- shortname: your collection shortname
- manufacurer_shortname: shortname-version of collection manufacturer to load logo from assets/manufactures/logo
- release_year: earliest year of release
- HTMLColorcode: colors which represent the collection by a distinctive color in its device / game pad / logo or interface. Set these as follows:
    - color: primary color of collection. Used for tinted background
    - altColor: 10% darker color of primary color. Used for secondary color (selected border) when setting `Accent colors` is set to 1
    - altColor2: Another distinct color of the collection. Ideally, not a similar color as used for primary color. Secondary color (selected border) when setting `Accent colors` is set to 2

## missing art / logos or other graphics

All interface graphics need to be .svg vectors except for the collection artwork.
Graphics for documentation like screenshots can be in any pixel graphics.

### collection assets
Assets for collections are stored on assets/collections/`collection shortname`

| file | usage | description |
| --- | --- | --- |
| art.jpg  | collection artwork  | height of artwork needs to be 1,466 times of the width. some artwork / fanart of a game which represents the platform well. art should be from a game which:  1. Is in the top 10 by sales and by rankings (metacritc...). 2. should be a game which was for the time a exclusive for the platform. 3. try to get some artwork with many characters of the game in focus |
| logo_mono.svg  | monochrome collection logo | logo used when collection `logo variation` is set to `mono`. The default is the pal variation of the logo if exists and logos differ between regions. since the logo gets 'colorized' to different monochrome variants make sure it's really a mono colored svg with transparency|
| logo_`ntsc\ntscj`_mono.svg  | (optional) regional monochrome collection logo | monochrome logos for the ntsc regions when logos differ between regions |
| logo_color.svg  | colorfull collection logo | logo used when collection `logo variation` is set to `color`. The default is the pal variation of the logo if exists and logos differ between regions |
| logo_`ntsc\ntscj`_color.svg  | optional) regional colorfull collection logo | colorfull logos for the ntsc regions when logos differ between regions|

### onscreen controls
Assets for onscreen controls are stored on assets/buttons/`variaton`
All graphics need to be mono colored svg with transparency since the get 'colorized' to different monochrome variants
| file  | usage  |
|--|--|
| input_BTN-D.svg | select button, on an xbox-styled layout of buttons this is the down button (A) |
|input_BTN-L.svg | on an xbox-styled layout of buttons this is the left button (X)|
|input_BTN-LB.svg | left bumper button, on an xbox-styled layout of buttons this LB |
|input_BTN-LB.svg | left trigger button, on an xbox-styled layout of buttons this LT|
|input_BTN-R.svg | cancel/back button, on an xbox-styled layout of buttons this is the right button (B)|
|input_BTN-RB.svg | right bumper button, on an xbox-styled layout of buttons this RB|
|input_BTN-RT.svg | right trigger button, on an xbox-styled layout of buttons this RT|
|input_BTN-U.svg | on an xbox-styled layout of buttons this is the up button (Y)|

### manufactures logos
Assets for manufacturer are stored on assets/manufactures/logo/`manufacturer_shortname`.svg
All graphics need to be mono colored svg with transparency since the get 'colorized' to different monochrome variants. `manufacturer_shortname` must be the same name as in `theme.qml `under the array `dataConsoles` to get the graphic loaded.

## translations
All text information used by the theme is loaded from the array `dataText` from `theme.qml`.
Every language has it's language id. the theme follows the same naming of the [official pegasus translations](https://pegasus-frontend.org/docs/dev/translate/#2-prepare-the-translation-files)
The general structure of the `dataText` is as follows:
```
    property variant dataText: {
    	"lanugage_id": {
    		property: "value",
    		.
    		.
    		.
    		property:"value"
    	},
    	"language_id": {
    		.
    		.
    		.
    	}
    }
```

To start translating, simply copy the `en` block, change the id to the one of your language and change the values to the translations of your language.
To make it selectable on the theme settings screen you need to add your id under Settings/`Settings.qml` `dataText[lang].settings_general_language`

## color schemes
All color information used by the theme is loaded from the array `colorScheme` from `theme.qml`.
Every color schame has it's unique name. 
The general structure of the `colorScheme` is as follows:
```
    property variant colorScheme: {
    	"colorscheme_name": {
    		property: "value",
    		.
    		.
    		.
    		property:"value"
    	},
    	"colorscheme_name": {
    		.
    		.
    		.
    	}
    }
```

To start tinkering, simply copy color schemes blocks, change the name to how your color schould be names and change the values to your liking.
To make it selectable on the theme settings screen you need to add your color scheme name  under Settings/`Settings.qml` `[ dataText[lang].settings_general_colorScheme`
You can even live edit your scheme while pegasus is running. After changing a value and saving you can simply press `F5` in pegasus to reload your changes.

## General coding guidance

If you are capable and want to make some more general code changes please follow these rules:
1. Everyone has a different taste. If you want to implement a general layout change, please implement it so it can be switched via the theme settings screen.
2. Don't hardcode some text strings for the interface. Text information should be loaded from the `dataText` array so it can be translated to different languages. Please add your values there for all languages you're capable of providing. For other languages please fill it with the english value. Maybe someone else can help :smile: 
3. Don't hardcode color information of interface elements. Every element of the interface should be costumizeable with the information of the `colorScheme` array. Please use one of the existing values or create a new one and configure it for all existing schemes.
Exception for this rule are drop shadows for elements if needed. These are normaly always black.
4. For new needed interface graphics please use monochrome svg vectors and colorize them with `ColorOverlay` from `QtGraphicalEffects`. `ColorOverlay` is not the best function since it relies on OpengGL capabilities of the devices and doesn't play well witch some device /drivers combinations but i havn't found a other solution for qml to colorize svg graphics. But I was able to find some information for the use of the function, which makes it less likely that image coruptions will occur:
```
header: Item {
	Image {
		id: Image
		source: "Image.svg"
		antialiasing: true
		visible: false
	}
	ColorOverlay {
		anchors.fill: Image
		source: Image
		color: colorScheme[theme].accentalt
		antialiasing: true 
	}
}
```
   - The source property of the ColorOverlay must not point to the item that is the parant item at the same time, even if you use the items id instead of the paraent property. simply place both the Image and the ColorOverlay under a new Item property
   - set the image to invinsible
   - (not sure) use antialiasing for both, the image and the ColorOverlay 
