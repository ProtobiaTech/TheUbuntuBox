#!/bin/bash

php -v
apachectl -v
mysql -V
env

exec $@
