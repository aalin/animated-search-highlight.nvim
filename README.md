animated-search-highlight.nvim
==============================

<img src="https://user-images.githubusercontent.com/41148/165985525-0a5a8c55-5857-4eda-8bfa-bb8360ce0beb.gif" width="442">

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
