# GWR: Gnome Wallpaper Randomizer
## Usage:

Run the wallpaper script: `./wallpaper.sh`
Alternatively: make a link or alias to the script or add the directorty path to your PATH

Directory structure:

```
~/Pictures/Wallpapers
├── DualMonitor
└── SingleMonitor
```

Images will be randomly selected from the total image pool (Wallpapers/\*), including both Single and Dual wallpapers.
Each image is equally likely to be chosen.
Images from 'DualMonitor/' will be applied in a 'spanned' manner over both monitors.
Images from 'SingleMonitor/' will be applied to each monitor individually (the image will hence appear once on each monitor in the case of a dual monitor setup)

## Options:

* list: -l
	* Lists all available images in both directories
* type: -t
	* Set random wallpaper by type (a random image of the given type will be set)
	* Types: 'single', 'dual' (WARNING: case sensitive)
* file: -f
	* Sets wallpaper based on given file name
	* Given value must be the desired filename without extension or path
	* Ex: 
		* For SingleMonitor/myimage.jpg
		* Do: `wallpaper.sh -f myimage`
