with import <nixpkgs> {};

python35.withPackages (ps: with ps; [
  numpy
  toolz
  tensorflow
  pytz
  requests
  setuptools
  tzlocal
  i3ipc
])
