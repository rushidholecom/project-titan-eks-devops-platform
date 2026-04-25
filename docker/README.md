# Docker Images

## Database Image

The database image is defined in `docker/database.Dockerfile`.
The initialization script is defined in `docker/init.sql`.

Build it from the project root:

```powershell
docker build -f docker/database.Dockerfile -t titan-mariadb:latest .
```

Run the database container:

```powershell
docker run -d `
  --name titan-db `
  -p 3306:3306 `
  -e MARIADB_ROOT_PASSWORD=root123 `
  -e MARIADB_DATABASE=titandb `
  -e MARIADB_USER=titanuser `
  -e MARIADB_PASSWORD=titanpass `
  titan-mariadb:latest
```

On first startup, MariaDB automatically runs `docker/init.sql` from `/docker-entrypoint-initdb.d/`.

Connect the backend to this container using:

- Host: `titan-db` if both containers are on the same Docker network
- Host: `localhost` if the backend runs on your machine
- Port: `3306`
- Database: `titandb`
- Username: `titanuser`
- Password: `titanpass`
