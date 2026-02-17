#!/bin/bash

set -euo pipefail

ENV_FILE='/workspaces/playground/backup.env'

if [[ -f "$ENV_FILE" ]] ;
then
	export $(grep -v '^#' "$ENV_FILE" | xargs -0)
else
	echo "Warnung: $ENV_FILE nicht gefunden - Standardwerte werden genutzt."
fi


if [[ $# -lt 1 ]]; then
  if [[ -n "${DEFAULT_BACKUP_PATH:-}" ]]; then
    TARGET_PATH="$DEFAULT_BACKUP_PATH"
    echo "Kein Pfad angegeben"
    #exit 1
  else
    echo "Fehler: Kein Zielpfad angegeben und DEFAULT_BACKUP_PATH existiert nicht."
    exit 1
  fi
else
  TARGET_PATH="$DEFAULT_BACKUP_PATH/$1"
fi

docker exec $2 sh -c "mariadb-dump --all-databases --single-transaction --quick --routines --triggers --events --tz-utc -u root -p'rootpass'" > "$TARGET_PATH/db.sql"


