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
" {{{ Generic calendar setup.

let g:calendar_mark = 'right'
let g:calendar_navi = 'both'
let g:calendar_diary = $HOME.'/git/wiki/journal'
let g:calendar_filetype = 'wiki'
let g:calendar_diary_extension = '.wiki'

" -------------------------------------------------------------------------- }}}
" {{{ General settings.

let g:wiki_file_handler = 'WikiFileOpen'
let g:wiki_filetypes = ['md', 'wiki', 'puml', 'tex', 'texx']
let g:wiki_root  = $HOME.'/git/wiki'
let g:wiki_toc_depth = 2
let g:wiki_viewer = {'pdf': g:traap_pdf_viewer}
let g:wiki_write_on_nav = 1

" -------------------------------------------------------------------------- }}}
" {{{ Export current wiki page.

let g:wiki_export = {
    \ 'args' : '',
    \ 'from_format' : 'markdown',
    \ 'ext' : 'pdf',
    \ 'link_ext_replace': v:false,
    \ 'view' : v:true,
    \ 'output': 'printed',
    \}

let s:template = g:wiki_root . '/.template.md'
" let s:journal = g:wiki_root . '/journal/.template.md'
" let s:kjv = g:wiki_root . '/kjv/.template.md'
" let s:posts = g:wiki_root . '/posts/.template.md'

let g:wiki_templates = [
    \ { 'match_re': '*',
    \   'source_filename': s:template}
    \]

" -------------------------------------------------------------------------- }}}
" {{{ Wiki Template

let s:journal = g:wiki_root . '/journal/.journal.md'
let s:kjv = g:wiki_root . '/kjv/.kjv.md'
let s:latex = g:wiki_root . '/latex/.latex.md'
let s:posts = g:wiki_root . '/posts/.posts.md'
let s:template = g:wiki_root . '/.template.md'

let g:wiki_templates = [
    \ { 'match_func': {x -> v:true}, 'source_filename': s:journal},
    \ { 'match_func': {x -> v:true}, 'source_filename': s:kjv},
    \ { 'match_func': {x -> v:true}, 'source_filename': s:latex},
    \ { 'match_func': {x -> v:true}, 'source_filename': s:posts},
    \ { 'match_func': {x -> v:true}, 'source_filename': s:template}
    \]

" -------------------------------------------------------------------------- }}}
" {{{ Wiki.vim File Handler

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
