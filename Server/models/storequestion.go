package models

import (
	// "database/sql"
	"database/sql"
	"encoding/json"
	"fmt"

	// "fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"

	_ "github.com/go-sql-driver/mysql"
)
			

			type UserData struct {
				Learn   []map[string]string `json:"learn"`
				Test    []map[string]string `json:"test"`
				Email   string              `json:"email"`
				Age     int                 `json:"age"`
				Teacher int                 `json:"Teacher"`
			}

			type Question struct {
				StudentID string      `json:"studentid"`  // Change to int
				Data      UserData `json:"datas"`
						TeacherID int      `json:"teacherid"`
			}
			type Data struct {
				ID   string    `json:"id"`
				Name string `json:"name"`
			}
			

				// type SaveLesson struct{
				// ID int `json:"id"`
				// ClassLevel string `json:"class"`
				// LessonName string `json:"lesson"`
				// QuestionAnswer map[string]interface{} `json:"questionanswer"`
				// TestTime string `json:"testtime"`
				// CreatedBy string `json:"createdby"`
				// TeacherID int `json:"teacherid"`

				// }
				// type SaveLesson struct {
				// 	ID             int                    `json:"id"`
				// 	ClassLevel     string                 `json:"class"`
				// 	LessonName     string                 `json:"lesson"`
				// 	QuestionAnswer map[string]interface{} `json:"questionanswer"`
				// 	TestTime       string                 `json:"testtime"`
				// 	TestDuration int `json:"duration"`
				// 	Resultdate string `json:"resultdate"`
				// 	CreatedBy      string                 `json:"createdby"`
				// 	TeacherID      int                    `json:"teacherid"`

				// }
				type SaveLesson struct {
					ID           int                    `json:"id"`
					ClassLevel        string                 `json:"class"`
					LessonName       string                 `json:"lesson"`
					TestTime     string                 `json:"testtime"`
					TestDuration     int                    `json:"duration"`
					Resultdate   string                 `json:"resultdate"`
					CreatedBy    string                 `json:"createdby"`
					QuestionAnswer map[string]interface{} `json:"questionanswer"`
					TeacherID    int                    `json:"teacherid"` // Ensure this is int
				}
				
			type ScoreData struct {
				UserID int `json:"user_id"`
				Score  int `json:"score"`
			}
			func SaveToDatabase(c *gin.Context) {
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
			
				// Connect to the database
				db, err := GetDBConnection()
				if err != nil {
					c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
					return
				}
				defer db.Close()
			
				var payload Question
				if err := c.ShouldBindJSON(&payload); err != nil {
					c.JSON(http.StatusBadRequest, gin.H{"error": "Error decoding JSON"})
					return
				}
			
				// Convert UserData to JSON format to store in the JSON column
				jsonData, err := json.Marshal(payload.Data)
				if err != nil {
					c.JSON(http.StatusInternalServerError, gin.H{"error": "Error marshalling JSON"})
					return
				}
			
				// Insert data into the table with a JSON column
				query := `INSERT INTO testdata (Class, lesson, Teacher) VALUES (?, ?, ?)`
				_, err = db.Exec(query, payload.StudentID, jsonData, payload.TeacherID)
				if err != nil {
					c.JSON(http.StatusInternalServerError, gin.H{"error": "Error executing query"})
					return
				}
			
				// Send a success response
				c.JSON(http.StatusOK, gin.H{"message": "Data saved successfully"})
			}




