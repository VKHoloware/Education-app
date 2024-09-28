package models

import (
	// "database/sql"
	"database/sql"
	"fmt"
	"structure"

	// "log"
	// "net/http"

	// "github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
)

// type Student struct {
// 	Name           string  `json:"name"`
// 	Email          string  `json:"email"`
// 	RegisterNumber string  `json:"registernumber"`
// 	CreatedTime      string  `json:"createdtime"`
// 	// Class          *string `json:"class"`  // Use a pointer to handle NULL values
// 	EnglishProficiency *string `json:"englishproficiency"` // Pointer to handle NULL values

// }


func GetStudentData(db *sql.DB, createdBy string) ([]structure.Student, error) {
	query := `SELECT Name, EmailId, RegisterNumber, CreatedTime, EnglishProficency FROM user WHERE Role='Student' AND CreatedBy = ?`

	data, err := db.Query(query, createdBy)
	if err != nil {
		return nil, fmt.Errorf("failed to Retirve Data from DB: %v", err)
	}
	defer data.Close()

	var students []structure.Student
	for data.Next() {
		var student structure.Student
		var englishProficiency sql.NullString

		err := data.Scan(&student.Name, &student.Email, &student.RegisterNumber, &student.CreatedTime, &englishProficiency)
		if err != nil {
			return nil, fmt.Errorf("failed to scan row: %v", err)
		}

		if englishProficiency.Valid {
			student.EnglishProficiency = &englishProficiency.String
		} else {
			student.EnglishProficiency = nil
		}

		students = append(students, student)
	}

	if err := data.Err(); err != nil {
		return nil, fmt.Errorf("row iteration error: %v", err)
	}

	return students, nil
}







// func StudentDatas(c *gin.Context) {
// 	fmt.Println("Starting TeachersData")

// 	// Handle CORS for preflight requests
// 	c.Header("Access-Control-Allow-Origin", "*")
// 	c.Header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
// 	c.Header("Access-Control-Allow-Headers", "Content-Type")

// 	if c.Request.Method == http.MethodOptions {
// 		c.JSON(http.StatusOK, nil)
// 		return
// 	}

// 	// Now allow both GET and POST methods (if necessary)
// 	if c.Request.Method != http.MethodGet && c.Request.Method != http.MethodPost {
// 		c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
// 		return
// 	}

// 	// Get createdBy parameter from the request query
// 	createdBy := c.Query("createdBy")
// 	if createdBy == "" {
// 		c.JSON(http.StatusBadRequest, gin.H{"error": "CreatedBy (email) is required"})
// 		return
// 	}

// 	// Connect to the database
// 	db, err := GetDBConnection()
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
// 		return
// 	}
// 	defer db.Close()

// 	// Query to select teacher data filtered by CreatedBy (email) and Role
// 	query := `SELECT Name, EmailId, RegisterNumber, CreatedTime, EnglishProficency FROM user WHERE Role='Student' AND CreatedBy = ?`

// 	data, err := db.Query(query, createdBy)
// 	if err != nil {
// 		log.Printf("Failed to retrieve the data: %v", err)
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data"})
// 		return
// 	}
// 	defer data.Close()

// 	var teachers []Teacher

// 	// Iterate over data and scan the results into a slice of Teacher structs
// 	for data.Next() {
// 		var teacher Teacher
// 		// var class sql.NullString // Use sql.NullString to handle possible NULL values

// 		// Scan data and handle NULL values for Class
// 		err := data.Scan(&teacher.Name, &teacher.Email, &teacher.RegisterNumber, &teacher.CreatedTime )   //&class
// 		if err != nil {
// 			log.Printf("Failed to scan row: %v", err)
// 			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse data"})
// 			return
// 		}

// 		// Assign Class value: If valid, set the pointer; otherwise, leave it nil
// 		// if class.Valid {
// 		// 	teacher.Class = &class.String
// 		// } else {
// 		// 	teacher.Class = nil
// 		// }

// 		teachers = append(teachers, teacher)
// 	}

// 	// Check for any row scanning errors
// 	if err := data.Err(); err != nil {
// 		log.Printf("Row iteration error: %v", err)
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error iterating over data"})
// 		return
// 	}

// 	// Respond with the retrieved data
// 	c.JSON(http.StatusOK, teachers)
// }


// Ensure that the Teacher struct matches your database fields
// type Student struct {
// 	Name             string  `json:"name"`
// 	Email            string  `json:"email"`
// 	RegisterNumber   string  `json:"registernumber"`
// 	CreatedTime      string  `json:"createdtime"`
// 	EnglishProficiency *string `json:"englishproficiency"` // Pointer to handle NULL values
// }

