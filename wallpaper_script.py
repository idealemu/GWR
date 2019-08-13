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

change_wallpaper()
