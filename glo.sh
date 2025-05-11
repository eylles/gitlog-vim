#!/bin/sh

# vim or neovim
vim_type="vim"
# (n)vim binary to use
vim_bin="/usr/bin/vim"

config_dir="${XDG_CONFIG_HOME:-${HOME}/.config}/git-log-vim"
config_file="${config_dir}/configrc"

if [ -f "$config_file" ]; then
    . "$config_file"
else
    if [ ! -d "$config_dir" ]; then
        mkdir -p "$config_dir"
    fi
cat << __HEREDOC__ >> "$config_file"
# vim: ft=sh
# glo config file

# vim binary
vim_bin="${vim_bin}"

# vim type
vim_type="${vim_type}"
__HEREDOC__
fi


last_line=""
run_glo() {
  git rev-parse 2> /dev/null || return 1
  local git_cmd="git --no-pager log --oneline --color=always ${*:--n 128}"
  case "$vim_type" in
      neovim|nvim)
          last_line="+term $git_cmd"
          ;;
      vim)
          last_line="+call term_start('$git_cmd', {'hidden': 1, 'term_cols': 2048, 'term_finish': 'open', 'term_opencmd': 'buffer %d'})"
          ;;
  esac
  $vim_bin \
    "+nnoremap <silent> q :if ((len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1) && expand('%') == '')<Bar>exe 'q!'<Bar>else<Bar>exe 'bd!'<Bar>endif<cr><CR>" \
    '+nnoremap <silent> Q :qa!<CR>' \
    "+nnoremap <silent> K 0:tabnew \| setfiletype git \| exe 'read! git --no-pager show <C-r><C-w>' \| norm ggdd<CR>" \
    "$last_line"
}

run_glo "$@"
