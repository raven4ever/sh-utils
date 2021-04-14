# Purpose

Scripts to fully export and import the content of a MongoDB database.

# Usage

To export:

```shell
SRC_DB_URL=""
SRC_DB_PORT=""
SRC_DB_USR=""
SRC_DB_PASS=""
SSL_CA_FILE_PATH=""
./export_mongo.sh
```

To import:

```shell
DST_DB_URL=""
DST_DB_PORT=""
DST_DB_USR=""
DST_DB_PASS=""
SSL_CA_FILE_PATH=""
./import_mongo.sh
```

Alternatively, the connection parameters can be set inside the scripts.

# Prerequisites

The scripts require the `mongoexport` and `mongoimport` tools from the MongoDB Database Tools to be
installed ([instructions](https://docs.mongodb.com/database-tools/installation/installation/)).
