// package routes

// import (
// 	"models"        // Ensure this path is correct based on your project structure
// 	"net/http"
// 	"structure"

// 	"github.com/gin-gonic/gin"
// )

// // SaveWords function saves words and establishes a DB connection
// func SaveWords(c *gin.Context) {
// 	var saveWords structure.AddWords

// 	db, err := models.GetDBConnection()
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to connect to the database"})
// 		return
// 	}
// 	defer db.Close()

// 	res,err := models.AddWords()

// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{
// 			"message": "Something went wrong",
// 			"error":   err.Error(),
// 		})
// 		return
// 	}

// 	if res=="Word added Successfuly"{
// 		c.JSON(http.StatusOK, gin.H{
// 			"message": res,
// 		})
// 		return
// 	}
// 	c.JSON(http.StatusOK, gin.H{
// 		"message": "Data inserted Successfully",
// 		"data":    res,
// 	})

// }  FetchVocabulary

package routes

import (
	"fmt"
	"models" // Ensure this path is correct based on your project structure
	"net/http"
	"strconv"
	"structure" // Ensure the structure package is correctly imported

	"github.com/gin-gonic/gin"
)
	func SaveWords(c *gin.Context) {
		var saveWords structure.AddWords
		print("Save Words")

		if c.Request.Method == http.MethodOptions {
			c.JSON(http.StatusOK, nil)
			return
		}
	
		if c.Request.Method != http.MethodPost {
			c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid Method"})
			return
		}

		if err := c.ShouldBindJSON(&saveWords); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
			return
		}

		// Establish a database connection
		db, err := models.GetDBConnection()
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to connect to the database"})
			return
		}
		defer db.Close()

		// Call the AddWords function with the database connection and the entire saveWords object
		res, err := models.AddWords(db, saveWords) // Pass db and saveWords to the function

		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{
				"message": "Something went wrong",
				"error":   err.Error(),
			})
			return
		}

		c.JSON(http.StatusOK, gin.H{
			"message": res,
		})
	}



	func FetchWords(c *gin.Context) {
		var fetchData structure.Fetchvocabulary
		print("Fetch Words")
	
		if c.Request.Method == http.MethodOptions {
			c.JSON(http.StatusOK, nil)
			return
		}
	
		if c.Request.Method != http.MethodGet {
			c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid Method"})
			return
		}
	
		id := c.Query("id")
		if id == "" {
			c.JSON(http.StatusBadRequest, gin.H{"error": "ID parameter is required"})
			return
		}
	
		userID, err := strconv.Atoi(id)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID format"})
			return
		}
	
		fetchData.ID = userID
	
		db, err := models.GetDBConnection()
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to connect to the database"})
			return
		}
		defer db.Close()
	
		res, err := models.FetchVocabulary(db, fetchData)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{
				"message": "Something went wrong",
				"error":   err.Error(),
			})
			return
		}
	
		if res == nil {
			c.JSON(http.StatusNotFound, gin.H{"message": "No words found for this user."})
			return
		}
		fmt.Print(res,err)
	
		c.JSON(http.StatusOK, gin.H{
			"words": res,
		})
	}

	
	