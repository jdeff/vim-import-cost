let s:virtual_text_namespace = 0

function! import_cost#virtual_text#Render(buffer, imports, range_start_line, buffer_lines)
  " Create namespace
  if !s:virtual_text_namespace
    let s:virtual_text_namespace = nvim_create_namespace('import_cost')
  endif

  " Render it!
  call s:SetVirtualText(a:buffer, a:imports, a:range_start_line, a:buffer_lines)
endfunction

" Clear the virtual text
function! import_cost#virtual_text#Clear(buffer)
  call import_cost#virtual_text#ClearRange(a:buffer, 0, -1)
endfunction

" Clear the virtual text in a arange
function! import_cost#virtual_text#ClearRange(buffer, line_1, line_2)
  call nvim_buf_clear_namespace(a:buffer,
        \ s:virtual_text_namespace,
        \ a:line_1,
        \ a:line_2)
endfunction

" Feature support {{{

" Check if virtualtext is supported
function! import_cost#virtual_text#IsSupported()
    return has('nvim-0.3.2')
endfunction

" }}}
" Virtual text {{{

function! s:SetVirtualText(buffer, imports, range_range_start_line, buffer_lines) abort
  let l:hl_group = 'ImportCostVirtualText'
  let l:prefix = g:import_cost_virtualtext_prefix

  for import in a:imports
    let l:message = l:prefix . import_cost#utils#CreateImportString(import, 0)
    let l:line = import['line'] + a:range_range_start_line - 1

    call nvim_buf_set_virtual_text(a:buffer,
          \ s:virtual_text_namespace,
          \ l:line,
          \ [[ l:message, l:hl_group ]],
          \ {})
  endfor
endfunction

" }}}
