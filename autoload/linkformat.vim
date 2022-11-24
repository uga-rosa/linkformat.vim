function! linkformat#format(link) abort
  let link = substitute(a:link, '\v^git\@github.com:', '', '')
  let link = substitute(link, '\v\.git$', '', '')
  let owner_repo = matchstr(link, '\v[^\/]+\/[^\/]+$')
  if !owner_repo
    echomsg 'Invalid link: ' a:link
    return ''
  endif
  let template = get(g:, 'linkformat_template', '<>')
  return substitute(template, '<>', owner_repo, '')
endfunction

function! linkformat#paste(...) abort
  let cliptext = a:0 > 0 ? a:1 : getreg(v:register)
  let formatted = linkformat#format(cliptext)
  if formatted
    let g:linkformat_result = formatted
    exe 'silent normal!' "\"=g:linkformat_result\<CR>p"
  endif
endfunction
