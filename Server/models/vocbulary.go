package models

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"net/http"
	"time"

	// "strconv"
	"structure"

	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
)


type TestData struct {
	ID int `json:"id"`

	LessonLevel           string  `json:"lessonlevel"`
	UserLevel          string  `json:"userlevel"`
	Datas string  `json:"datas"`
	CreatedBy int `json:"createdby"`

}
type VocabularyData struct {
	LessonLevel   string `json:"LessonLevel"`
	UserLevel     string `json:"UserLevel"`
	Datas         []map[string]interface{} `json:"Datas"`
	OrganisationID int    `json:"organisationid"`
	CreatedBy     string `json:"CreatedBy"`
	// LessonLevel string                   `json:"LessonLevel"`
	// UserLevel   string                   `json:"UserLevel"`
	// Datas       []map[string]interface{} `json:"Datas"` // This will hold the vocabulary entries
	// CreatedBy   int                      `json:"CreatedBy"`
}

func DefaultVocabularyLevel(c *gin.Context) {
	fmt.Println("Starting DefaultVocabularyLevel")

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

	db, err := GetDBConnection()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
		return
	}
	defer db.Close()

	query := `SELECT ID, LessonLevel, UserLevel, datas FROM testdata WHERE LessonLevel='Vocabulary' AND UserLevel='Default' `

	rows, err := db.Query(query)
	if err != nil {
		log.Printf("Failed to retrieve the data: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data"})
		return
	}
	defer rows.Close()

	var testDatas []TestData

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

	if err := rows.Err(); err != nil {
		log.Printf("Row iteration error: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error iterating over data"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"data": testDatas})
}

// func FetchVocabularyTestQuestion(c *gin.Context) {
//     // Set CORS headers
//     c.Header("Access-Control-Allow-Origin", "*")
//     c.Header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
//     c.Header("Access-Control-Allow-Headers", "Content-Type")

//     // Handle preflight OPTIONS request
//     if c.Request.Method == http.MethodOptions {
//         c.JSON(http.StatusOK, nil)
//         return
//     }

//     // Check for valid GET request
//     if c.Request.Method != http.MethodGet {
//         c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
//         return
//     }

//     // Get ID from query parameters
//     id := c.Query("id")
//     if id == "" {
//         c.JSON(http.StatusBadRequest, gin.H{"error": "ID parameter is required"})
//         return
//     }

//     // Connect to the database
//     db, err := GetDBConnection()
//     if err != nil {
//         log.Printf("Error connecting to the database: %v", err)
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Error connecting to the database"})
//         return
//     }
//     defer db.Close() // Ensure the database connection is closed

//     // Prepare the SQL query
//     query := `SELECT answer FROM testdata WHERE ID=?`
//     var answer sql.NullString

//     // Execute the query
//     err = db.QueryRow(query, id).Scan(&answer)
//     if err != nil {
//         log.Printf("Error executing query: %v", err)
//         if err == sql.ErrNoRows {
//             c.JSON(http.StatusNotFound, gin.H{"error": "No data found for the provided ID"})
//         } else {
//             c.JSON(http.StatusInternalServerError, gin.H{"error": "Error executing query"})
//         }
//         return
//     }

//     // Check if we got a valid answer
//     if answer.Valid {
//         log.Printf("Retrieved answer: %s", answer.String)
//         c.JSON(http.StatusOK, gin.H{"answer": answer.String}) // Return as JSON
//     } else {
//         log.Printf("No data found for ID: %s", id)
//         c.JSON(http.StatusNotFound, gin.H{"error": "No data found"})
//     }
// }

// func FetchVocabularyTestQuestion(c *gin.Context) {
//     // Set CORS headers
//     c.Header("Access-Control-Allow-Origin", "*")
//     c.Header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
//     c.Header("Access-Control-Allow-Headers", "Content-Type")

//     // Handle preflight OPTIONS request
//     if c.Request.Method == http.MethodOptions {
//         c.JSON(http.StatusOK, nil)
//         return
//     }

//     // Check for valid GET request
//     if c.Request.Method != http.MethodGet {
//         c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
//         return
//     }

//     // Get parameters from query
//     userlevel := c.Query("userlevel")
//     lessonlevel := c.Query("lessonlevel")
//     orgid := c.Query("orgid")

