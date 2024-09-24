package models

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
)

type OrganisationRegisterData struct {
	OrganisationName string `json:"organisationname"`
	Name             string `json:"name"`
	Email            string `json:"email"`
	Place            string `json:"place"`
	Phonenumber      string `json:"phonenumber"`
	Password         string `json:"password"` // Make sure the JSON field matches your struct
}

func OrganisationRegister(c *gin.Context) {
	fmt.Print("Starting OrganisationRegister\n")

	// Handle CORS for preflight requests
	c.Header("Access-Control-Allow-Origin", "*")
	c.Header("Access-Control-Allow-Methods", "POST, OPTIONS")
	c.Header("Access-Control-Allow-Headers", "Content-Type")

	if c.Request.Method == http.MethodOptions {
		c.JSON(http.StatusOK, nil)
		return
	}

	if c.Request.Method != http.MethodPost {
		c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
		return
	}

	var organizationdata OrganisationRegisterData
	if err := c.ShouldBindJSON(&organizationdata); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
		return
	}

	fmt.Printf("Received Data: Email: %s, Name: %s, OrganisationName: %s, Password: %s\n",
		organizationdata.Email, organizationdata.Name, organizationdata.OrganisationName, organizationdata.Password)

	// Connect to the database
	db, err := GetDBConnection()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
		return
	}
	defer db.Close()

	// Insert data into the database
	query := `INSERT INTO organization 
				(Name, AdminName, Email, Place, Phone, CreatedBy, Password, CreatedTime) 
			  VALUES (?, ?, ?, ?, ?, ?, ?, NOW())`
	result, err := db.Exec(query, organizationdata.OrganisationName, organizationdata.Name, organizationdata.Email, organizationdata.Place, organizationdata.Phonenumber, organizationdata.Email, organizationdata.Password)
	if err != nil {
		log.Printf("Failed to insert data: %v", err) // Log the detailed error
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to insert data"})
		return
	}

	rowsAffected, _ := result.RowsAffected()
	fmt.Printf("Rows affected: %d\n", rowsAffected)

	// Respond with success
	c.JSON(http.StatusOK, gin.H{"message": "Organisation registered successfully"})
}
