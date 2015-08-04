========================================
Valgrind New Plugin Helper
========================================

This is a script for generating skeleton of your new Valgrind plugin.

It does the Valgrind plugin's `getting started <http://www.valgrind.org/docs/manual/writing-tools.html#writing-tools.gettingstarted>`_ stuff.

You only need to answer two question :

1. your new plugin's full name
2. your new plugin's abbreviation

Test on Arch Linux with bash & GNU sed.

BTW, Valgrind's source code is on SVN, and it use automake to build things.


Use it !
========================================

.. code-block:: sh

    $ git clone https://github.com/wdv4758h/valgrind-new-plugin-helper
    $ valgrind-new-plugin-helper/valgrind-new-plugin.sh
    Please tell me you new Valgrind plugin's full name (e.g. memcheck): toygrind
    and it's abbreviation (e.g. mc): tg
    ... # other stuffs (e.g. Makefile, function name, ...) will be done
