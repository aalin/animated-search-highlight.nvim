animated-search-highlight.nvim
==============================

![animated-search-highlight vim](https://user-images.githubusercontent.com/41148/146956117-14137c65-1648-4bb4-aebf-6aafb1dec1a1.gif)

Description
-----------

Animates the search highlight so you can find what you're looking for easier.

Installation
------------

Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use 'aalin/animated-search-highlight.nvim'
```

Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'aalin/animated-search-highlight.nvim'
```

For other plugin managers, read their documentation.

Configuration
-------------

These are the default options:

```lua
require('animated-search-highlight').setup({
  fg1 = "#7c5803",
  fg2 = "#8d6303",
  bg1 = "#fcdd93",
  bg2 = "#fabd2f",
})
```

Contributing
------------

Pull requests welcome. Please be nice.

License
-------

MIT