//     // Validate parameters
//     if userlevel == "" || lessonlevel == "" || orgid == "" {
//         c.JSON(http.StatusBadRequest, gin.H{"error": "All parameters (userlevel, lessonlevel, orgid) are required"})
//         return
//     }

//     // Connect to the database
//     db, err := GetDBConnection()
//     if err != nil {
//         log.Printf("Error connecting to the database: %v", err)
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Error connecting to the database"})
//         return
//     }
//     defer db.Close()

//     // Prepare the SQL query
//     query := `SELECT answer FROM testdata WHERE UserLevel=? AND LessonLevel=? AND OrganisationId=?`
//     var answer sql.NullString

//     // Execute the query with the correct parameters
//     err = db.QueryRow(query, userlevel, lessonlevel, orgid).Scan(&answer)
//     if err != nil {
//         log.Printf("Error executing query: %v", err)
//         if err == sql.ErrNoRows {
//             c.JSON(http.StatusNotFound, gin.H{"error": "No data found for the provided parameters"})
//         } else {
//             c.JSON(http.StatusInternalServerError, gin.H{"error": "Error executing query"})
//         }
//         return
//     }

//     // Check if we got a valid answer
//     if answer.Valid {
//         log.Printf("Retrieved answer: %s", answer.String)
//         c.JSON(http.StatusOK, gin.H{"answer": answer.String}) // Return as JSON
//     } else {
//         log.Printf("No data found for the provided parameters: UserLevel: %s, LessonLevel: %s, OrganisationId: %s", userlevel, lessonlevel, orgid)
//         c.JSON(http.StatusNotFound, gin.H{"error": "No data found"})
//     }
// // }
// func FetchVocabularyTestQuestion(c *gin.Context) {
//     // Set CORS headers
//     c.Header("Access-Control-Allow-Origin", "*")
//     c.Header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
//     c.Header("Access-Control-Allow-Headers", "Content-Type")

//     // Handle preflight OPTIONS request
//     if c.Request.Method == http.MethodOptions {
//         c.JSON(http.StatusOK, nil)
//         return
//     }

//     // Check for valid GET request
//     if c.Request.Method != http.MethodGet {
//         c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
//         return
//     }

//     // Get parameters from query
//     userlevel := c.Query("userlevel")
//     lessonlevel := c.Query("lessonlevel")
//     orgid := c.Query("orgid")

//     // Validate parameters
//     if userlevel == "" || lessonlevel == "" || orgid == "" {
//         c.JSON(http.StatusBadRequest, gin.H{"error": "All parameters (userlevel, lessonlevel, orgid) are required"})
//         return
//     }

//     // Connect to the database
//     db, err := GetDBConnection()
//     if err != nil {
//         log.Printf("Error connecting to the database: %v", err)
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Error connecting to the database"})
//         return
//     }
//     defer db.Close()

//     // Prepare the SQL query
//     query := `SELECT answer FROM testdata WHERE UserLevel=? AND LessonLevel=? AND OrganisationId=?`
//     var answer sql.NullString

//     // Log the values before executing the query
//     log.Printf("Querying with UserLevel: %s, LessonLevel: %s, OrganisationId: %s", userlevel, lessonlevel, orgid)

//     // Execute the query with the correct parameters
//     err = db.QueryRow(query, userlevel, lessonlevel, orgid).Scan(&answer)
//     if err != nil {
//         log.Printf("Error executing query: %v", err)
//         if err == sql.ErrNoRows {
//             c.JSON(http.StatusNotFound, gin.H{"error": "No data found for the provided parameters"})
//         } else {
//             c.JSON(http.StatusInternalServerError, gin.H{"error": "Error executing query"})
//         }
//         return
//     }

//     // Check if we got a valid answer
//     if answer.Valid {
//         log.Printf("Retrieved answer: %s", answer.String)
//         c.JSON(http.StatusOK, gin.H{"answer": answer.String}) // Return as JSON
//     } else {
//         log.Printf("No data found for the provided parameters: UserLevel: %s, LessonLevel: %s, OrganisationId: %s", userlevel, lessonlevel, orgid)
//         c.JSON(http.StatusNotFound, gin.H{"error": "No data found"})
//     }
// }
// func FetchVocabularyTestQuestion(c *gin.Context) {
//     // Set CORS headers
//     c.Header("Access-Control-Allow-Origin", "*")
//     c.Header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
//     c.Header("Access-Control-Allow-Headers", "Content-Type")