func GetQA(c *gin.Context) {
    c.Header("Access-Control-Allow-Origin", "*")
    c.Header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
    c.Header("Access-Control-Allow-Headers", "Content-Type")

    if c.Request.Method == http.MethodOptions {
        c.JSON(http.StatusOK, nil)
        return
    }

    if c.Request.Method != http.MethodGet {
        c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
        return
    }

    // Get ID from query parameters
    id := c.Query("id")
    if id == "" {
        c.JSON(http.StatusBadRequest, gin.H{"error": "ID parameter is required"})
        return
    }

    // Connect to the database
    db, err := GetDBConnection()
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Error connecting to the database"})
        return
    }
    defer db.Close()

    query := `SELECT lesson FROM testdata WHERE Class=?`

    // Execute the query
    var jsonData sql.NullString
    err = db.QueryRow(query, id).Scan(&jsonData)
    if err != nil {
        log.Printf("Error executing query: %v", err)
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Error executing query"})
        return
    }

    // Log the raw JSON data for debugging
    if jsonData.Valid {
        log.Printf("Retrieved JSON data: %s", jsonData.String)
        c.Data(http.StatusOK, "application/json", []byte(jsonData.String))
    } else {
        log.Printf("No data found for ID: %s", id)
        c.JSON(http.StatusNotFound, gin.H{"error": "No data found"})
    }
}
func SaveLessonData(c *gin.Context) {
	c.Header("Access-Control-Allow-Origin", "*")
	c.Header("Access-Control-Allow-Methods", "POST, GET, OPTIONS")
	c.Header("Access-Control-Allow-Headers", "Content-Type")

	if c.Request.Method == http.MethodOptions {
		c.JSON(http.StatusOK, nil)
		return
	}
	if c.Request.Method != http.MethodPost {
		c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Method Not Allowed"})
		return
	}

	db, err := GetDBConnection()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Did Not Connect to the DataBase"})
		return
	}
	defer db.Close()

	var savelesson SaveLesson
	if err := c.ShouldBindJSON(&savelesson); err != nil {
		fmt.Print(err)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid Bad Request"})
		return
	}

	// Serialize the QuestionAnswer field
	questionAnswerJSON, err := json.Marshal(savelesson.QuestionAnswer)
	if err != nil {
		fmt.Print(err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to serialize QuestionAnswer"})
		return
	}

	// Debugging prints
	fmt.Printf("LessonName: %s\n", savelesson.LessonName)
	fmt.Printf("TeacherID: %d\n", savelesson.TeacherID)

	query := `
		INSERT INTO lesson 
		(Class, TeacherID, Lesson, QuestionAnswer, TestDate,TestDuration,ResultDate,CreatedBy, CreatedTime, UpdatedTime, UpdatedBy) 
		VALUES (?, ?, ?, ?, ?, ?, ?,?,NOW(), NOW(), ?)
	`

	_, err = db.Exec(query, savelesson.ClassLevel, savelesson.TeacherID, savelesson.LessonName, questionAnswerJSON, savelesson.TestTime, savelesson.TestDuration,savelesson.Resultdate,savelesson.CreatedBy, savelesson.CreatedBy)

	if err != nil {
		fmt.Printf("Error executing query: %v\n", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to execute the query"})
		return
	}

	c.JSON(http.StatusOK, "Lesson Stored Successfully")
}


	// func SaveLessonData(c *gin.Context){

	// 		c.Header("Access-Control-Allow-Orgin","*")
	// 		c.Header("Access-Control-Allow-Methods","POST,GET,OPTIONS")
	// 		c.Header("Access-Control-Allow-Headers","Content-Type")

	// 		if c.Request.Method==http.MethodOptions{
	// 			c.JSON(http.StatusOK,nil)
	// 			return
	// 		}
	// 		if c.Request.Method!=http.MethodPost{
	// 			c.JSON(http.StatusMethodNotAllowed,gin.H{"error":"Method Not Allowed"})
	// 			return
	// 		}

	// 		db,err:=GetDBConnection()
	// 		if err!=nil{
	// 			c.JSON(http.StatusInternalServerError,gin.H{"error":"Did Not Connect to the DataBase"})
	// 			return
	// 		}
	// 		defer db.Close()
	// 		var savelesson SaveLesson
	// 		if err:=c.ShouldBindJSON(&savelesson); err!=nil{
	// 			fmt.Print(err)
	// 			c.JSON(http.StatusBadRequest,gin.H{"error":"Invalid Bad Request"})
	// 			return
	// 		}
	// 		questionAnswerJSON, err := json.Marshal(savelesson.QuestionAnswer)
	// 		if err != nil {
	// 			fmt.Print(err)

	// 			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to serialize QuestionAnswer"})
	// 			return
	// 		}
	// 		fmt.Print(savelesson.LessonName)
	// 		fmt.Print(savelesson.TeacherID)
	// 		query := `
    //     INSERT INTO lesson 
    //     (Class, TeacherID, Lesson, QuestionAnswer, TestDate, CreatedBy, CreatedTime, UpdatedTime, UpdatedBy) 
    //     VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW(), ?)
    // `

    // _, err = db.Exec(query, savelesson.ClassLevel, savelesson.TeacherID, savelesson.LessonName, questionAnswerJSON, savelesson.TestTime, savelesson.CreatedBy, savelesson.CreatedBy)

	// 		if err!=nil{
	// 			c.JSON(http.StatusInternalServerError,gin.H{"error":"Failed to Exxecute the Query"})
	// 			fmt.Print(err)
	// 			return
	// 		}
	// 		c.JSON(http.StatusOK,"Lesson Scored Successfull")


	// }


// if err:= c.ShouldBindJSON(&scoreData); err !=nil {
// 	c.JSON(http.StatusBadRequest,gin.H{"error":"Invalid Request Data,Check the Data"})
// 	return
// }
// // query := "INSERT INTO scores (user_id, score) VALUES (?, ?)"
// // // Execute the SQL query
// // _, err = db.Exec(query, scoreData.UserID, scoreData.Score)
// // if err != nil {
// // 	c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not save the score"})
// // 	return
// // }
// 	func GetQA(c *gin.Context) {
//     c.Header("Access-Control-Allow-Origin", "*")
//     c.Header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
//     c.Header("Access-Control-Allow-Headers", "Content-Type")

//     if c.Request.Method == http.MethodOptions {
//         c.JSON(http.StatusOK, nil)
//         return
//     }
//     if c.Request.Method != http.MethodGet {
//         c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid request method"})
//         return
//     }
//     // Connect to the database
//     db, err := GetDBConnection()
//     if err != nil {
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Error connecting to the database"})
//         return
//     }
//     defer db.Close()
//     query := `SELECT datas FROM testdata WHERE ID=10`
//     var jsonData string
//     err = db.QueryRow(query).Scan(&jsonData)
//     if err != nil {
//         log.Printf("Error executing query: %v", err)
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Error executing query"})
//         return
//     }

//     // Log the raw JSON data for debugging
//     log.Printf("Retrieved JSON data: %s", jsonData)

//     // Return the raw JSON data directly without unmarshalling it into a Go struct
//     c.Data(http.StatusOK, "application/json", []byte(jsonData))
// }



// func SaveScore(c *gin.Context){

// c.Header("Access-Control-Allow-Orgin","*")
// c.Header("Access-Control-Allow-Methods","Content-Type")
// c.Header("Access-Control-Allow-Headers","POST,GET,OPTIONS")


// if c.Request.Method==http.MethodOptions{
// 	c.JSON(http.StatusOK,nil)
// 	return
// }

// if c.Request.Method!=http.MethodPost{

// 	c.JSON(http.StatusBadRequest,gin.H{"error":"Invalid Method"})
// }

// db,err:=GetDBConnection();
// if err!=nil{
// 	c.JSON(http.StatusInternalServerError,gin.H{"error":"Did not connect to the Database"})
// }
// defer db.Close();



// // Bind JSON data from the request to the struct
// var scoreData ScoreData
// // if err := c.ShouldBindJSON(&scoreData); err != nil {
// // 	c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request data"})
// // 	return
// // }


// if err:= c.ShouldBindJSON(&scoreData); err !=nil {

// 	c.JSON(http.StatusBadRequest,gin.H{"error":"Invalid Request Data,Check the Data"})
// 	return
// }
// query:="INSERT INTO "

// // // Construct the SQL query to save the score
// // query := "INSERT INTO scores (user_id, score) VALUES (?, ?)"

// // // Execute the SQL query
// // _, err = db.Exec(query, scoreData.UserID, scoreData.Score)
// // if err != nil {
// // 	c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not save the score"})
// // 	return
// // }

// // Respond with success if the query was successful
// c.JSON(http.StatusOK, gin.H{"message": "Score saved successfully"})




// }
 
