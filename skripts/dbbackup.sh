#!/bin/bash

set -euo pipefail

ENV_FILE='/workspaces/playground/backup.env'
CONTAINER_DIR='/tmp/mariabackup'

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

docker exec $2 sh -c "rm -rf $CONTAINER_DIR && mkdir -p $CONTAINER_DIR"

docker exec $2 sh -c "mariadb-backup --backup --user=$DB_USER  --password=$DB_PASSWORD  --target-dir=$CONTAINER_DIR"

docker exec $2 sh -c "mariadb-backup --prepare --target-dir=$CONTAINER_DIR"

docker cp $2:$CONTAINER_DIR $TARGET_PATH

docker exec $2 sh -c "rm -rf $CONTAINER_DIR"
