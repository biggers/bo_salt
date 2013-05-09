#!/bin/sh

# Salt: salt-minion 'runit' script:
#
#  ln -s ${buildout:directory}/var/run/runit-salt-minion.sh /etc/service/salt-minion/run
#

env PATH=${buildout:directory}/bin:/usr/bin:/bin
unset PYTHONPATH

exec  ${buildout:directory}/bin/salt-minion -c ${buildout:directory}
