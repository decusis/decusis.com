PGPASSWORD=$PGPWD psql -p $PGPORT -h $PGHOST -U $PGUSER $PGNAME