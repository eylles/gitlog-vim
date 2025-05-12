# GitLog On vim

a git logs viewer for (n)vim

<img src="./Screenshot0.png" width="700">
<img src="./Screenshot1.png" width="600">

## why ?

A small script to view git logs inside (neo)vim without relying on plugins


## usage

Just run the program inside a git repo directory, if you want to view a different number of commits
then pass the `-n` flag with the number like so:

```sh
glo -n 80
```

During operation type `K` (capital k) over a git hash to view the diff in a new tab, `q` to close
the tab, `Q` to exit.

## install

```
# clone the repo
git clone https://github.com/eylles/gitlog-vim

cd gitlog-vim

make install clean
```

## credits

All credits go to [NRK](https://github.com/N-R-K) for originating this script in:
https://nrk.neocities.org/articles/vim-gitlog
