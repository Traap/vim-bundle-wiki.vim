" {{{ Personalize vimwiki
"
" vimwiki personalization works best when I initialize all global variables
" before vimwiki plugin.

let g:vimwiki_auto_header = 1
let g:vimwiki_hl_cb_checked = 2
let g:vimwiki_hl_headers = 1
let g:vimwiki_listsym_rejected = 'ϴ'
let g:vimwiki_listsyms = ' ○◐●✓'
let g:vimwiki_map_prefix = '<leader>z'
let g:vimwiki_shift_tab_key = '<F8>'
let g:vimwiki_tab_key = '<F7>'

let g:vimwiki_key_mappings =
  \ {
  \   'all_maps': 1,
  \   'global': 1,
  \   'headers': 1,
  \   'text_objs': 1,
  \   'table_format': 1,
  \   'table_mappings': 0,
  \   'lists': 1,
  \   'links': 1,
  \   'html': 0,
  \   'mouse': 0,
  \ }

let g:vimwiki_list =
  \[{
  \ 'path':'~/git/wiki/',
  \ 'path_html':'~/git/wiki/html/',
  \ 'auto_tags': 1,
  \ 'auto_generate_links': 1,
  \ 'auto_generate_tags': 1,
  \}]

" -------------------------------------------------------------------------- }}}
" {{{ vimwiki keyboard experiment
"
" I am experimenting with vimwiki keyboard customizations.  These variables are
" defined but not used yet.

let g:vimwiki_keyboard_backspace = '<F1>'
let g:vimwiki_keyboard_ctrl_down = '<F2>'
let g:vimwiki_keyboard_ctrl_return = '<F3>'
let g:vimwiki_keyboard_ctrl_shift_return = '<F4>'
let g:vimwiki_keyboard_ctrl_up = '<F5>'
let g:vimwiki_keyboard_plus = '<F6>'
let g:vimwiki_keyboard_return = '<F7>'
let g:vimwiki_keyboard_shift_tab = '<F8>'
let g:vimwiki_keyboard_shift_return = '<F9>'
let g:vimwiki_keyboard_tab = '<F10>'

" -------------------------------------------------------------------------- }}}
" {{{ Generic calendar setup.

let g:calendar_mark = 'right'
let g:calendar_navi = 'both'
let g:calendar_diary = $HOME.'/git/wiki/journal'
let g:calendar_filetype = 'wiki'
let g:calendar_diary_extension = '.wiki'

" -------------------------------------------------------------------------- }}}
" {{{ wiki.vim 

let g:wiki_root  = $HOME.'/git/wiki'

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
