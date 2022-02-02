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

