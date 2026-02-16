#!/bin/bash

set -euo pipefail


TODAY="$(date +%Y%m%d)"
FOLDER="backup_${TODAY}"

echo "Lege Tagesordner an..."

mkdir /workspaces/playground/testvm/backup/$FOLDER

echo "Ordner angelegt!!!"

echo "Starte Datenbank-Dump..."

./dbdump.sh $FOLDER

echo "Dump fertig!!!"

echo "Starte Datenbank-Backup..."

./dbbackup.sh $FOLDER

echo "Datenbank-Backup fertig!!!"

echo "Starte Compose-Backup..."

./confbackup.sh $FOLDER

echo "Compose-Backup fertig!!!"