//     // Handle preflight OPTIONS request
//     if c.Request.Method == http.MethodOptions {
//         c.JSON(http.StatusOK, nil)
//         return
//     }

//     // Check for valid GET request
//     if c.Request.Method != http.MethodGet {
//         c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
//         return
//     }

//     // Get parameters from query
//     userlevel := c.Query("userlevel")
//     lessonlevel := c.Query("lessonlevel")
//     orgid := c.Query("orgid")

//     // Validate parameters
//     if userlevel == "" || lessonlevel == "" || orgid == "" {
//         c.JSON(http.StatusBadRequest, gin.H{"error": "All parameters (userlevel, lessonlevel, orgid) are required"})
//         return
//     }

//     // Connect to the database
//     db, err := GetDBConnection()
//     if err != nil {
//         log.Printf("Error connecting to the database: %v", err)
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Error connecting to the database"})
//         return
//     }
//     defer db.Close()

//     // Prepare the SQL query with LIMIT and ORDER BY RAND() to fetch random records
//     query := `SELECT answer FROM testdata WHERE UserLevel=? AND LessonLevel=? AND OrganisationId=? ORDER BY RAND() LIMIT 10`
//     rows, err := db.Query(query, userlevel, lessonlevel, orgid)
//     if err != nil {
//         log.Printf("Error executing query: %v", err)
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Error executing query"})
//         return
//     }
//     defer rows.Close()

//     // Create a slice to hold the answers
//     var answers []string
//     for rows.Next() {
//         var answer sql.NullString
//         if err := rows.Scan(&answer); err != nil {
//             log.Printf("Error scanning row: %v", err)
//             continue
//         }
//         if answer.Valid {
//             answers = append(answers, answer.String)
//         }
//     }

//     // Check if we have any valid answers
//     if len(answers) == 0 {
//         c.JSON(http.StatusNotFound, gin.H{"error": "No data found for the provided parameters"})
//         return
//     }

//     // Return the answers as JSON
//     c.JSON(http.StatusOK, gin.H{"answers": answers})
// }

// func // FetchTestQuestions handler to fetch random test questions
// FetchTestQuestions handler to fetch random test questions
func FetchVocabularyTestQuestion(c *gin.Context) {
    // Set CORS headers
	c.Header("Access-Control-Allow-Origin", "*")
    c.Header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
    c.Header("Access-Control-Allow-Headers", "Content-Type")

    if c.Request.Method == http.MethodOptions {
        c.JSON(http.StatusOK, nil)
        return
    }

    // Retrieve parameters from the query
    userlevel := c.Query("userlevel")
    lessonlevel := c.Query("lessonlevel")
    orgid := c.Query("orgid")

    // Validate parameters
    if userlevel == "" || lessonlevel == "" || orgid == "" {
        c.JSON(http.StatusBadRequest, gin.H{"error": "All parameters (userlevel, lessonlevel, orgid) are required"})
        return
    }

    // Connect to the database
    db, err := GetDBConnection()
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Error connecting to the database"})
        return
    }
    defer db.Close()

    // Query to get the answer column from the testdata table
    var jsonData string
    err = db.QueryRow("SELECT answer FROM testdata WHERE UserLevel=? AND LessonLevel=? AND OrganisationId=?", userlevel, lessonlevel, orgid).Scan(&jsonData)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Error executing query"})
        return
    }

    // Parse the JSON data
    var questions []EntryLevelQuestion
    err = json.Unmarshal([]byte(jsonData), &questions)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Error parsing JSON"})
        return
    }

    // Get a random subset of questions
    randomQuestions := getRandomSubset1(questions, 10)

    // Send the response
    c.JSON(http.StatusOK, randomQuestions)
}

