package models

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
)


type TestData struct {
	ID int `json:"id"`
	LessonLevel           string  `json:"lessonlevel"`
	UserLevel          string  `json:"userlevel"`
	Datas string  `json:"datas"`
}

func Testdata(c *gin.Context) {
	fmt.Println("Starting Testdata")

	// Handle CORS for preflight requests
	c.Header("Access-Control-Allow-Origin", "*")
	c.Header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
	c.Header("Access-Control-Allow-Headers", "Content-Type")

	if c.Request.Method == http.MethodOptions {
		c.JSON(http.StatusOK, nil)
		return
	}

	// Now allow both GET and POST methods (if necessary)
	if c.Request.Method != http.MethodGet && c.Request.Method != http.MethodPost {
		c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
		return
	}

	// Connect to the database
	db, err := GetDBConnection()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
		return
	}
	defer db.Close()

	// Query to select data filtered by LessonLevel and UserLevel
	query := `SELECT ID, LessonLevel, UserLevel, datas FROM testdata WHERE LessonLevel='Vocabulary' AND UserLevel='Basic' `

	rows, err := db.Query(query)
	if err != nil {
		log.Printf("Failed to retrieve the data: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data"})
		return
	}
	defer rows.Close()

	var testDatas []TestData

	// Iterate over rows and scan the results into a slice of TestData structs
	for rows.Next() {
		var testData TestData
		err := rows.Scan(&testData.ID, &testData.LessonLevel, &testData.UserLevel, &testData.Datas)
		if err != nil {
			log.Printf("Failed to scan row: %v", err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse data"})
			return
		}

		testDatas = append(testDatas, testData)
	}

	// Check for any row iteration errors
	if err := rows.Err(); err != nil {
		log.Printf("Row iteration error: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error iterating over data"})
		return
	}

	// Respond with the retrieved data
	c.JSON(http.StatusOK, gin.H{"data": testDatas})
}
func UpdateHandler(w http.ResponseWriter, r *http.Request) {
    // Parse the request body
    var updates map[string]string
    err := json.NewDecoder(r.Body).Decode(&updates)
    if err != nil {
        http.Error(w, "Invalid request payload", http.StatusBadRequest)
        return
    }

    // Here you should have logic to update the database with the new data.
    // Example code (pseudo-code):
    // db := GetDatabaseConnection()
    // for question, answer := range updates {
    //     db.Exec("UPDATE questions SET answer = ? WHERE question = ?", answer, question)
    // }

    // Send a success response
    w.WriteHeader(http.StatusOK)
    w.Write([]byte("Updates saved successfully"))
}