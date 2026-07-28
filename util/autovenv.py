from __future__ import print_function, unicode_literals

import codecs
import os
import re
import sys


def _open(path):
    if sys.version_info >= (3, 14):
        return open(path, 'r', encoding='utf-8')
    else:
        return codecs.open(path, 'r', 'utf-8')


def main():
    try:
        pwd = sys.argv[1]
        if hasattr(pwd, 'decode'):
            # in python2 we get a bytestring
            pwd = pwd.decode(sys.stdin.encoding)
        pwd = pwd.rstrip('/') + '/'
    except IndexError:
        print('usage: {0} DIR'.format(sys.argv[0]), file=sys.stderr)
        sys.exit(1)
    with _open(os.path.expanduser('~/.autovenv')) as f:
        entries = dict(map(os.path.expanduser, re.split(r'\s+', line.strip()))
                       for line in f
                       if line.strip() and not line.startswith('#'))
    default = entries.pop('DEFAULT', 'IGNORE')
    for path, venv in sorted(entries.items(), key=lambda x: len(x[0]), reverse=True):
        if pwd.startswith(path.rstrip('/') + '/'):
            if venv not in ('GLOBAL', 'IGNORE') and not os.path.isabs(venv):
                venv = os.path.join(path, venv)
            print(venv)
            break
    else:
        print(default)


if __name__ == '__main__':
    main()
