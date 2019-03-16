# Minimal vim config for python/javascript development

## Installation

Upgrade vim to vim 8

On Ubuntu
```
sudo add-apt-repository ppa:jonathonf/vim
sudo apt-get update
sudo apt-get install vim

sudo apt-get install python3-pip
sudo pip3 install vim
```

## Clean up existing and create new
remove or backup all .vim folder and .vimrc

```
mkdir -p ~/.vim ~/.vim/bundle ~/.vim/_temp ~/.vim/_backup
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

copy vimrc (from the current project) to ~/.vimrc
```
cp vimrc ~/.vimrc
cp utils.py ~/.vim/
```

## Plugins installation

open any file using vim

run :PluginInstall

This will get all the plugins.

Note: To install f2f, yjust press ; and it will install f2f requirements

## What you get

### Themes: monokai and solarized

To change theme to solarized light for e.g.

```
set background=dark
colorscheme solarized
```

### Emmet
Write
```
div>div.column>div.col-md-4*3>a.link
```

Press Ctrl-Y-,  (dont forget the comma)

will automatically expand to
```
<div>
    <div class="column">
        <div class="col-md-4"><a class="link" href=""></a></div>
        <div class="col-md-4"><a class="link" href=""></a></div>
        <div class="col-md-4"><a class="link" href=""></a></div>
    </div>
</div>
```

### Airline
Better statuslines at the bottom

### Git gutter
Better git status on left column

### Ale

Ale is asynchronous linter (which requires vim 8)

This vimrc supports flake8 and eslint, you can add more

Use ctrl-e to navigate between errors

press 'ff' (double ff) to fix linting errors automatically

This vimrc uses autopep8 for python and eslint for javascript

Use ctrl-p to auto-complete using some context

### FZF

press ';' to search and open files using fuzzy search

This will index all files in the directory, so open using vim when you are inside the project directory

Once file is selected, use:

Enter to open file in vim tab

ctrl-h to open file in horizontal split

ctrl-v to open file in vertical split

## Vim Configuration specifics

\\=  to remove search highlighting

:w!! instead of :w if file requires sudo permissions to write

Press Ctrl and hjkl to navigate in split windows

< F3 > to toggle numbers

< F2 > to set paste and set nopaste toggle (when pasting formatted code or json into vim)

n to find next search item

N to find previous search item


t1 to jump to first tab

< tab > to jump to next tab (in normal mode obviously)

In insert mode shortcuts

_pdbt - < Enter > expands to
<pre>
    from IPython.core.debugger import Tracer
    Tracer()()
</pre>

_pdb - < Enter > expands to
<pre>
    from IPython.frontend.terminal.embed import I  nteractiveShellEmbed
    InteractiveShellEmbed()()
</pre>

_pdbc - < Enter > expands to
<pre>
	from celery.contrib import rdb
	rdb.set_trace()
</pre>

:Pd changes current directory to the current files parent, this helps in doing file open or file completion with respect to current files position

## Misc

press "\\]" to convert a string into "string": string

press "\\[" to convert a string into self.string = string < saves some time typing >

This helps in python and jaascript-es5 to create dicts
