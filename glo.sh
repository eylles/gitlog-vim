#!/bin/sh



glo() {
  git rev-parse 2> /dev/null || return 1
  local git_cmd="git --no-pager log --oneline --color=always ${@:--n 128}"
  vim \
    '+nnoremap q :bd!<CR>' '+nnoremap Q :qa!<CR>' \
    "+nnoremap <silent> K 0:tabnew \| setfiletype git \| exe 'read! git --no-pager show <C-r><C-w>' \| norm ggdd<CR>" \
    "+call term_start('$git_cmd', {'hidden': 1, 'term_cols': 2048, 'term_finish': 'open', 'term_opencmd': 'buffer %d'})"
}
