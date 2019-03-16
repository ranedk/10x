import vim


def make_dict():
    current_line_number = int(vim.eval("line('.')")) - 1
    current_line = vim.current.line
    leading_space = len(current_line) - len(current_line.lstrip())
    current_word = vim.eval("expand('<cword>')")
    vim.current.buffer[current_line_number] = ("%s'%s': %s," % (leading_space * " ", current_word, current_word))


def make_member():
    current_line_number = int(vim.eval("line('.')")) - 1
    current_line = vim.current.line
    leading_space = len(current_line) - len(current_line.lstrip())
    current_word = vim.eval("expand('<cword>')")
    vim.current.buffer[current_line_number] = ("%sself.%s = %s" % (leading_space * " ", current_word, current_word))
