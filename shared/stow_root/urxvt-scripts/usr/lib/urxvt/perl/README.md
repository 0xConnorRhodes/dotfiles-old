## install instructions
1. list these extensions in a comma seperated list in Xresources
```toml
URxvt.perl-ext-common:	...url-select,clipboard
```
2. map enter vim url mode to C-y
```toml
URxvt.keysym.C-y:	perl:url-select:select_next
```
3. enable clipboard auto-copy to copy to primary clipboard when script copies to selection clipboard.
```toml
URxvt.clipboard.autocopy: true
```
4. If desired, alter url launcher with
```toml
URxvt.url-launcher:	/usr/bin/xdg-open
```

## Keys

|**Key**|**Function**|
|---|---|
|`C-y`|enter vim url selection mode|
|`y`|within vim mode, yank url
|`j/k`|move up and down
|g/G|Select first/last URL (also with home/end key)
|`o`|open url
|`Return`|like `o` but deactivates url-select mode afterwards
|`q/Escape`|exit url mode

