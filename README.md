# krita.yazi

A simple plugin to add krita previews to yazi

### Usage
To use this plugin install it with the yazi package manager
```bash 
ya pack -a EmiOnGit/krita
```

Then add following sections to your `yazi.toml`
```toml
# yazi.toml
[plugin]
prepend_previewers= [
	{ name = "*.kra", run = "krita" },
]
prepend_preloaders = [
	{ name = "*.kra", run = "krita" },
]

# Unrelated to this plugin I also suggest this 
# to open krita files
[open]
prepend_rules = [
	{ name = "*.kra", use = "paint" },
]
[opener]
paint = [
	{ run = 'krita "$@"', orphan = true},
]
```

### Prerequisites
* `7z` or `7zz`
* `tree`
