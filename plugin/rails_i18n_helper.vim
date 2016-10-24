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
  let l:cmd = ":normal :" . l:line_num . ""
  execute l:cmd
endfunction
command! CopyI18nKey call CopyI18nLine()

function! CopyI18nTag()
  let l:line = getline(".") . l:line
  let l:line = substitute(l:line, ":[^:]*$", "", "g")
  let @" = "." . l:line
endfunction
command! CopyI18nTag call CopyI18nTag()

function! FindI18nFile()
  let l:filepath = @%
  "app/views/biz/find_contacts/modals/_matches.html.haml"
  let l:clean_fp = split( strpart(l:filepath, 10), '/')
  let l:file = l:clean_fp[len(l:clean_fp) - 1]

  let l:file = substitute(l:file, "^_", "", "g")
  let l:file = substitute(l:file, "\.html.haml$","", "g")

  execute "lgrep! -R " . l:file . " config/**/*.yml"
  execute "lop"
endfunction
command! FindI18nFile call FindI18nFile()

:autocmd FileType haml imap <c-i><c-t> =t('')<ESC>hi
:autocmd FileType eruby imap <c-i><c-t> <% t('') %><ESC>hhhhi
:autocmd FileType ruby imap <c-i><c-t> I18n.t('')<ESC>hi

