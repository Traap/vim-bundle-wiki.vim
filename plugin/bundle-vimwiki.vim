" {{{ vimwiki
if exists('g:loaded_vimwiki') || &compatible

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

endif

" -------------------------------------------------------------------------- }}}
