" {{{ bundle-wiki.vim

if exists('g:loaded_bundle_wiki_vim')
  finish
endif
let g:loaded_bundle_wiki_vim=1

" -------------------------------------------------------------------------- }}}
" {{{ Settings based on Windoz Subsystem for Linux (WSL2) check.

if !empty(getenv('WSL_DISTRO_NAME'))
  let g:traap_pdf_viewer = 'SumatraPDF.exe'
  let g:traap_png_viewer = 'feh'
else
  let g:traap_pdf_viewer = 'okular'
  let g:traap_png_viewer = 'feh'
endif

" -------------------------------------------------------------------------- }}}
" {{{ Wiki.vim root

function! WikiRoot()
  let l:local = finddir('wiki', ';./')
  return !empty(l:local) ? l:local : expand($WIKIHOME)
endfunction

let g:wiki_root  = 'WikiRoot'

" -------------------------------------------------------------------------- }}}
" {{{ Wiki.vim General settings.

" General settings are listed alphabetically only because I find them faster.

let g:wiki_filetypes = [
    \  'md'
    \ ,'cpp'
    \ ,'csv'
    \ ,'go'
    \ ,'js'
    \ ,'json'
    \ ,'puml'
    \ ,'rs'
    \ ,'sql'
    \ ,'tex'
    \ ,'texx'
    \ ,'ts'
    \ ,'wiki'
    \ ,'xml'
    \ ,'yaml'
    \ ]

let g:wiki_link_extension = '.md'
let g:wiki_link_target_type = 'md'
let g:wiki_toc_depth = 2
let g:wiki_viewer = {
    \ 'pdf': g:traap_pdf_viewer,
    \   '_': 'xdg_open',
    \}

let g:wiki_write_on_nav = 1

" -------------------------------------------------------------------------- }}}
" {{{ Wiki.vim Export current page.

let g:wiki_export = {
    \ 'args' : '--metadata-file=$WIKIHOME/wiki.yaml',
    \ 'from_format' : 'markdown',
    \ 'ext' : 'pdf',
    \ 'link_ext_replace': v:false,
    \ 'view' : v:true,
    \ 'output': 'printed',
    \ 'viewer': g:traap_pdf_viewer,
    \}

" -------------------------------------------------------------------------- }}}
" {{{ Wiki.vim File Handler

let g:wiki_file_handler = 'WikiFileOpen'

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
" {{{ Wiki.vim Journal

let s:journal = 'journal'

let g:wiki_journal = {
    \  'name': s:journal,
    \  'frequency': 'daily',
    \  'date_format': {
    \    'daily' : '%Y-%m-%d',
    \    'weekly' : '%Y_w%V',
    \    'monthly' : '%Y_m%m',
    \  },
    \ 'root': '',
    \ 'index_use_journal_scheme': v:true,
    \}

" -------------------------------------------------------------------------- }}}
" {{{ Wiki.vim Link Creator

let g:wiki_link_creation = {
      \ 'md': {
      \   'link_type': 'md',
      \   'url_extension': '.md',
      \   'url_transform': { x ->
      \     substitute(tolower(x), '\s\+', '-', 'g') },
      \ },
      \ 'org': {
      \   'link_type': 'org',
      \   'url_extension': '.org',
      \   'url_transform': { x ->
      \     substitute(tolower(x), '\s\+', '-', 'g') },
      \ },
      \ 'adoc': {
      \   'link_type': 'adoc_xref_bracket',
      \   'url_extension': '',
      \   'url_transform': { x ->
      \     substitute(tolower(x), '\s\+', '-', 'g') },
      \ },
      \ '_': {
      \   'link_type': 'wiki',
      \   'url_extension': '',
      \   'url_transform': { x ->
      \     substitute(tolower(x), '\s\+', '-', 'g') },
      \ },
      \}


" -------------------------------------------------------------------------- }}}
" {{{ Wiki.vim Page Templates

let s:template = expand($WIKIHOME) . '/.template.md'

let g:wiki_templates = [
     \ { 'match_func': {x -> v:true}, 'source_filename': s:template},
     \]

" A-title-page-name becomes A Title Page Name.
"
" https://stackoverflow.com/questions/17440659/capitalize-first-letter-of-each-word-in-a-selection-using-vim#
"
function! PageNameTitleCase(ctx, text) abort
  let s:temp = substitute(a:text, '-', ' ', 'g')
  return substitute(s:temp, '\v<(.)(\w*)', '\u\1\L\2', 'g')
endfunction

" -------------------------------------------------------------------------- }}}
