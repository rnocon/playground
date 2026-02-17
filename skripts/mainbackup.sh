#!/bin/bash

set -euo pipefail


TODAY="$(date +%Y%m%d)"
FOLDER="backup_${TODAY}"

echo "Lege Tagesordner an..."

mkdir /workspaces/playground/backup/$FOLDER

echo "Ordner angelegt!!!"

echo "Starte Datenbank-Dump..."

./dbdump.sh $FOLDER $1

echo "Dump fertig!!!"

echo "Starte Datenbank-Backup..."

./dbbackup.sh $FOLDER $1

echo "Datenbank-Backup fertig!!!"

echo "Starte Compose-Backup..."

./confbackup.sh $FOLDER

echo "Compose-Backup fertig!!!"
