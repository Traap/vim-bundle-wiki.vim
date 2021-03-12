" {{{ Generic calendar setup.

let g:calendar_mark = 'right'
let g:calendar_navi = 'both'
let g:calendar_diary = $HOME.'/git/wiki/diary'
let g:calendar_filetype = 'wiki'
let g:calendar_diary_extension = '.wiki'

" -------------------------------------------------------------------------- }}}
" {{{ wiki.vim 

let g:wiki_root  = $HOME.'/git/wiki'

let g:wiki_export = {
    \ 'args' : '',
    \ 'from_format' : 'markdown',
    \ 'ext' : 'pdf',
    \ 'view' : v:true,
    \ 'output': 'printed',
    \}

" -------------------------------------------------------------------------- }}}
" {{{ Toggle calendar on the terminal right side.  

function! ToggleCalendar()
  execute ":CalendarVR"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction

" -------------------------------------------------------------------------- }}}
