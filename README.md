Fancy ZSH config
================

A fancy ZSH config that fits my needs.


Install locally
---------------

On a multi-user system you'll want to install this just for your user.

- Clone this repo to `~/.zsh` (use `--recursive` to install the submodule)
- `ln -s ~/.zsh/.zshrc ~/.zshrc`

To run custom code, the easiest solution is replacing the `.zshrc` symlink
with an actual file which sources `~/.zsh/.zshrc` before running the custom
code.


Install globally
----------------

If you are the only user of a machine, it might be nice to install it
globally for all users (such as your primary user, root, and any other account
you might use).

- Clone this repo using to `/etc/zsh/custom` (use `--recursive` to install the
  submodule)
- `ln -s /etc/zsh/custom/.zshrc /etc/zsh/zshrc`
- `ln -s /etc/zsh/custom/.zshenv /etc/zsh/zshenv` (to disable the new-user
  wizard)

Depending on your distribution you might need to use `/etc/zshrc` and
`/etc/zshenv` instead of the paths shown above.


Autovenv
--------

Loading Python virtualenvs is monkey work. The typical Linux user is not a
monkey. You can create a `~/.autovenv` file containing virtualenv path
mappings which will automatically load the specified virtualenv if you are
inside the specified directory. The syntax is quite simple:

```ini
# By default we want a Python 2 virtualenv
DEFAULT                 ~/.python2-env
# Misc scripts are using Python 3 though
~/dev/misc              ~/.python3-env
# The coolproject folder has an `env` subdirectory
~/dev/coolproject       env
# In /tmp we don't manage the virtualenv at all
/tmp                    IGNORE
```

The default `DEFAULT` is is to `IGNORE` the virtualenv. The only other value
with a special meaning is `GLOBAL` which will `deactivate` any active
virtualenv.

The autovenv check runs in a `chpwd` hook so after editing the file you will
have to `cd .` to trigger it if you are already in the directory you added.

Note: You cannot use `pyenv-virtualenv` and *autovenv* simultaneously as having
two utils activating/deactivating virtualenvs is a source for problems. You can
either disable *autovenv* by not having a `~/.autovenv` file or `pyenv-virtualenv`
by not running its init command (nor putting it in your `~/.zshrc`). Using plain
`pyenv` is fine by the way.

Prompt
------

The hostname color in the prompt can be overridden by setting `ZSH_HOST_COLOR`
to any value that's allowed inside `%F{...}`.
