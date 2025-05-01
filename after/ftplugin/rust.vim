function! CustomRustIndent()
  let l:cline_num = line('.')
  let l:cline = getline(l:cline_num)
  let l:pline_num = prevnonblank(l:cline_num - 1)
  let l:pline = getline(l:pline_num)
  let l:pindent = indent(l:pline_num)
  " echom "pline: " . l:pline
  " echom "cline: " . l:cline

  " a.method(...) like
  if l:pline =~# '\w\+\.\w\+(.*)\s*$'
    let l:prefix = matchlist(l:pline, '\([^\.]\+\)\.\w\+(.*)\s*$')[1]
    echom "l:prefix = " . l:prefix
    return strlen(l:prefix)
  " .chained(...) like
  elseif l:pline =~# '^\s\+\.\w\+(.*)\s*$'
    fuck()
    return l:pindent
  else
    return cindent('.')
  endif
endfunction

setlocal indentexpr=CustomRustIndent()