// getRandomSubset returns a random subset of questions
func getRandomSubset1(data []EntryLevelQuestion, subsetSize int) []EntryLevelQuestion {
    rand.Seed(time.Now().UnixNano())

    // Shuffle the data
    rand.Shuffle(len(data), func(i, j int) {
        data[i], data[j] = data[j], data[i]
    })

    // Limit the size of the returned subset
    if subsetSize > len(data) {
        subsetSize = len(data)
    }
    
    return data[:subsetSize]
}

// func SaveTestScore(c *gin.Context) {
//     // Set CORS headers
//     c.Header("Access-Control-Allow-Origin", "*")
//     c.Header("Access-Control-Allow-Methods", "POST, OPTIONS")
//     c.Header("Access-Control-Allow-Headers", "Content-Type")

//     // Handle preflight OPTIONS request
//     if c.Request.Method == http.MethodOptions {
//         c.JSON(http.StatusOK, nil)
//         return
//     }

//     // Check for valid POST request
//     if c.Request.Method != http.MethodPost {
//         c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
//         return
//     }

//     // Parse the JSON body
//     var scoreData struct {
//         Level   string `json:"level"`
//         UserID  string `json:"userid"`
//         Score   int    `json:"score"`
//     }

//     if err := c.ShouldBindJSON(&scoreData); err != nil {
//         c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request body"})
//         return
//     }

//     // Validate parameters
//     if scoreData.Level == "" || scoreData.UserID == "" {
//         c.JSON(http.StatusBadRequest, gin.H{"error": "Level and UserID are required"})
//         return
//     }

//     // Connect to the database
//     db, err := GetDBConnection()
//     if err != nil {
//         log.Printf("Error connecting to the database: %v", err)
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Error connecting to the database"})
//         return
//     }
//     defer db.Close()

//     // Prepare the SQL query to insert the score
//     query := `INSERT INTO testscore (level, userid) VALUES (?, ?)`
//     _, err = db.Exec(query, scoreData.Level, scoreData.UserID)
//     if err != nil {
//         log.Printf("Error inserting score: %v", err)
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Error inserting score"})
//         return
//     }

//     // Respond with a success message
//     c.JSON(http.StatusOK, gin.H{"message": "Score saved successfully"})
// }
func SaveTestScore(c *gin.Context) {
    // Set CORS headers
    c.Header("Access-Control-Allow-Origin", "*")
    c.Header("Access-Control-Allow-Methods", "POST, OPTIONS")
    c.Header("Access-Control-Allow-Headers", "Content-Type")

    // Handle preflight OPTIONS request
    if c.Request.Method == http.MethodOptions {
        c.JSON(http.StatusOK, nil)
        return
    }

    // Check for valid POST request
    if c.Request.Method != http.MethodPost {
        c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
        return
    }

    // Parse the JSON body
    var scoreData struct {
        Level  string `json:"level"`
        UserID string `json:"userid"`
    }

    if err := c.ShouldBindJSON(&scoreData); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request body"})
        return
    }

    // Validate parameters
    if scoreData.Level == "" || scoreData.UserID == "" {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Level and UserID are required"})
        return
    }

    // Connect to the database
    db, err := GetDBConnection()
    if err != nil {
        log.Printf("Error connecting to the database: %v", err)
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Error connecting to the database"})
        return
    }
    defer db.Close()

    // Prepare the SQL query to insert the score
    query := `INSERT INTO testscore (level, userid,CreatedTime,UpdatedTime) VALUES (?, ?,Now(),Now())`
    _, err = db.Exec(query, scoreData.Level, scoreData.UserID)
    if err != nil {
        log.Printf("Error inserting score: %v", err)
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Error inserting score"})
        return
    }

    // Respond with a success message
    c.JSON(http.StatusOK, gin.H{"message": "Score saved successfully"})
}


// func SaveVocabularyQuestion(c *gin.Context) {
// 	fmt.Println("Starting SaveVocabularyQuestion")

// 	c.Header("Access-Control-Allow-Origin", "*")
// 	c.Header("Access-Control-Allow-Methods", "GET, POST, PUT, OPTIONS")
// 	c.Header("Access-Control-Allow-Headers", "Content-Type")
	
// 	if c.Request.Method == http.MethodOptions {
// 		c.JSON(http.StatusOK, nil)
// 		return
// 	}

// 	if c.Request.Method != http.MethodPost {
// 		c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
// 		return
// 	}

