" {{{ bundle-vimwiki.vim

if exists('g:loaded_bundle_vimwiki')
  finish
endif
let g:loaded_bundle_vimwiki=1

" -------------------------------------------------------------------------- }}}
" {{{ Archlinux and Windows Subsystem for Linux check

let g:os_arch = trim(system("cat /etc/issue | rg 'Arch Linux' -c"))

let s:os_wsl = trim(system('uname -r'))
let g:os_wsl  = (s:os_wsl =~ 'Microsoft') || (s:os_wsl =~ 'WSL2')

" -------------------------------------------------------------------------- }}}
" {{{ Settings based on Windoz Subsystem for Linux (WSL2) check.

if g:os_wsl
  let g:traap_pdf_viewer = 'SumatraPDF.exe'
  let g:traap_png_viewer = 'feh'
else
  let g:traap_pdf_viewer = 'okular'
  let g:traap_png_viewer = 'feh'
endif

let g:wiki_viewer = {
    \ 'pdf': g:traap_pdf_viewer,
    \   '_': 'xdg_open',
    \}

" -------------------------------------------------------------------------- }}}
" {{{ Wiki.vim general settings.

" General settings are listed alphabetically only because I find them faster.

let g:wiki_filetypes = ['md', 'wiki', 'puml', 'tex', 'texx']
let g:wiki_link_extension = '.md'
let g:wiki_link_target_type = 'md'
let g:wiki_root  = $HOME.'/git/wiki'
let g:wiki_toc_depth = 2
let g:wiki_viewer = {'pdf': g:traap_pdf_viewer}
let g:wiki_write_on_nav = 1

" -------------------------------------------------------------------------- }}}
" {{{ Wiki.vim export current page.

let g:wiki_export = {
    \ 'args' : '--metadata-file=$HOME/git/wiki/wiki.yaml',
    \ 'from_format' : 'markdown',
    \ 'ext' : 'pdf',
    \ 'link_ext_replace': v:false,
    \ 'view' : v:true,
    \ 'output': 'printed',
    \}

" -------------------------------------------------------------------------- }}}
" {{{ Wiki.vim Page Templates

let s:journal = g:wiki_root . '/journal/.journal.md'
let s:kjv = g:wiki_root . '/kjv/.kjv.md'
let s:latex = g:wiki_root . '/latex/.latex.md'
let s:posts = g:wiki_root . '/posts/.posts.md'
" let s:template = g:wiki_root . '/.template.md'

" let g:wiki_templates = [
"     \ { 'match_func': {x -> v:true}, 'source_filename': s:journal},
"     \ { 'match_func': {x -> v:true}, 'source_filename': s:kjv},
"     \ { 'match_func': {x -> v:true}, 'source_filename': s:latex},
"     \ { 'match_func': {x -> v:true}, 'source_filename': s:posts},
"     \ { 'match_func': {x -> v:true}, 'source_filename': s:template}
"     \]

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
" {{{ Wiki.vim Page Creator

let g:wiki_map_create_page = 'WikiPageCreator'

function WikiPageCreator(name) abort
  let l:name = wiki#get_root() . '/' . a:name

  return filereadable(l:name)
        \ ? l:name
        \ : l:name . '-' . strftime('%Y%m%d-%H%M%S')

endfunction

" -------------------------------------------------------------------------- }}}
" {{{ Wiki.vim Link Creator

let g:wiki_map_link_create = 'WikiLinkCreator'
function WikiLinkCreator(text) abort
  return substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction

" -------------------------------------------------------------------------- }}}
