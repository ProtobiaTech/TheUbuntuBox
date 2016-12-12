#!/bin/bash

php -v
apachectl -v
mysql -V

supervisord -n
exec "$@"
