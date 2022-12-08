# pg_activity - docker

## Usage

```bash
docker run --rm -it PGUSER= rsmnarts/pg_activity -U postgres -h host.docker.internal
```

```bash
docker run --rm -it -e PGHOST=host.docker.internal -e PGUSER=postgres rsmnarts/pg_activity
```

more help:

```bash
docker run --rm -it rsmnarts/pg_activity --help
```

## Options

    pg_activity [options] [connection string]

    Options:
      --blocksize BLOCKSIZE
                            Filesystem blocksize (default: 4096).
      --rds                 Enable support for AWS RDS (implies --no-tempfiles and filters out the rdsadmin database from space calculation).
      --output FILEPATH     Store running queries as CSV.
      --no-db-size          Skip total size of DB.
      --no-tempfiles        Skip tempfile count and size.
      --no-walreceiver      Skip walreceiver checks.
      -w, --wrap-query      Wrap query column instead of truncating.
      --duration-mode DURATION_MODE
                            Duration mode. Values: 1-QUERY(default), 2-TRANSACTION, 3-BACKEND.
      --min-duration SECONDS
                            Don't display queries with smaller than specified duration (in seconds).
      --filter FIELD:REGEX  Filter activities with a (case insensitive) regular expression applied on selected fields. Known fields are: dbname.
      --debug-file DEBUG_FILE
                            Enable debug and write it to DEBUG_FILE.
      --version             show program's version number and exit.
      --help                Show this help message and exit.

    Connection Options:
      connection string     A valid connection string to the database, e.g.: 'host=HOSTNAME port=PORT user=USER dbname=DBNAME'.
      -h HOSTNAME, --host HOSTNAME
                            Database server host or socket directory.
      -p PORT, --port PORT  Database server port.
      -U USERNAME, --username USERNAME
                            Database user name.
      -d DBNAME, --dbname DBNAME
                            Database name to connect to.

    Process table display options:
      These options may be used hide some columns from the processes table.

      --no-pid              Disable PID.
      --no-database         Disable DATABASE.
      --no-user             Disable USER.
      --no-client           Disable CLIENT.
      --no-cpu              Disable CPU%.
      --no-mem              Disable MEM%.
      --no-read             Disable READ/s.
      --no-write            Disable WRITE/s.
      --no-time             Disable TIME+.
      --no-wait             Disable W.
      --no-app-name         Disable App.

    Other display options:
      --hide-queries-in-logs
                            Disable log_min_duration_statements and log_min_duration_sample for pg_activity.
      --no-inst-info        Display instance information in header.
      --no-sys-info         Display system information in header.
      --no-proc-info        Display workers process information in header.
      --refresh REFRESH     Refresh rate. Values: 0.5, 1, 2, 3, 4, 5 (default: 2).

## Notes

Length of SQL query text that `pg_activity` reports relies on PostgreSQL
parameter `track_activity_query_size`. Default value is `1024` (expressed in
bytes). If your SQL query text look truncated, you should increase
`track_activity_query_size`.

## Interactives commands

| Key       | Action                                                            |
| --------- | ----------------------------------------------------------------- |
| `r`       | Sort by READ/s, descending                                        |
| `w`       | Sort by WRITE/s, descending                                       |
| `c`       | Sort by CPU%, descending                                          |
| `m`       | Sort by MEM%, descending                                          |
| `t`       | Sort by TIME+, descending                                         |
| `T`       | Change duration mode: query, transaction, backend                 |
| `Space`   | Pause on/off                                                      |
| `v`       | Change queries display mode: full, indented, truncated            |
| `UP/DOWN` | Scroll processes list                                             |
| `k/j`     | Scroll processes list                                             |
| `q`       | Quit                                                              |
| `+`       | Increase refresh time. Maximum value : 5s                         |
| `-`       | Decrease refresh time. Minimum Value : 0.5s                       |
| `F1/1`    | Running queries list                                              |
| `F2/2`    | Waiting queries list                                              |
| `F3/3`    | Blocking queries list                                             |
| `h`       | Help page                                                         |
| `R`       | Refresh                                                           |
| `D`       | Refresh Database Size (including when --no-dbzise option applied) |
| `s`       | Display system information in header                              |
| `i`       | Display general instance information in header                    |
| `o`       | Display worker information in header                              |

## Navigation mode

| Key        | Action                                        |
| ---------- | --------------------------------------------- |
| `UP`/`k`   | Move up the cursor                            |
| `DOWN`/`j` | Move down the cursor                          |
| `K`        | Terminate the current backend/tagged backends |
| `C`        | Cancel the current backend/tagged backends    |
| `Space`    | Tag or untag the process                      |
| `q`        | Quit                                          |
| `Other`    | Back to activity                              |
