package routes

import (
	"fmt"
	"models" // Ensure this path is correct based on your project structure
	"net/http"

	"github.com/gin-gonic/gin"
)

func StudentDatas(c *gin.Context) {
	fmt.Println("Starting StudentData")

	// Handle CORS for preflight requests
	c.Header("Access-Control-Allow-Origin", "*")
	c.Header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
	c.Header("Access-Control-Allow-Headers", "Content-Type")

	if c.Request.Method == http.MethodOptions {
		c.JSON(http.StatusOK, nil)
		return
	}

	if c.Request.Method != http.MethodGet && c.Request.Method != http.MethodPost {
		c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
		return
	}

	createdBy := c.Query("createdBy")
	if createdBy == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "CreatedBy (email) is required"})
		return
	}

	// Establish a database connection
	db, err := models.GetDBConnection()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
		return
	}
	defer db.Close()

	// Call the GetStudentData function with the database connection
	students, err := models.GetStudentData(db, createdBy)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"message": "Something went wrong",
			"error":   err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, students)
}


