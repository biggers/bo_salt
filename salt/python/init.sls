python-deps:
  pkg.installed:
    - names:
      - build-essential
      - libreadline5
      - libbz2-dev
      - libzzip-dev 
      - libtar-dev
      - g++

python-buildout:
  git.latest:
    - target: /home/delicj/buildout.python
    - name: https://github.com/collective/buildout.python.git

python-buildout-file:
  file.managed:
    - source: salt://python/local.cfg
    - name: /home/delicj/buildout.python/local.cfg
    - require:
      - git: python-buildout

python-build:
  cmd.run:
    - cwd: /home/delicj/buildout.python
    - name: python bootstrap.py -d && ./bin/buildout -c local.cfg
    - require:
      - pkg: python-deps 
      - file: python-buildout-file
      - git: python-buildout
