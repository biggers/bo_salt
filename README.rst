Buildout for salt
=================

Requirements
------------

- python-dev
- swig

Install
-------
Run buildout as usual::

    $ export USE_SETUPTOOLS=1
    $ python2.7 bootstrap.py -d
    $ bin/buildout.cfg

Start Master
------------

1. Copy `templates/master.template` to `etc/master`::

    $ cp templates/master.template etc/master

2. Edit default settings. Change `var` and `etc` folders to lokal path. Set
   `user` to current user.

3. Start master::

    $ ./bin/salt-master -c etc/master -l debug


Start Minion
------------

1. Copy `templates/minion.template` to `etc/minion`::

    $ cp templates/minion.template etc/minion

2. Edit default settings.

3. Start minion::

    $ ./bin/salt-minion -c etc/minion -l debug

