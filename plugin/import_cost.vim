" Initial checks {{{

if exists('g:loaded_import_cost') || &compatible
  finish
endif

let g:loaded_import_cost = 1

" Check if `node` exists in $PATH
if !executable('node')
  finish
endif

" }}}
" Settings {{{

function! s:InitSettings(settings)
  let l:template = "let g:import_cost_%s = get(g:, 'import_cost_%s', %s)"

  for [key, value] in items(a:settings)
    execute printf(l:template, key, key, string(value))
  endfor
endfunction

let s:default_settings = {
  \ 'show_gzipped': 1,
  \ 'always_open_split': 0,
  \ 'split_size': 50,
  \ 'split_pos': 'left',
  \ }

call s:InitSettings(s:default_settings)

" }}}
" Commands {{{

function! s:InitCommands()
  command! -buffer ImportCost try | call import_cost#ShowImportCostForCurrentBuffer() | endtry
endfunction

" }}}
" Autocommands {{{

augroup import_cost_au
  autocmd!

  autocmd FileType javascript     call <SID>InitCommands()
  autocmd FileType javascript.jsx call <SID>InitCommands()
  autocmd FileType typescript     call <SID>InitCommands()
  autocmd FileType typescript.jsx call <SID>InitCommands()
augroup END

" }}}