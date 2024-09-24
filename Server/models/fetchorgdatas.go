package models

import (
    "database/sql"
    "fmt"
    "log"
    "net/http"

    "github.com/gin-gonic/gin"
    _ "github.com/go-sql-driver/mysql"
)

type OrganisationData struct {
    ID         int    `json:"id"`
    Name       string `json:"name"`
    Email      string `json:"email"`
    AdminName  string `json:"AdminName"`
    Place      string `json:"Place"`
}

func OrganisationDetails(c *gin.Context) {
    fmt.Print("Starting OrganisationDetails")

    // Handle CORS
    c.Header("Access-Control-Allow-Origin", "*")
    c.Header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
    c.Header("Access-Control-Allow-Headers", "Content-Type")

    if c.Request.Method == http.MethodOptions {
        c.JSON(http.StatusOK, nil)
        return
    }

    if c.Request.Method != http.MethodGet {
        c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
        return
    }

    id := c.Query("id")
    if id == "" {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Missing id parameter"})
        return
    }

    db, err := GetDBConnection()
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
        return
    }
    defer db.Close()

    // Corrected query without trailing comma
    query := `SELECT Name, Email, AdminName, Place FROM organization WHERE ID = ?`
    row := db.QueryRow(query, id)

    var data OrganisationData
    err = row.Scan(&data.Name, &data.Email, &data.AdminName, &data.Place)
    if err != nil {
        if err == sql.ErrNoRows {
            c.JSON(http.StatusNotFound, gin.H{"error": "No data found for the given id"})
        } else {
            log.Printf("Failed to retrieve the data: %v", err)
            c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data"})
        }
        return
    }

    // Respond with the fetched data
    c.JSON(http.StatusOK, data)
}
