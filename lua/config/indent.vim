" Date: Tue Jan 16 12:33:30 2024
" Mail: lunar_ubuntu@qq.com
" Author: https://github.com/xiaoqixian

function! CppNoNamespaceAndTemplateIndent()
  let l:cline_num = line('.')
  let l:cline = getline(l:cline_num)

  let l:pline_num = prevnonblank(l:cline_num - 1)
  let l:pline = getline(l:pline_num)

  while l:pline =~# '\(^\s*{\s*\|^\s*//\|^\s*/\*\|\*/\s*$\)'
    let l:pline_num = prevnonblank(l:pline_num - 1)
    let l:pline = getline(l:pline_num)
  endwhile

  let l:retv = cindent('.')
  let l:pindent = indent(l:pline_num)

  " don't indent after namespace.
  if l:pline =~# '^\s*namespace'
    let l:retv = 0

  elseif l:pline =~# '^\s*case'
    let l:retv = l:pindent

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

" I tried to use au FileType, but it's not triggered.
" autocmd BufEnter *.{cc,cxx,cpp,h,hh,hpp,hxx} setlocal indentexpr=CppNoNamespaceAndTemplateIndent()
" autocmd BufEnter * if expand('%:e') == '' | setlocal indentexpr=CppNoNamespaceAndTemplateIndent() | endif
autocmd BufEnter *.typ setlocal indentexpr=CustomTypstIndent()
autocmd BufEnter *.py setlocal indentexpr=CustomPythonIndent()
