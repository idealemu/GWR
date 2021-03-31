from sys import argv
import os
import random
import subprocess

home = os.path.expanduser('~')
path = os.path.join(home, "Pictures/Wallpapers") 

def get_image():
	return random.choice(os.listdir(path))


def change_wallpaper():
	image = get_image()
	path2 = os.path.join(path, image)
	command = 'gsettings set org.gnome.desktop.background picture-uri "file:///' + path2 + '"'
	subprocess.call(command, shell=True)

def change_wallpaper_named(name: str):
    path2 = os.path.join(path, name)
    command = 'gsettings set org.gnome.desktop.background picture-uri "file:///' + path2 + '"'
    subprocess.call(command, shell=True)

if __name__ == "__main__":
    if len(argv) == 2:
        change_wallpaper_named(argv[1])
    else:
        change_wallpaper()
