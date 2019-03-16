# ZSHRC

- Install the awesome oh-my-zsh

- Copy relevant parts of zshrc into your .zshrc


## Noteworthy parts

- Auto activate virtualenvs
- use igrep and iless to auto color search and not loose it when piping it to less


## Virtual environments

- Install virtualenv and virtualenvwrapper
- Add the following to .zshrc
```
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
VENV_HOME=$HOME/.virtualenvs
```

- Now, create virtualenv with
```
mkvirtualenv -p /usr/bin/python2.7 myproject
```
- To activate
```
workon myproject
```

### Activate and deactivate virtual environments on cd

- Put the bin directory at your home. The file bin/python/cd.py has logic to make magic happen.
- To make python and shell scripts work together use:

```
# Create a shell function which calls python code
function _virtualenv_auto_activate {
output="$(python - <<END
from cd import cd_venv
cd_venv()
END
)"

if [ ! -z "$output" ]
then
    eval "$output"
fi
}

# Add it to zsh chpwd hooks
chpwd_functions+=(_virtualenv_auto_activate)
```

- Remember
    - What ever you print inside python code (stdout) will be input to the variable $output
    - To print but not make it a part of the variable.. use sys.stderr.print

- Now when you cd into a directory which has a .venv file, the contents of which are "workon myproject", the myproject virtualenv will automagically activate itself



