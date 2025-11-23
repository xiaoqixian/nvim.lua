function! CustomCppIndent()
  let l:cline_num = line('.')
  let l:cline = getline(l:cline_num)

  let l:pline_num = prevnonblank(l:cline_num - 1)
  let l:pline = getline(l:pline_num)

  echom "pline: " . l:pline

  while l:pline =~# '\(^\s*{\s*\|^\s*//\|^\s*/\*\|\*/\s*$\)'
    let l:pline_num = prevnonblank(l:pline_num - 1)
    let l:pline = getline(l:pline_num)
  endwhile

  let l:retv = cindent('.')
  let l:pindent = indent(l:pline_num)

  " don't indent after namespace.
  if l:pline =~# '^\s*namespace'
    let l:retv = 0

  " elseif l:pline =~# '^\s*case'
  "   let l:retv = l:pindent

  " don't indent after macros.
  elseif l:pline =~# '^#'
    let l:retv = 0

  elseif l:pline =~# '[<{(]\s*$'
    if l:cline =~# '[>})][,;]*\s*$'
      let l:retv = l:pindent
    else
      let l:retv = l:pindent + &shiftwidth
    endif 
  elseif l:pline =~# '>[,;]*\s*$'
    let l:retv = l:pindent

  endif

  return l:retv
endfunction

setlocal indentexpr=CustomCppIndent()