// func StudentDatas(c *gin.Context) {
// 	fmt.Println("Starting StudentData")

// 	// Handle CORS for preflight requests
// 	c.Header("Access-Control-Allow-Origin", "*")
// 	c.Header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
// 	c.Header("Access-Control-Allow-Headers", "Content-Type")

// 	if c.Request.Method == http.MethodOptions {
// 		c.JSON(http.StatusOK, nil)
// 		return
// 	}

// 	if c.Request.Method != http.MethodGet && c.Request.Method != http.MethodPost {
// 		c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
// 		return
// 	}

// 	createdBy := c.Query("createdBy")
// 	if createdBy == "" {
// 		c.JSON(http.StatusBadRequest, gin.H{"error": "CreatedBy (email) is required"})
// 		return
// 	}

// 	db, err := GetDBConnection()
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
// 		return
// 	}
// 	defer db.Close()

// 	// Corrected SQL query
// 	query := `SELECT Name, EmailId, RegisterNumber, CreatedTime, EnglishProficency FROM user WHERE Role='Student' AND CreatedBy = ?`

// 	data, err := db.Query(query, createdBy)
// 	if err != nil {
// 		log.Printf("Failed to retrieve the data: %v", err)
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data"})
// 		return
// 	}
// 	defer data.Close()

// 	var students []Student

// 	for data.Next() {
// 		var student Student
// 		var englishProficiency sql.NullString // Use sql.NullString to handle possible NULL values

// 		err := data.Scan(&student.Name, &student.Email, &student.RegisterNumber, &student.CreatedTime, &englishProficiency)
// 		if err != nil {
// 			log.Printf("Failed to scan row: %v", err)
// 			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse data"})
// 			return
// 		}

// 		// Assign EnglishProficiency value: If valid, set the pointer; otherwise, leave it nil
// 		if englishProficiency.Valid {
// 			student.EnglishProficiency = &englishProficiency.String
// 		} else {
// 			student.EnglishProficiency = nil
// 		}

// 		students = append(students, student)
// 	}

// 	if err := data.Err(); err != nil {
// 		log.Printf("Row iteration error: %v", err)
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error iterating over data"})
// 		return
// 	}

// 	c.JSON(http.StatusOK, students)
// }


// func StudentDatas(c *gin.Context) {
// 	fmt.Print("Starting TeachersData\n")

// 	// Handle CORS for preflight requests
// 	c.Header("Access-Control-Allow-Origin", "*")
// 	c.Header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
// 	c.Header("Access-Control-Allow-Headers", "Content-Type")

// 	if c.Request.Method == http.MethodOptions {
// 		c.JSON(http.StatusOK, nil)
// 		return
// 	}

// 	if c.Request.Method != http.MethodGet && c.Request.Method != http.MethodPost {
// 		c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
// 		return
// 	}

// 	// Connect to the database
// 	db, err := GetDBConnection()
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
// 		return
// 	}
// 	defer db.Close()

// 	// Query to select teacher data
// 	query := `SELECT Name, EmailId, RegisterNumber, CreatedTime, Class FROM user WHERE Role='Student'`

// 	data, err := db.Query(query)
// 	if err != nil {
// 		log.Printf("Failed to retrieve the data: %v", err)
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data"})
// 		return
// 	}
// 	defer data.Close()

// 	var teachers []Student

// 	// Iterate over data and scan the results into a slice of Teacher structs
// 	for data.Next() {
// 		var teacher Student
// 		var class sql.NullString // Use sql.NullString to handle possible NULL values

// 		// Scan data and handle NULL values for Class
// 		err := data.Scan(&teacher.Name, &teacher.Email, &teacher.RegisterNumber, &teacher.CreatedTime, &class)
// 		if err != nil {
// 			log.Printf("Failed to scan row: %v", err)
// 			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse data"})
// 			return
// 		}

// 		// Assign Class value: If valid, set the pointer; otherwise, leave it nil
// 		if class.Valid {
// 			teacher.Class = &class.String
// 		} else {
// 			teacher.Class = nil
// 		}

// 		teachers = append(teachers, teacher)
// 	}

// 	// Check for any row scanning errors
// 	if err := data.Err(); err != nil {
// 		log.Printf("Row iteration error: %v", err)
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error iterating over data"})
// 		return
// 	}

// 	// Respond with the retrieved data
// 	c.JSON(http.StatusOK, teachers)
// }