" {{{ bundle-wiki.vim

if exists('g:loaded_bundle_wiki_vim')
  finish
endif
let g:loaded_bundle_wiki_vim=1

" -------------------------------------------------------------------------- }}}
" {{{ Use environment variable PDF_VIEWER and PNG_VIEWER regardless of OS.

let s:pdf_viewer = getenv('PDF_VIEWER')
if s:pdf_viewer != v:null && !empty(s:pdf_viewer)
  let g:traap_pdf_viewer = s:pdf_viewer
else
  echo "Warning: PDF_VIEWER is not defined."
endif

let s:png_viewer = getenv('PNG_VIEWER')
if s:png_viewer != v:null && !empty(s:png_viewer)
  let g:traap_png_viewer = s:png_viewer
else
  echo "Warning: PNG_VIEWER is not defined."
endif

" -------------------------------------------------------------------------- }}}
" {{{ Wiki.vim root

function! WikiRoot()
  " Start at current directory and walk upward.
  let l:dir = getcwd()

  while 1
    " Look for a directory in this level whose name matches ^wiki$ case-insensitively.
    for l:name in readdir(l:dir)
      if l:name =~? '^wiki$' && isdirectory(l:dir . '/' . l:name)
        return l:dir . '/' . l:name
      endif
    endfor

    " Stop when we hit filesystem root.
    let l:parent = fnamemodify(l:dir, ':h')
    if l:parent ==# l:dir
      break
    endif
    let l:dir = l:parent
  endwhile

  return expand('$WIKIHOME')
endfunction

let g:wiki_root = WikiRoot()

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
