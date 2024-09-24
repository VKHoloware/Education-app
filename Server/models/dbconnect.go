
package models

import (
    "database/sql"
    "fmt"
    "os"

    _ "github.com/go-sql-driver/mysql"
    "github.com/joho/godotenv"
)

// GetDBConnection establishes and returns a database connection.
func GetDBConnection() (*sql.DB, error) {
    // Load environment variables from .env file
    if err := godotenv.Load(); err != nil {
        return nil, fmt.Errorf("error loading .env file")
    }

    // Get environment variables
    dbUser := os.Getenv("DB_USER")
    dbPassword := os.Getenv("DB_PASSWORD")
    dbHost := os.Getenv("DB_HOST")
    dbPort := os.Getenv("DB_PORT")
    dbName := os.Getenv("DB_NAME")

    // Create the DSN (Data Source Name) string
    dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", dbUser, dbPassword, dbHost, dbPort, dbName)

    // Open a connection to the database
    db, err := sql.Open("mysql", dsn)
    if err != nil {
        return nil, err
    }

    // Ping the database to ensure the connection is established
    if err := db.Ping(); err != nil {
        return nil, err
    }

    return db, nil
}
