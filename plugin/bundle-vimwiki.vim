if exists('g:loaded_vimwiki') || &compatible
" {{{ Personalize vimwiki

let g:vimwiki_auto_header = 1
let g:vimwiki_hl_cb_checked = 2
let g:vimwiki_hl_headers = 1
let g:vimwiki_listsym_rejected = 'ϴ'
let g:vimwiki_listsyms = ' ○◐●✓'

let g:vimwiki_key_mappings =
  \ {
  \   'all_maps': 1,
  \   'global': 1,
  \   'headers': 0,
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

command! Diary VimwikiDiaryIndex
augroup diary_group
  autocmd!
  autocmd BufRead,BufNewFile journal.wiki VimwikiDiaryGenerateLinks
augroup end

" -------------------------------------------------------------------------- }}}
" {{{ Generic calendar setup.

let g:calendar_mark = 'right'
let g:calendar_navi = 'both'
let g:calendar_diary = $HOME.'/git/wiki/journal'
let g:calendar_filetype = 'wiki'
let g:calendar_diary_extension = '.wiki'
let g:calendar_action = 'MyCalAction'
let g:calendar_sign = 'MyCalSign'

map <LocalLeader>cv :call ToggleCalendar()<cr>

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
endif
