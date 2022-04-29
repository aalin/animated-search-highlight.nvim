" animated-search-highlight.nvim: Animated search highlights

if exists('g:loaded_animated_search_highlight')
  finish
endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

lua require('animated-search-highlight').start()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_animated_search_highlight = 1
