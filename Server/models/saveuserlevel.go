package models

import (
    "fmt"
    "log"
    "net/http"

    "github.com/gin-gonic/gin"
    _ "github.com/go-sql-driver/mysql"
)

type SaveLevel struct{

    ID         int    `json:"id"`
	Level string `json:"level"`
}


func SaveStudentLevel(c *gin.Context){

fmt.Println("Save Student Level")
c.Header("Access-Control-Allow-Origin", "*")
c.Header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
c.Header("Access-Control-Allow-Headers", "Content-Type")

if c.Request.Method == http.MethodOptions {
	c.JSON(http.StatusOK, nil)
	return
}

if c.Request.Method != http.MethodPost {
	c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
	return
}

    var data SaveLevel

if err := c.ShouldBindJSON(&data); err != nil {
	log.Printf("Failed to bind JSON: %v", err)
	c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
	return
}
log.Printf("Parsed User: %+v", data)


db, err := GetDBConnection()
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
        return
    }
    defer db.Close()


	query := "UPDATE user SET EnglishProficency= ?, UpdatedBy = NOW(), UpdateTime = NOW() WHERE ID = ?"
	_, err = db.Exec(query, data.Level, data.ID)
	if err != nil {
		log.Printf("Failed to update data: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update data"})
		return
	}
	
	// Respond with success
	c.JSON(http.StatusOK, gin.H{"message": "User updated successfully"})
	

    // Respond with success
    c.JSON(http.StatusOK, gin.H{"message": "User registered successfully"})
}