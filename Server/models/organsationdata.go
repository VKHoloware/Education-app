package models

import (
    "fmt"
    "net/http"

    "github.com/gin-gonic/gin"
    _ "github.com/go-sql-driver/mysql"
)

type OrganisationNameData struct {
    Id   int    `json:"id"`
    Name string `json:"name"`
}

func OrganisationName(c *gin.Context) {
    fmt.Println("Get Organisation Data")
    
    // Handle CORS for preflight requests
    c.Header("Access-Control-Allow-Origin", "*")
    c.Header("Access-Control-Allow-Methods", "GET, OPTIONS")
    c.Header("Access-Control-Allow-Headers", "Content-Type")

    if c.Request.Method == http.MethodOptions {
        c.JSON(http.StatusOK, nil)
        return
    }

    if c.Request.Method != http.MethodGet {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request method"})
        return
    }

    db, err := GetDBConnection()
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
        return
    }
    defer db.Close()

    query := "SELECT Id, Name FROM organization"
    rows, err := db.Query(query)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Fetching data from the database"})
        return
    }
    defer rows.Close()

    var organisations []OrganisationNameData

    for rows.Next() {
        var org OrganisationNameData
        if err := rows.Scan(&org.Id, &org.Name); err != nil {
            c.JSON(http.StatusInternalServerError, gin.H{"error": "Error scanning data"})
            return
        }
        organisations = append(organisations, org)
    }

    if err := rows.Err(); err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Error processing rows"})
        return
    }

    c.JSON(http.StatusOK, organisations)
}
