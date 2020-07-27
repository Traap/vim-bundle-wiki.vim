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

" Add zero prefix to a number
function! s:prefix_zero(num) abort
  if a:num < 10
    return '0'.a:num
  endif
  return a:num
endfunction

" Build journal file name.
function! s:build_filename(day,month,year) abort
  " day   : day you actioned
  " month : month you actioned
  " year  : year you actioned
  let day = s:prefix_zero(a:day)
  let month = s:prefix_zero(a:month)
  let sfile = a:year.'-'.month.'-'.day
  return sfile
endfunction

function MyCalAction(day,month,year,week,dir)
  " day   : day you actioned
  " month : month you actioned
  " year  : year you actioned
  " week  : day of week (Mo=1 ... Su=7)
  " dir   : direction of calendar
  let sfile = s:build_filename(a:day, a:month, a:year)

  if winnr('#') == 0
    if a:dir ==? 'V'
      vsplit
    else
      split
    endif
  else
    wincmd p
    if !&hidden && &modified
      new
    endif
  endif

  call wiki#journal#make_note(sfile)
endfunction

function MyCalSign(day,month,year)
  " day   : day you actioned
  " month : month you actioned
  " year  : year you actioned
  let sfile = s:build_filename(a:day, a:month, a:year)
  return filereadable(expand(sfile))
endfunction

" -------------------------------------------------------------------------- }}}
endif