// 	var vocabulary VocabularyData
// 	if err := c.ShouldBindJSON(&vocabulary); err != nil {
// 		c.JSON(http.StatusBadRequest, gin.H{"error": "Error decoding JSON"})
// 		return
// 	}

// 	db, err := GetDBConnection()
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
// 		return
// 	}
// 	defer db.Close()

// 	// Convert the vocabulary data to JSON
// 	datasJSON, err := json.Marshal(vocabulary.Datas)
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error converting to JSON"})
// 		return
// 	}

// 	query := `
// 		INSERT INTO testdata (LessonLevel, UserLevel, datas, CreatedBy, CreatedTime, UpdatedBy, UpdatedTime, isDeleted)
// 		VALUES (?, ?, ?, ?, NOW(), ?, NOW(), 0)`

// 	_, err = db.Exec(query, vocabulary.LessonLevel, vocabulary.UserLevel, string(datasJSON), vocabulary.CreatedBy, vocabulary.CreatedBy)
// 	if err != nil {
// 		fmt.Printf("Error executing query: %v\n", err)
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to execute the query"})
// 		return
// 	}

// 	c.JSON(http.StatusOK, gin.H{"message": "Lesson stored successfully"})
// }


func SaveVocabularyQuestion(c *gin.Context) {
	fmt.Println("Starting SaveVocabularyQuestion")

	c.Header("Access-Control-Allow-Origin", "*")
	c.Header("Access-Control-Allow-Methods", "GET, POST, PUT, OPTIONS")
	c.Header("Access-Control-Allow-Headers", "Content-Type")

	if c.Request.Method == http.MethodOptions {
		c.JSON(http.StatusOK, nil)
		return
	}

	if c.Request.Method != http.MethodPost {
		c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
		return
	}

	var vocabulary VocabularyData
	if err := c.ShouldBindJSON(&vocabulary); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Error decoding JSON"})
		return
	}

	db, err := GetDBConnection()
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

	query := `
		INSERT INTO testdata (LessonLevel, UserLevel,OrganisationId, datas, CreatedBy, CreatedTime, UpdatedBy, UpdatedTime, isDeleted)
		VALUES (?, ?, ?, ?,?, NOW(), ?, NOW(), 0)`

	_, err = db.Exec(query, vocabulary.LessonLevel, vocabulary.UserLevel,vocabulary.OrganisationID, string(datasJSON), vocabulary.CreatedBy, vocabulary.CreatedBy)
	if err != nil {
		fmt.Printf("Error executing query: %v\n", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to execute the query"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Lesson stored successfully"})
}

func FetchVocabularyQuestion(c *gin.Context) {

	fmt.Println("Starting FetchVocabularyQuestion")

	// Set CORS headers for preflight requests
	c.Header("Access-Control-Allow-Origin", "*")
	c.Header("Access-Control-Allow-Methods", "GET, POST, PUT, OPTIONS")
	c.Header("Access-Control-Allow-Headers", "Content-Type")

	// Handle OPTIONS request for CORS preflight
	if c.Request.Method == http.MethodOptions {
		c.JSON(http.StatusOK, nil)
		return
	}

	// Ensure the request method is GET
	if c.Request.Method != http.MethodGet {
		c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
		return
	}

	// Establish database connection
	db, err := GetDBConnection()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
		return
	}
	defer db.Close()

	// Get query parameters
	lessonLevel := c.Query("LessonLevel")
	userLevel := c.Query("UserLevel")
	organisationId := c.Query("OrganisationId")

	// Validate query parameters
	if lessonLevel == "" || userLevel == "" || organisationId == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "LessonLevel, UserLevel, and OrganisationId are required"})
		return
	}

	// SQL query to fetch data based on parameters
	query := "SELECT lesson FROM testdata WHERE LessonLevel = ? AND UserLevel = ? AND OrganisationId = ?"

	// Execute the query
	var datasJSON string
	err = db.QueryRow(query, lessonLevel, userLevel, organisationId).Scan(&datasJSON)
	if err != nil {
		if err == sql.ErrNoRows {
			c.JSON(http.StatusNotFound, gin.H{"error": "No data found"})
			return
		}
		fmt.Printf("Error executing query: %v\n", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to execute the query"})
		return
	}

	// Unmarshal JSON string into a Go struct or map
	var datas interface{}
	if err := json.Unmarshal([]byte(datasJSON), &datas); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error decoding JSON"})
		return
	}

	// Return the fetched data
	c.JSON(http.StatusOK, gin.H{"datas": datas})
}


