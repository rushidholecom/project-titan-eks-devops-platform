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
  -e MARIADB_DATABASE=student_db `
  -e MARIADB_USER=rushi `
  -e MARIADB_PASSWORD=rushi123 `
  titan-mariadb:latest
```

On first startup, MariaDB automatically runs `docker/init.sql` from `/docker-entrypoint-initdb.d/`.

Connect the backend to this container using:

- Host: `titan-db` if both containers are on the same Docker network
- Host: `localhost` if the backend runs on your machine
- Port: `3306`
- Database: `student_db`
- Username: `rushi`
- Password: `rushi123`

## Compose Stack

Start the full 3-tier stack from the project root:

```bash
docker compose up --build -d
```

The Compose file is defined in [compose.yaml](../compose.yaml) and starts:

- `database` on port `3306`
- `backend` on port `8080`
- `frontend` on port `3000`

Both app images are built from the EasyCRUD fork repository using the top-level
`backend/` and `frontend/` folders. You can override the source repo or branch
with `EASYCRUD_REPO` and `EASYCRUD_REF` in `.env`.

To stop the stack:

```bash
docker compose down
```

To stop the stack and remove the database volume:

```bash
docker compose down -v
```
