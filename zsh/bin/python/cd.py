import os
import sys


def eprint(s):
    sys.stderr.write("%s\n" % s)


def red_print(s):
    eprint('\x1b[31m\x1b[22m%s\x1b[39m\x1b[22m' % s)


def cd_venv():
    """
    Adds to the cd command with chpwd hooks in zsh
    - Set name of the venv file
    - Set venv home (virtualenvwrapper)
    """
    _env_file_name = ".venv"
    _venv_home = ".virtualenvs"

    # Get current working directory
    cwd = os.getcwd()
    # eprint("CWD=%s" % cwd)
    # Work on will also run cd for virtualenvwrapper. skip it.
    if cwd.find(_venv_home) >= 0:
        return

    path = cwd
    parents = [path]

    # walk up to root
    while path != "/":
        path, _ = os.path.split(path)
        parents.append(path)

    # Check if any directory to root has a venv file
    # eprint("Parents %s\n" % parents)
    nearest_venv = next((p for p in parents if os.path.exists(os.path.join(p, _env_file_name))), None)
    if not nearest_venv:
        return

    venv_file = os.path.join(nearest_venv, _env_file_name)

    # read the first line of the venv file, must have "workon <environment name>" at the top
    with open(venv_file) as f:
        workon_virtualenv = f.readline()

    # Get the name of the virtual environment mentioned in the venv file and if there is any currently active env
    _venv_exists = False
    _, new_vname = workon_virtualenv.split()
    vname = None
    if os.environ.get('VIRTUAL_ENV'):
        _venv_exists= True
        _, vname = os.path.split(os.environ['VIRTUAL_ENV'])

    # If virtual environment name in file is sames as the active virtual environment, skip it
    if new_vname == vname:
        # eprint("%s is same as %s\n" % (vname, new_vname))
        return
    else:
        commands = []
        if _venv_exists:
            commands.append("deactivate")
        commands.append("source %s" % venv_file)

        command_str = ";".join(commands)
        red_print(command_str)
        print(command_str)