func savewords(c *gin.Context) {

	fmt.Println("Starting DefaultVocabularyLevel")

	// c.Header("Access-Control-Allow-Origin", "*")
	// c.Header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
	// c.Header("Access-Control-Allow-Headers", "Content-Type")

	if c.Request.Method == http.MethodOptions {
		c.JSON(http.StatusOK, nil)
		return
	}

	if c.Request.Method != http.MethodGet && c.Request.Method != http.MethodPost {
		c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
		return
	}

	db, err := GetDBConnection()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
		return
	}
	defer db.Close()
}



func AddWords(db *sql.DB, words structure.AddWords) (string, error) {
	// Fetch existing MyWords for the given UserId
	var existingWordsJSON string
	err := db.QueryRow("SELECT MyWords FROM userdata WHERE UserId = ?", words.ID).Scan(&existingWordsJSON)

	if err != nil && err != sql.ErrNoRows {
		return "", fmt.Errorf("failed to fetch existing words: %v", err)
	}

	// Initialize existingWords as an empty slice if no existing data
	var existingWords []structure.WordEntry
	if existingWordsJSON != "" {
		if err := json.Unmarshal([]byte(existingWordsJSON), &existingWords); err != nil {
			return "", fmt.Errorf("failed to unmarshal existing words: %v", err)
		}
	}

	// Append new words to existing words
	existingWords = append(existingWords, words.MyWords...)

	// Convert updated words back to JSON
	updatedWordsJSON, err := json.Marshal(existingWords)
	if err != nil {
		return "", fmt.Errorf("failed to marshal updated words: %v", err)
	}

	// Update the existing record with the new JSON data
	_, err = db.Exec(
		"UPDATE userdata SET MyWords = ?,UpdatedTime=Now() WHERE UserId = ?",
		updatedWordsJSON,
		words.ID,
	)

	if err != nil {
		return "", fmt.Errorf("failed to update MyWords: %v", err) // Return error message
	}

	return "Words updated successfully", nil // Return success message
}


// func FetchVocabulary(db *sql.DB, structData structure.Fetchvocabulary) ([]structure.WordEntry, error) {
// 	var existingWordsJSON string
// 	// Fetch MyWords for the given UserId
// 	err := db.QueryRow("SELECT MyWords FROM userdata WHERE UserId = ?", structData.ID).Scan(&existingWordsJSON)

// 	if err != nil {
// 		if err == sql.ErrNoRows {
// 			return nil, nil // Return nil if no words are found for the user
// 		}
// 		return nil, fmt.Errorf("failed to fetch existing words: %v", err)
// 	}

// 	// Unmarshal the JSON string into a slice of WordEntry
// 	var existingWords []structure.WordEntry
// 	if err := json.Unmarshal([]byte(existingWordsJSON), &existingWords); err != nil {
// 		return nil, fmt.Errorf("failed to unmarshal existing words: %v", err)
// 	}

// 	return existingWords, nil // Return the list of words
// }

func FetchVocabulary(db *sql.DB, structData structure.Fetchvocabulary) ([]structure.WordEntry, error) {
    var existingWordsJSON string
    // Fetch MyWords for the given UserId
    err := db.QueryRow("SELECT MyWords FROM userdata WHERE UserId = ?", structData.ID).Scan(&existingWordsJSON)

    if err != nil {
        if err == sql.ErrNoRows {
            return nil, nil // Return nil if no words are found for the user
        }
        return nil, fmt.Errorf("failed to fetch existing words: %v", err)
    }

    // Unmarshal the JSON string into a slice of WordEntry
    var existingWords []structure.WordEntry
    if err := json.Unmarshal([]byte(existingWordsJSON), &existingWords); err != nil {
        return nil, fmt.Errorf("failed to unmarshal existing words: %v", err)
    }

    return existingWords, nil // Return the list of words
}



