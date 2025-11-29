function! CustomJSXIndent()
  let l:cline_num = line('.')
  let l:cline = getline(l:cline_num)

  let l:pline_num = prevnonblank(l:cline_num - 1)
  let l:pline = getline(l:pline_num)

  let l:retv = cindent('.')
  let l:pindent = indent(l:pline_num)
  if l:pline =~# '}\s*$'
    let l:retv = l:pindent + &shiftwidth
  endif
  return l:retv
endfunction

setlocal indentexpr=CustomJSXIndent()
