#!/bin/sh

# vim or neovim
vim_type="vim"
# (n)vim binary to use
vim_bin="/usr/bin/vim"

dir_name="gitlog-vim"
config_dir="${XDG_CONFIG_HOME:-${HOME}/.config}/${dir_name}"
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
# the vim binary to execute, if you usually run vim through
# a wrapper this is the place to specify it, so long as the
# wrapper is in your PATH the full path is not needed.
vim_bin="${vim_bin}"

# vim type
# accepted values are: vim, nvim, neovim
vim_type="${vim_type}"
__HEREDOC__
fi

myname="${0##*/}"

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
    '+nnoremap <silent> q :q!<CR>' \
    '+nnoremap <silent> Q :qa!<CR>' \
    "+nnoremap <silent> K 0:tabnew \| setfiletype git \| exe 'read! git --no-pager show <C-r><C-w>' \| norm ggdd<CR>" \
    "$last_line"
}

if [ "$#" -lt 1 ]; then
    run_glo "$@"
else
    case "$1" in
        '-n')
            run_glo "$@"
            ;;
        *)
            printf '%s\n' "${myname}: invalid argument '$1'"
            exit 1
            ;;
    esac
fi
