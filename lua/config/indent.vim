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

  "elseif l:pline =~# '\s*typename\s*.*,\s*$'
    "let l:retv = l:pindent
  if l:pline =~# '[<{(]\s*$'
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

autocmd BufEnter *.{cc,cxx,cpp,h,hh,hpp,hxx} setlocal indentexpr=CppNoNamespaceAndTemplateIndent()
