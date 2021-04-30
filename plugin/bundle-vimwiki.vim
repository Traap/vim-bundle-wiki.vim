" {{{ Generic calendar setup.

let g:calendar_mark = 'right'
let g:calendar_navi = 'both'
let g:calendar_diary = $HOME.'/git/wiki/journal'
let g:calendar_filetype = 'wiki'
let g:calendar_diary_extension = '.wiki'

" -------------------------------------------------------------------------- }}}
" {{{ wiki.vim 

let g:wiki_root  = $HOME.'/git/wiki'

" Windoz Subsystem for Linux (WSL2) check.
if g:os_wsl
  let g:wiki_viewer = { 'pdf': 'SumatraPDF.exe' }
  let g:traap_pdf_viewer = 'SumatraPDF.exe'
  let g:traap_png_viewer = 'feh'
else
  let g:wiki_viewer = { 'pdf': 'okular' }
  let g:traap_pdf_viewer = 'okular'
  let g:traap_png_viewer = 'feh'
endif

let g:wiki_export = {
    \ 'args' : '',
    \ 'from_format' : 'markdown',
    \ 'ext' : 'pdf',
    \ 'view' : v:true,
    \ 'output': 'printed',
    \}

function! WikiFileOpen(...) abort dict
  if self.path =~# 'pdf$'
    silent execute '!' g:traap_pdf_viewer fnameescape(self.path) '&'
    return 1
  endif

  if self.path =~# '\v(png|jpg)$'
    silent execute '!' g:traap_png_viewer fnameescape(self.path) '&'
    return 1
  endif

  return 0
endfunction

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
