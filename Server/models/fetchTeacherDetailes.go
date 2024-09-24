
// package models

// import (
// 	"database/sql"
// 	"fmt"
// 	"log"
// 	"net/http"

// 	"github.com/gin-gonic/gin"
// 	_ "github.com/go-sql-driver/mysql"
// )

// type Teacher struct {
// 	Name           string  `json:"name"`
// 	Email          string  `json:"email"`
// 	RegisterNumber string  `json:"registernumber"`
// 	CreatedTime      string  `json:"createdtime"`
// 	Class          *string `json:"class"`  // Use a pointer to handle NULL values
// }

// func TeachersDatas(c *gin.Context) {
// 	fmt.Print("Starting TeachersData\n")

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

// 	// Connect to the database
// 	db, err := GetDBConnection()
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
// 		return
// 	}
// 	defer db.Close()

// 	// Query to select teacher data
// 	query := `SELECT Name, EmailId, RegisterNumber, CreatedTime, Class FROM user WHERE Role='Teacher' AND CreatedBy=`

// 	data, err := db.Query(query)
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


package models

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
)


type Teacher struct {
	ID int `json:"id"`
	Name           string  `json:"name"`
	Email          string  `json:"email"`
	RegisterNumber string  `json:"registernumber"`
	CreatedTime      string  `json:"createdtime"`
	Class          *string `json:"class"`  // Use a pointer to handle NULL values
}
func 	TeachersDatas(c *gin.Context) {
	fmt.Println("Starting TeachersData")

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

	// Get createdBy parameter from the request query
	createdBy := c.Query("createdBy")
	if createdBy == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "CreatedBy (email) is required"})
		return
	}

	// Connect to the database
	db, err := GetDBConnection()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
		return
	}
	defer db.Close()

	// Query to select teacher data filtered by CreatedBy (email) and Role
	query := `SELECT ID,Name, EmailId, RegisterNumber, CreatedTime, Class FROM user WHERE Role='Teacher' AND CreatedBy = ? AND IsDeleted=0`

	data, err := db.Query(query, createdBy)
	if err != nil {
		log.Printf("Failed to retrieve the data: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data"})
		return
	}
	defer data.Close()

	var teachers []Teacher

	// Iterate over data and scan the results into a slice of Teacher structs
	for data.Next() {
		var teacher Teacher
		var class sql.NullString // Use sql.NullString to handle possible NULL values

		// Scan data and handle NULL values for Class
		err := data.Scan(&teacher.ID,&teacher.Name, &teacher.Email, &teacher.RegisterNumber, &teacher.CreatedTime, &class)
		if err != nil {
			log.Printf("Failed to scan row: %v", err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse data"})
			return
		}

		// Assign Class value: If valid, set the pointer; otherwise, leave it nil
		if class.Valid {
			teacher.Class = &class.String
		} else {
			teacher.Class = nil
		}

		teachers = append(teachers, teacher)
		fmt.Print(teachers)
	}

	// Check for any row scanning errors
	if err := data.Err(); err != nil {
		log.Printf("Row iteration error: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error iterating over data"})
		return
	}

	// Respond with the retrieved data
	c.JSON(http.StatusOK, teachers)
}

// func TeachersDatas(c *gin.Context) {
// 	fmt.Print("Starting TeachersData\n")

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

// 	// Get email parameter from the request query
// 	// createdByEmail := c.Query("email")
// 	// if createdByEmail == "" {
// 	// 	c.JSON(http.StatusBadRequest, gin.H{"error": "Email is required"})
// 	// 	return
// 	// }

// 	// Connect to the database
// 	db, err := GetDBConnection()
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
// 		return
// 	}
// 	defer db.Close()

// 	// Query to select teacher data filtered by CreatedBy (email)
// 	query := `SELECT Name, EmailId, RegisterNumber, CreatedTime, Class FROM user WHERE Role='Teacher' AND CreatedBy = 'org3@edu.com'`

// 	data, err := db.Query(query)
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
