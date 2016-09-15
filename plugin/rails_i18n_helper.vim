function! CopyI18nLine() 
  let l:line_num = line('.')
  let l:count = indent(line("."))
  let l:line = getline(".")
  while l:count > 2
    let l:count = l:count - 2
    let l:prefix = repeat(' ',l:count)
    " rsearch for the next line that starts with this
    let l:cmd = ":normal?^" . l:prefix . "\\w"
    execute l:cmd
    let l:line = getline(".") . l:line
    " copy this line into the l:line buffer
  endwhile

  let l:line = substitute(l:line, ":[^:]*$", "", "g")
  let l:line = substitute(l:line, "\\s", "", "g")
  let l:line = substitute(l:line, ":", ".", "g")

  let @" = l:line
  go l:line_num
endfunction
command! CopyI18nKey call CopyI18nLine()
