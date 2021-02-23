
# from subconfigs

## keys
```xml
    <Key mask="CA" key="Up">udesktop</Key>
    <Key mask="CA" key="Down">ddesktop</Key>


    <!-- CTRL =+ SHIFT + -->
    <Key mask="CS" key="Escape">exec:xfce4-taskmanager</Key>

    <!-- Key resize -->
    <Key mask="4" key="Up">maxtop</Key>
    <Key mask="4" key="Down">maxbottom</Key>
    <Key mask="4" key="Left">maxleft</Key>
    <Key mask="4" key="Right">maxright</Key>


    <!-- CTRL + ALT +  -->

    <!-- SUPER (4) + -->
    <Key mask="4" key="q">close</Key>
    <Key mask="4S" key="q">close</Key>
    <Key mask="4S" key="r">exec:jwm -restart</Key>
    <Key mask="4" key="x">exec:arcolinux-logout</Key>
    <Key mask="4S" key="d">exec:dmenu_run -i -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn 'NotoMonoRegular:bold:pixelsize=14'</Key>
    <Key mask="4S" key="Return">exec:thunar</Key>
```

## tray
from 
        <TrayButton label="JWM" icon="/usr/share/icons/hicolor/20x20/places/start-here-arcolinux.svg">root:3</TrayButton>

removed:
      icon="/usr/share/icons/hicolor/20x20/places/start-here-arcolinux.svg"
