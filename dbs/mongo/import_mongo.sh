#!/usr/bin/env bash

# Connection parameters
#DST_DB_URL=""
#DST_DB_PORT=""
#DST_DB_USR=""
#DST_DB_PASS=""
#SSL_CA_FILE_PATH=""

# Runtime
source ../../functions/general/all.sh

rm -f "mongo_import_log.log"

consolelog "Starting" >>"mongo_import_log.log"

if [ -f "./mappingz" ]; then
  consolelog "Starting import" >>"mongo_import_log.log"
  parallel -a mappingz --colsep ',' --joblog "parallel_import_joblog.txt" -I{} mongoimport --host="${DST_DB_URL}:${DST_DB_PORT}" --username="${DST_DB_USR}" --password="${DST_DB_PASS}" --ssl --sslCAFile="${SSL_CA_FILE_PATH}" --tlsInsecure --db={1} --collection={2} --jsonArray --type=json --file="{2}.json"
  consolelog "Finished import" >>"mongo_import_log.log"
else
  consolelog "DB-Collections mapping file doesn't exist!!!!" error >>"mongo_import_log.log"
  exit 1
fi
