module.exports = {
  "ci": {
    "server": {
      "port": process.env.PORT || 8080,
      "storage": {
        "storageMethod": "sql",
        "sqlDialect": "sqlite",
        "sqlDatabasePath": "/data/db"
      }
    }
  }
}
