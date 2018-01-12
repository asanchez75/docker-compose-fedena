#!/bin/bash
if [ ! -f ./data_loaded ]; then
  cp -Rf /data/fedena/* ./
  touch ./data_loaded
fi
cd ./ && rake db:create && rake fedena:plugins:install_all && script/server
