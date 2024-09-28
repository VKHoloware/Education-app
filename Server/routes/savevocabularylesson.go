package routes

import (
	// "fmt"
	"encoding/json"
	"models" // Ensure this path is correct based on your project structure
	"net/http"

	// "strconv"
	// "structure" // Ensure the structure package is correctly imported

	"fmt"
	"structure"

	"github.com/gin-gonic/gin"
)


func SaveVocabularyQuestion(c *gin.Context) {
	fmt.Println("Starting SaveVocabularyQuestion")

	if c.Request.Method == http.MethodOptions {
		c.JSON(http.StatusOK, nil)
		return
	}

	if c.Request.Method != http.MethodPost {
		c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
		return
	}

	var vocabulary structure.VocabularyData // Adjusted to use your structure package
	if err := c.ShouldBindJSON(&vocabulary); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Error decoding JSON"})
		return
	}

	// Establish a database connection
	db, err := models.GetDBConnection()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
		return
	}
	defer db.Close()

	// Convert the vocabulary data to JSON
	datasJSON, err := json.Marshal(vocabulary.Datas)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error converting to JSON"})
		return
	}

	// Call the function to save vocabulary data
	res, err := models.AddVocabularyData(db, vocabulary, string(datasJSON))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": res})
}

	func SaveVocabularyTestQuestion(c *gin.Context) {
		fmt.Println("Starting SaveVocabularyTestQuestion")

		if c.Request.Method == http.MethodOptions {
			c.JSON(http.StatusOK, nil)
			return
		}

		if c.Request.Method != http.MethodPost {
			c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
			return
		}

		var vocabulary structure.SaveVocabularyTestQuestion // Adjusted to use your structure package
		if err := c.ShouldBindJSON(&vocabulary); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Error decoding JSON"})
			return
		}

		// Establish a database connection
		db, err := models.GetDBConnection()
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
			return
		}
		defer db.Close()

		// Call the function to update the answers in the database
		res, err := models.AddVocabularyTestQuestion(db, vocabulary)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"message": res})
	}