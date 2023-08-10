##Main configuration##

1. Copy `base__dump_remote_db.sh` to `dump_remote_db.sh` and set there correct remote_db_password:
```
cp base__dump_remote_db.sh dump_remote_db.sh
```

2. To load correct dump exect the running mariadb docker container and execute `dump_remote_db.sh` script inside it:
```
./dump_remote_db.sh
```