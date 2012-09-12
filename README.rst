Buildout for salt
=================

Requirements
------------

- python-dev
- swig
- uuid-dev

Install
-------
First wee need to set a environment variabel or we wont get start scripts::

    $ export USE_SETUPTOOLS=1

Run bootstrap::    

    $ python2.7 bootstrap.py -d

Add to `buildout.cfg` a section *master*::

    [master]
    #config
    user = root #or current user
    root_dir = ${buildout:directory}/etc
    pki_dir = ${buildout:directory}/etc/salt/pki
    log_file = ${buildout:directory}/var/log/master
    cachedir = ${buildout:directory}/var/cache/salt
    file_roots =
        base:
            - ${buildout:directory}/salt

Add to `buildout.cfg` a section *minion-local*::

    [minion-local]
    #config
    user = root #or current user
    root_dir = ${buildout:directory}/etc
    pki_dir = ${buildout:directory}/etc/salt/pki
    log_file = ${buildout:directory}/var/log/minion
    cachedir = ${buildout:directory}/var/cache/salt
    file_roots =
        base:
            - ${buildout:directory}/salt

Run buildout::

    $ bin/buildout

Start master
------------
First wee need to configure ``DNS`` to point to out salt master or simply add it
to `/etc/hosts`::

    $ vim /etc/hosts
    127.0.0.1 salt

Start master::

    $ ./bin/salt-master -c etc/master -l debug

Start minion
------------

Start minion::

    $ ./bin/salt-minion -c etc/minion -l debug

Accpet "A"ll keys
-----------------
The is a bug in salt-key so we need to specify a key-logfile::

    $ bin/salt-key -A -c etc/master --key-logfile=foo

Call remote commands
--------------------
This is our first try to call remote commands::

    $ bin/salt -c etc/master '*'  cmd.exec_code python 'import sys; print sys.version

Minionswarm
-----------
To try more than one minion we can use the script `minionswarm.py`, but need it
to run as *root*. There is a issues withc supports `script-root`. 
https://github.com/saltstack/salt/issues/2004

Run master::

    $ sudo bin/salt-master

Run minionswarm::

    $ wget https://raw.github.com/saltstack/salt/develop/tests/minionswarm.py
    $ sudo bin/py minionswarm.py --script-root `pwd`/bin/

Accept keys::

    $ sudo bin/salt-keys -A 
    
Run remote command::

    sudo bin/salt '*' test.ping

