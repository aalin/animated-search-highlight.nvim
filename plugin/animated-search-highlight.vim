" animated-search-highlight.vim: Animated search highlights

if exists("g:loaded_animated_search_highlight")
  finish
endif
let g:loaded_animated_search_highlight = 1

function! s:hslToRgb(h, s, l)
  if a:s == 0
    return [a:l, a:l, a:l]
  endif

  let l:q = a:l < 0.5 ? a:l * (1 + a:s) : a:l + a:s - a:l * a:s
  let l:p = 2 * a:l - l:q
  let l:r = s:hueToRgb(l:p, l:q, a:h + 1/3.0)
  let l:g = s:hueToRgb(l:p, l:q, a:h)
  let l:b = s:hueToRgb(l:p, l:q, a:h - 1/3.0)

  return [l:r, l:g, l:b]
endfunction

function! s:hueToRgb(p, q, t)
  let l:t = s:mod(a:t, 1)

  if l:t < 1 / 6.0
    return a:p + (a:q - a:p) * 6 * a:t
  elseif l:t < 1 / 2.0
    return a:q
  elseif l:t < 2 / 3.0
    return a:p + (a:q - a:p) * (2/3.0 - a:t) * 6.0
  endif

  return a:p
endfunction

function! s:mod(n, m)
  let n = a:n
  let m = a:m

  if n < 0
    return fmod((fmod(a:n, a:m) + a:m), a:m)
  endif

  return fmod(a:n, a:m)
endfunction

function! s:clamp(x, min, max)
  if a:x < a:min
    return min
  elseif a:x > a:max
    return a:max
  else
    return a:x
  end
endfunction

function! s:smoothstep(edge0, edge1, x)
  let l:t = s:clamp((a:x - a:edge0) / (a:edge1 - a:edge0), 0.0, 1.0)
  return l:t * l:t * (3.0 - 2.0 * l:t)
endfunction

function! s:interpolate(min, max, x)
  let l:h = a:max - a:min
  return s:smoothstep(0.0, 1.0, a:x) * l:h + a:min
endfunction

function! s:hexColor(rgb)
  let r = float2nr(floor(a:rgb[0] * 255))
  let g = float2nr(floor(a:rgb[1] * 255))
  let b = float2nr(floor(a:rgb[2] * 255))

  return printf("#%02x%02x%02x", r, g, b)
endfunction

function AnimateSearchHighlight(timer)
  if &hlsearch == 0
    return
  end

  let l:time = str2float(split(reltimestr(reltime()))[0])

  let l:x = pow(sin(l:time * 4.0), 2.0)

  let l:guibg = s:hexColor(
    \ s:hslToRgb(
      \ s:interpolate(
        \ 40.0, 50.0, x
      \ ) / 360.0,
      \ 0.7,
      \ s:interpolate(
        \ 0.6, 0.8, x
      \ )
    \ )
  \ )

  let l:guifg = s:hexColor(
    \ s:hslToRgb(
      \ s:interpolate(
        \ 20.0, 40.0, x
      \ ) / 360.0,
      \ 0.7,
      \ s:interpolate(
        \ 0.2, 0.4, x
      \ )
    \ )
  \ )

  let l:gui= l:x < 0.5 ? "NONE" : "bold"

  execute 'highlight IncSearch gui='l:gui' guifg='l:guifg' guibg='l:guibg
  execute 'highlight Search    gui='l:gui' guifg='l:guifg' guibg='l:guibg
endfunction

let timer = timer_start(100, 'AnimateSearchHighlight', { 'repeat': -1 })
