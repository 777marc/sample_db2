# DB2 Database with Users Table

This Docker setup creates a DB2 database with a pre-populated USERS table containing 20 sample users.

## Prerequisites

- Docker Desktop installed and running
- At least 4GB of RAM allocated to Docker
- Approximately 3GB of free disk space

## Database Schema

The USERS table includes:

- `USER_ID` - Integer primary key (auto-increment)
- `FIRST_NAME` - VARCHAR(50)
- `LAST_NAME` - VARCHAR(50)
- `EMAIL` - VARCHAR(100) with unique constraint

## Getting Started

### 1. Build the Docker Image

Open PowerShell in this directory and run:

```powershell
docker build -t db2-users .
```

This will download the DB2 Community Edition image (~2GB) and build your custom image.

### 2. Run the Container

```powershell
docker run -d --name db2-container -p 50000:50000 --privileged db2-users
```

**Note**: The `--privileged` flag is required for DB2 to run properly in Docker.

### 3. Wait for Initialization

DB2 takes several minutes to initialize. Monitor the logs:

```powershell
docker logs -f db2-container
```

Wait until you see "DB2 initialization complete" in the logs.

### 4. Connect to the Database

#### Using DB2 Command Line (from within the container)

```powershell
docker exec -it db2-container bash -c "su - db2inst1"
```

Then run:

```bash
db2 connect to testdb
db2 "SELECT * FROM USERS"
```

#### Connection Details for External Clients

- **Host**: localhost
- **Port**: 50000
- **Database**: testdb
- **Username**: db2inst1
- **Password**: db2inst1

## Verify the Data

To verify the 20 users were inserted:

```powershell
docker exec -it db2-container bash -c "su - db2inst1 -c 'db2 connect to testdb && db2 \"SELECT COUNT(*) FROM USERS\" && db2 connect reset'"
```

## Managing the Container

### Stop the Container

```powershell
docker stop db2-container
```

### Start the Container

```powershell
docker start db2-container
```

### Remove the Container

```powershell
docker rm -f db2-container
```

### Remove the Image

```powershell
docker rmi db2-users
```

## Troubleshooting

- **Container exits immediately**: Ensure Docker has enough memory (4GB minimum)
- **Connection refused**: Wait longer for DB2 to initialize (can take 5-10 minutes on first run)
- **Permission denied**: Make sure you're running Docker with appropriate privileges

## Sample Queries

Once connected, try these queries:

```sql
-- View all users
SELECT * FROM USERS;

-- Search by last name
SELECT * FROM USERS WHERE LAST_NAME = 'Smith';

-- Count users
SELECT COUNT(*) FROM USERS;

-- Find user by email
SELECT * FROM USERS WHERE EMAIL = 'john.smith@example.com';
```
