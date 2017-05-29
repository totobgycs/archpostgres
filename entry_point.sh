#!/bin/bash
CREATE_USER="create role $USERNAME superuser createdb createrole inherit login password '$PASSWORD'; "
eval 'sleep 10; psql --command "$CREATE_USER"' & 
postgres -i -e -D /var/lib/postgres/data/ 
