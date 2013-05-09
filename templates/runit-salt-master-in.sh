#!/bin/sh

# Salt: salt-master 'runit' script:
#
#  ln -s ${buildout:directory}/var/run/runit-salt-master.sh /etc/service/salt-master/run
#

env PATH=${buildout:directory}/bin:/usr/bin:/bin
unset PYTHONPATH

exec  ${buildout:directory}/bin/salt-master -c ${buildout:directory}
