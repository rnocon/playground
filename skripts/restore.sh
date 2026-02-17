#!/bin/bash

set -euo pipefail

if [[ $# -lt 1 ]] ; then
	echo "Fehler: Bitte Backup-Ordner angeben!"
	exit 1
fi

BACKUP_BASE="/workspaces/playground/backup"
BACKUP_PATH="$BACKUP_BASE/backup_$1"

if [[ ! -d "$BACKUP_PATH" ]]; then
    echo "Fehler: Backup-Ordner existiert nicht: $BACKUP_PATH"
    exit 1
fi

echo "Backup gefunden: $BACKUP_PATH"

RESTORE_BASE="/workspaces/playground/$2"

mkdir -p $RESTORE_BASE

cp "$BACKUP_PATH/docker-compose.yml" $RESTORE_BASE



