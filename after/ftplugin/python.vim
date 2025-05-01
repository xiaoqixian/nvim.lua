function! CustomPythonIndent()
  let l:cline_num = line('.')
  let l:cline = getline(l:cline_num)
  let l:pline_num = prevnonblank(l:cline_num - 1)
  let l:pline = getline(l:pline_num)
  let l:pindent = indent(l:pline_num)
  let b:python_concatline = 0

  " if the last line is an open parenthesis 
  " or brackets
  if l:pline =~# '[[({]$'
    if l:cline =~# '[])}]$'
      return l:pindent
    else 
      return l:pindent + &shiftwidth
    endif
  " if the last line ends with :
  elseif l:pline =~# ':\s*$'
    return l:pindent + &shiftwidth
  elseif l:pline =~# '\\\s*$'
    if b:python_concatline
      return l:pindent
    else
      let b:python_concatline = 1
      return l:pindent + &shiftwidth
    endif
  elseif l:pline =~# 'pass\s*$'
    return max([0, l:pindent - &shiftwidth])
  elseif l:pline =~# 'continue\s*$'
    return max([0, l:pindent - &shiftwidth])
  elseif l:pline =~# 'break\s*$'
    return max([0, l:pindent - &shiftwidth])
  elseif l:pline =~# '^\s\+return[^\S]*'
    return max([0, l:pindent - &shiftwidth])
  elseif l:pline =~# '^\s\+raise\s\+'
    return max([0, l:pindent - &shiftwidth])
  else
    if b:python_concatline 
      let b:python_concatline = 0
      return max([0, l:pindent - &shiftwidth])
    else
      return l:pindent
    endif
  endif
endfunction

setlocal indentexpr=CustomPythonIndent()

setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

nunmap <buffer> [M
nunmap <buffer> [m
nunmap <buffer> []
nunmap <buffer> [[
nunmap <buffer> ]M
nunmap <buffer> ]m
nunmap <buffer> ][
nunmap <buffer> ]]
