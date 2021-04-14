#!/usr/bin/env bash

# Connection parameters
#SRC_DB_URL=""
#SRC_DB_PORT=""
#SRC_DB_USR=""
#SRC_DB_PASS=""
#SSL_CA_FILE_PATH=""

# Runtime
source ../../functions/general/all.sh

rm -f "mongo_export_log.log"

consolelog "Starting" >>"mongo_export_log.log"

# Cleanup
rm -rf ./mappingz

# Get all dbs
consolelog "Get all DBs" >>"mongo_export_log.log"
readarray -t all_dbs < <(echo "JSON.stringify(db.adminCommand({ listDatabases:1,nameOnly:1 }))" | mongo --host="${SRC_DB_URL}:${SRC_DB_PORT}" --username="${SRC_DB_USR}" --password="${SRC_DB_PASS}" --tls --tlsCAFile="${SSL_CA_FILE_PATH}" --quiet | jq -r '.databases | map(.name) | .[]')

# for each DB gel all collections
consolelog "Get all collections" >>"mongo_export_log.log"
for db in "${all_dbs[@]}"; do
  readarray -t all_collections < <(echo "JSON.stringify(db.getCollectionNames())" | mongo "${SRC_DB_URL}:${SRC_DB_PORT}/${db}" --username="${SRC_DB_USR}" --password="${SRC_DB_PASS}" --tls --tlsCAFile="${SSL_CA_FILE_PATH}" --quiet | jq -r '.[]')

  for col in "${all_collections[@]}"; do
    echo "${db},${col}" >>mappingz
  done
done

# start export for all collections
consolelog "Starting export" >>"mongo_export_log.log"
parallel -a mappingz --colsep ',' --joblog "parallel_export_joblog.txt" -I{} mongoexport --host="${SRC_DB_URL}:${SRC_DB_PORT}" --username="${SRC_DB_USR}" --password="${SRC_DB_PASS}" --ssl --sslCAFile="${SSL_CA_FILE_PATH}" --db={1} --collection={2} --jsonArray --pretty --out="{2}.json"
consolelog "Finished export" >>"mongo_export_log.log"
