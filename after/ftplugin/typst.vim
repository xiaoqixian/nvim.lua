function! CustomTypstIndent()
  let l:cline_num = line('.')
  let l:cline = getline(l:cline_num)
  let l:pline_num = prevnonblank(l:cline_num - 1)
  let l:pline = getline(l:pline_num)
  let l:pindent = indent(l:pline_num)

  if l:pline =~# '[[({]$'
    if l:cline =~# '[])}]$'
      return l:pindent
    else 
      return l:pindent + &shiftwidth
    endif
  else
    return l:pindent
  endif
endfunction

setlocal indentexpr=CustomTypstIndent()
