#!/bin/sh
# Runs only when the dedicated PostgreSQL data volume is first initialized.
# The application owns its database but has no cluster administrator privileges.
set -eu

psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" \
  --set=ON_ERROR_STOP=1 --set=app_password="$PAPERCLIP_DB_PASSWORD" <<'SQL'
CREATE ROLE paperclip LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE NOREPLICATION PASSWORD :'app_password';
ALTER DATABASE paperclip OWNER TO paperclip;
SQL
