Buildout for salt
=================

Requirements
------------
This new `buildout.cfg` here, relies on your Linux distributions packages-set, for Python modules of ZeroMQ, OpenSSL, M2Crypto, and Jinja2.

This install assumes an "up to date" Python2.7 environment, on a Fedora, OpenSUSE, Debian or Ubuntu distro.

Install
-------
We need to "bootstrap" our buildout of Salt: ::

 script -a -c "python2.7 bootstrap.py" build.log

And then run `zc.buildout`: ::

 script -a -c "bin/buildout -vc buildout.cfg"  build.log

The Salt "main script" is in the `bin/` directory.


Install.prev
-------------
Salt for CentOS 5.x, 6.x (and Debian 6.x?) needs a full Python 2.7 build, and you need to use `install_develop.cfg` in that case, and these packages

- python-dev
- swig
- uuid-dev

NOTE: these are older build instructions, for `bo_salt`, for reference purposes.

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

