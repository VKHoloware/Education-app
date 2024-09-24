package models

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
)

type User struct {
    ID             int    `json:"id"`
    Name           string `json:"name"`
    Email          string `json:"email"`
    RegisterNumber string `json:"registernumber"`
    Password       string `json:"password"`
    OrganizationID int    `json:"OrganizationID"`
    Role           string `json:"role"`
    Class          string `json:"class"`
    AdminName      string `json:"createdby"`
    NativeLanguage      string `json:"Nativelanguage"`
    EnglishProficency      string `json:"EnglishProficency"`


}

  type Organization struct {
    ID         int    `json:"id"`
    Name       string `json:"name"`
    Email      string `json:"email"`
    AdminName  string `json:"adminName"`
}

type Delete struct{
    ID int `json:"id"`
    Email string `json:"deletedby"`
}


func UserRegister(c *gin.Context) {
    // Log request received
    fmt.Println("User registration request received...")

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

    var user User

    // Log the raw request body for debugging
    log.Printf("Received payload: %+v", c.Request.Body)

    if err := c.ShouldBindJSON(&user); err != nil {
        log.Printf("Failed to bind JSON: %v", err)
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
        return
    }

    // Log the parsed user object
    log.Printf("Parsed User: %+v", user)

    // Connect to the database
    db, err := GetDBConnection()
    if err != nil {
        log.Printf("Database connection error: %v", err)
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
        return
    }
    defer db.Close()

    // Insert data into the database
    query := "INSERT INTO user (OrganizationID, Name, RegisterNumber, Password, EmailId, Role, IsApproved, CreatedBy, CreatedTime, UpdatedBy, UpdateTime, NativeLanguage, EnglishProficency) VALUES (?, ?, ?, ?, ?, ?, 1, ?, Now(), ?, Now(), ?, ?)"
    _, err = db.Exec(query, user.OrganizationID, user.Name, user.RegisterNumber, user.Password, user.Email, user.Role, user.AdminName, user.AdminName, user.NativeLanguage, user.EnglishProficency)
      if err != nil {
        log.Printf("Failed to insert data: %v", err)
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to insert data"})
        return
    }

    // Respond with success
    c.JSON(http.StatusOK, gin.H{"message": "User registered successfully"})
}




// func Login(c *gin.Context) {
//     var credentials struct {
//         RegisterNumber string `json:"registerNumber"`
//         Password       string `json:"password"`
//     }

//     if err := c.BindJSON(&credentials); err != nil {
//         c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
//         return
//     }

//     var user User
//     var org Organization

//     db, err := GetDBConnection()
//     if err != nil {
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
//         return
//     }
//     defer db.Close()

//     // Query 1: Check user table
//     query1 := "SELECT ID, Name, EmailId, RegisterNumber, OrganizationId, Role,EnglishProficency, CreatedBy FROM user WHERE EmailId = ? AND Password = ?"
//     err = db.QueryRow(query1, credentials.RegisterNumber, credentials.Password).Scan(
//         &user.ID, &user.Name, &user.Email, &user.RegisterNumber, &user.OrganizationID, &user.Role,&user.EnglishProficency,
//     )

//     if err == sql.ErrNoRows {
//         // If no user is found, check organization
//         query2 := "SELECT ID, Name, Email, AdminName FROM organization WHERE Email = ? AND Password = ?"
//         err = db.QueryRow(query2, credentials.RegisterNumber, credentials.Password).Scan(
//             &org.ID, &org.Name, &org.Email, &org.AdminName,
//         )

//         if err == sql.ErrNoRows {
//             c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid credentials"})
//             return
//         } else if err != nil {
//             c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data from organization table"})
//             return
//         }

//         // Organization login response
//         c.JSON(http.StatusOK, gin.H{
//             "id":              org.ID,
//             "orgName":         org.Name,
//             "email":           org.Email,
//             "adminName":       org.AdminName,
//             "organizationID": "0",
//         })
//         return
//     } else if err != nil {
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data from user table"})
//         return
//     }

//     // User login response
//     c.JSON(http.StatusOK, gin.H{
//         "id":              user.ID,
//         "name":            user.Name,
//         "email":           user.Email,
//         "registerNumber":  user.RegisterNumber,
//         "organizationID":  user.OrganizationID,
//         "role":            user.Role,
//         "class":           user.Class,
//         "adminName":       user.AdminName,
//     })
// }
func Login(c *gin.Context) {
    var credentials struct {
        RegisterNumber string `json:"registerNumber"` // You may want to rename this to "Email"
        Password       string `json:"password"`
    }

    // Bind JSON input to credentials struct
    if err := c.BindJSON(&credentials); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
        return
    }

    var user User
    var org Organization

    // Establish a database connection
    db, err := GetDBConnection()
    if err != nil {
        log.Printf("Database connection error: %v", err)
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
        return
    }
    defer db.Close()

    // Query 1: Check the user table for matching credentials
    query1 := `SELECT ID, Name, EmailId, RegisterNumber, OrganizationId, Role, EnglishProficency 
               FROM user WHERE EmailId = ? AND Password = ?`
    
    err = db.QueryRow(query1, credentials.RegisterNumber, credentials.Password).Scan(
        &user.ID, &user.Name, &user.Email, &user.RegisterNumber, &user.OrganizationID, &user.Role, &user.EnglishProficency, 
    )

    if err == sql.ErrNoRows {
        // If no user is found, check the organization table
        query2 := `SELECT ID, Name, Email, AdminName 
                   FROM organization WHERE Email = ? AND Password = ?`
        err = db.QueryRow(query2, credentials.RegisterNumber, credentials.Password).Scan(
            &org.ID, &org.Name, &org.Email, &org.AdminName,
        )

        if err == sql.ErrNoRows {
            // No matching credentials found in both user and organization tables
            c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid credentials"})
            return
        } else if err != nil {
            // Error while querying the organization table
            log.Printf("Error querying organization table: %v", err)
            c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data from organization table"})
            return
        }

        // Successful organization login response
        c.JSON(http.StatusOK, gin.H{
            "id":              org.ID,
            "orgName":         org.Name,
            "email":           org.Email,
            "adminName":       org.AdminName,
            "organizationID": "0",  // Since it's an organization, we set this as "0"
        })
        return
    } else if err != nil {
        // Error while querying the user table
        log.Printf("Error querying user table: %v", err)
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data from user table"})
        return
    }

    // Successful user login response
    c.JSON(http.StatusOK, gin.H{
        "id":              user.ID,
        "name":            user.Name,
        "email":           user.Email,
        "registerNumber":  user.RegisterNumber,
        "organizationID":  user.OrganizationID,
        "role":            user.Role,
        "englishProficency": user.EnglishProficency,
        // "createdBy":       user.Createdby,
    })
}

// func DeleteUser (c *gin.Context){
    
// fmt.Print("Delete User")
// c.Header("Access-Control-Allow-Orgin","*")
// c.Header("Access-Control-Allow-Methods","POST,GET,OPTIONS")
// c.Header("Access-Control-Allow-Headers","Content-Type")

// if c.Request.Method==http.MethodOptions{
//     c.JSON(http.StatusOK,nil)
//     return
// }

// if c.Request.Method!=http.MethodPost{
//     c.JSON(http.StatusMethodNotAllowed,gin.H{"error":"Invalid Method "})    
//     return
// }

// db,err:=GetDBConnection()

// if  err!=nil{
//     c.JSON(http.StatusInternalServerError,gin.H{"error":"DB Connection is Invalid ,Check the Connection"})
//     return

// }
// defer db.Close()

// var deletedData Delete

// if err:=c.ShouldBindJSON(&deletedData); err!=nil{
//     c.JSON(http.StatusBadRequest,gin.H{"error":"Invalid Request"})
//     return

// }

// fmt.Print(deletedData.ID)


// query:="UPDATE user SET isDeleted=1 ,DeletedBy=? WHERE ID=?"

// _,err=db.Exec(query, deletedData.ID,deletedData.Email)
// if err!=nil{
//     log.Printf("Failed to Update  data: %v", err)
//     c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to insert data"})
//     return
// }
// c.JSON(http.StatusOK, gin.H{"message": "User Deleted successfully"})








// }

func DeleteUser(c *gin.Context) {
    fmt.Print("Delete User")
    c.Header("Access-Control-Allow-Origin", "*")
    c.Header("Access-Control-Allow-Methods", "POST,GET,OPTIONS")
    c.Header("Access-Control-Allow-Headers", "Content-Type")

    if c.Request.Method == http.MethodOptions {
        c.JSON(http.StatusOK, nil)
        return
    }

    if c.Request.Method != http.MethodPost {
        c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Invalid Method"})
        return
    }

    db, err := GetDBConnection()
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "DB Connection is Invalid, Check the Connection"})
        return
    }
    defer db.Close()

    var deletedData struct {
        ID        int    `json:"id"`
        DeletedBy string `json:"deletedby"`
    }

    if err := c.ShouldBindJSON(&deletedData); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid Request"})
        return
    }

    fmt.Print(deletedData.ID)

    // Ensure that the table name and columns are correct
    query := "UPDATE user SET isDeleted = 1, DeletedBy = ? WHERE ID = ?"

    // Bind parameters in the correct order
    _, err = db.Exec(query, deletedData.DeletedBy, deletedData.ID)
    if err != nil {
        log.Printf("Failed to update data: %v", err)
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update data"})
        return
    }
    c.JSON(http.StatusOK, gin.H{"message": "User Deleted successfully"})
}

// // func Login(c *gin.Context) {
// //     var credentials struct {
// //         RegisterNumber string `json:"registernumber"`
// //         Password       string `json:"password"`
// //     }

// //     // Print received login attempt
// //     fmt.Println("Attempting login")

// //     // Bind JSON input
// //     if err := c.ShouldBindJSON(&credentials); err != nil {
// //         c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
// //         return
// //     }

// //     // Print received credentials for debugging
// //     fmt.Printf("Received credentials: RegisterNumber: %s, Password: %s\n", credentials.RegisterNumber, credentials.Password)

// //     // Connect to the database
    // db, err := GetDBConnection()
    // if err != nil {
    //     c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
    //     return
    // }
    // defer db.Close()

// //     // First struct for user table

 
    
// //     // User struct with JSON tags for serialization
// //     type User struct {
// //         ID             int    `json:"id"`
// //         Name           string `json:"name"`
// //         Email          string `json:"email"`
// //         RegisterNumber string `json:"registerNumber"`
// //         OrganizationID int    `json:"organizationId"`
// //         Role           string `json:"role"`
// //         Class          string `json:"class"` // Ensure this matches your DB schema
// //         AdminName      string `json:"adminName"`
// //     }
    
    // // Organization struct
    // type Organization struct {
    //     ID         int    `json:"id"`
    //     Name       string `json:"name"`
    //     Email      string `json:"email"`
    //     AdminName  string `json:"adminName"`
    // }
    
    
    
// //         var user User
// //         var org Organization
    
// //         // Query 1: Check user table
// //         query1 := "SELECT ID, Name, EmailId, RegisterNumber, OrganizationId, Role, class FROM user WHERE RegisterNumber = ? AND Password = ?"
// //         err := db.QueryRow(query1, credentials.RegisterNumber, credentials.Password).Scan(&user.ID, &user.Name, &user.Email, &user.RegisterNumber, &user.OrganizationID, &user.Role, &user.Class)
    
// //         if err == sql.ErrNoRows {
// //             fmt.Printf("First query failed, attempting second query for RegisterNumber: %s\n", credentials.RegisterNumber)
    
// //             // Query 2: Check organization table
// //             query2 := "SELECT ID, Name, Email, AdminName FROM organization WHERE Email = ? AND Password = ?"
// //             err = db.QueryRow(query2, credentials.RegisterNumber, credentials.Password).Scan(&org.ID, &org.Name, &org.Email, &org.AdminName)
    
// //             if err == sql.ErrNoRows {
// //                 log.Printf("No matching records in both user and organization tables for RegisterNumber: %s", credentials.RegisterNumber)
// //                 c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid credentials"})
// //                 return
// //             } else if err != nil {
// //                 log.Printf("Error querying organization table: %v", err)
// //                 c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data from organization table"})
// //                 return
// //             }
    
// //             // Populate user data with organization details
// //             user.ID = org.ID
// //             user.Name = org.Name
// //             user.Email = org.Email
// //             user.RegisterNumber = credentials.RegisterNumber
// //             user.OrganizationID = 0
// //             user.AdminName = org.AdminName
// //             user.Class = "Sample" // Default value or empty string if not applicable
    
// //         } else if err != nil {
// //             log.Printf("Error querying user table: %v", err)
// //             c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data from user table"})
// //             return
// //         }
    
// //         // Print user data for debugging
// //         fmt.Printf("User data: %+v\n", user)
    
// //         // Respond with user data
// //         c.JSON(http.StatusOK, gin.H{"user": user})
// //     }
    



// func Login(c *gin.Context) {
//     var credentials struct {
//         RegisterNumber string `json:"registerNumber"`
//         Password       string `json:"password"`
//     }
//     if err := c.BindJSON(&credentials); err != nil {
//         c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
//         return
//     }
//     var user User
//     var org Organization
//     db, err := GetDBConnection()
//     if err != nil {
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
//         return
//     }
//     defer db.Close()
//     // Query 1: Check user table
//     query1 := "SELECT ID, Name, EmailId, RegisterNumber, OrganizationId, Role, class FROM user WHERE RegisterNumber = ? AND Password = ?"
//     err := db.QueryRow(query1, credentials.RegisterNumber, credentials.Password).Scan(&user.ID, &user.Name, &user.Email, &user.RegisterNumber, &user.OrganizationID, &user.Role, &user.Class)

//     if err == sql.ErrNoRows {
//         fmt.Printf("First query failed, attempting second query for RegisterNumber: %s\n", credentials.RegisterNumber)

//         // Query 2: Check organization table
//         query2 := "SELECT ID, Name, Email, AdminName FROM organization WHERE Email = ? AND Password = ?"
//         err = db.QueryRow(query2, credentials.RegisterNumber, credentials.Password).Scan(&org.ID, &org.Name, &org.Email, &org.AdminName)

//         if err == sql.ErrNoRows {
//             log.Printf("No matching records in both user and organization tables for RegisterNumber: %s", credentials.RegisterNumber)
//             c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid credentials"})
//             return
//         } else if err != nil {
//             log.Printf("Error querying organization table: %v", err)
//             c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data from organization table"})
//             return
//         }

//         user.ID = org.ID
//         user.Name = org.Name
//         user.Email = org.Email
//         user.RegisterNumber = credentials.RegisterNumber
//         user.OrganizationID = 0
//         user.AdminName = org.AdminName
//         // Note: `user.Class` is not set here, so it will be empty

//     } else if err != nil {
//         log.Printf("Error querying user table: %v", err)
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data from user table"})
//         return
//     }

//     // Log retrieved user data for debugging
//     log.Printf("User data: %+v", user)

//     // Respond with user data
//     c.JSON(http.StatusOK, gin.H{"user": user})

// }

// func Login(c *gin.Context) {
//     var credentials struct {
//         RegisterNumber string `json:"registerNumber"`
//         Password       string `json:"password"`
//     }

//     if err := c.BindJSON(&credentials); err != nil {
//         c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
//         return
//     }

//     var user User
//     var org Organization

//     db, err := GetDBConnection()
//     if err != nil {
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
//         return
//     }
//     defer db.Close()

//     // Query 1: Check user table
//     query1 := "SELECT ID, Name, EmailId, RegisterNumber, OrganizationId, Role, Class, CreatedBy FROM user WHERE RegisterNumber = ? AND Password = ?"
//     err = db.QueryRow(query1, credentials.RegisterNumber, credentials.Password).Scan(&user.ID, &user.Name, &user.Email, &user.RegisterNumber, &user.OrganizationID, &user.Role, &user.Class, &user.AdminName)

//     if err == sql.ErrNoRows {
//         // If no user is found, check organization
//         fmt.Printf("First query failed, attempting second query for RegisterNumber: %s\n", credentials.RegisterNumber)

//         query2 := "SELECT ID, Name, Email, AdminName FROM organization WHERE Email = ? AND Password = ?"
//         err = db.QueryRow(query2, credentials.RegisterNumber, credentials.Password).Scan(&org.ID, &org.Name, &org.Email, &org.AdminName)

//         if err == sql.ErrNoRows {
//             log.Printf("No matching records in both user and organization tables for RegisterNumber: %s", credentials.RegisterNumber)
//             c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid credentials"})
//             return
//         } else if err != nil {
//             log.Printf("Error querying organization table: %v", err)
//             c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data from organization table"})
//             return
//         }

//         // Organization login response
//         c.JSON(http.StatusOK, gin.H{
//             "id":        org.ID,
//             "orgName":   org.Name,
//             "email":     org.Email,
//             "adminName": org.AdminName,
//             "organisationId":"0",
//         })
//         return

//     } else if err != nil {
//         log.Printf("Error querying user table: %v", err)
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data from user table"})
//         return
//     }

//     // User login response
//     c.JSON(http.StatusOK, gin.H{
//         "id":             user.ID,
//         "name":           user.Name,
//         "email":          user.Email,
//         "registerNumber": user.RegisterNumber,
//         "organizationID": user.OrganizationID,
//         "role":           user.Role,
//         "class":          user.Class,
//         "adminName":      user.AdminName,
//     })
// }

// func Login(c *gin.Context) {
//     var credentials struct {
//         RegisterNumber string `json:"registerNumber"`
//         Password       string `json:"password"`
//     }

//     if err := c.BindJSON(&credentials); err != nil {
//         c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
//         return
//     }

//     var user User
//     var org Organization

//     db, err := GetDBConnection()
//     if err != nil {
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
//         return
//     }
//     defer db.Close()

//     // Query 1: Check user table
//     query1 := "SELECT ID, Name, EmailId, RegisterNumber, OrganizationId, Role, Class, CreatedBy FROM user WHERE RegisterNumber = ? AND Password = ?"
//     err = db.QueryRow(query1, credentials.RegisterNumber, credentials.Password).Scan(
//         &user.ID, &user.Name, &user.Email, &user.RegisterNumber, &user.OrganizationID, &user.Role, &user.Class, &user.AdminName,
//     )

//     if err == sql.ErrNoRows {
//         // If no user is found, check organization
//         query2 := "SELECT ID, Name, Email, AdminName FROM organization WHERE Email = ? AND Password = ?"
//         err = db.QueryRow(query2, credentials.RegisterNumber, credentials.Password).Scan(
//             &org.ID, &org.Name, &org.Email, &org.AdminName,
//         )

//         if err == sql.ErrNoRows {
//             c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid credentials"})
//             return
//         } else if err != nil {
//             c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data from organization table"})
//             return
//         }

//         // Organization login response
//         c.JSON(http.StatusOK, gin.H{
//             "id":              org.ID,  // Convert to string
//             "orgName":        org.Name,
//             "email":          org.Email,
//             "adminName":      org.AdminName,
//             "organizationID": "0",  // String representation
//         })
//         return
//     } else if err != nil {
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data from user table"})
//         return
//     }

//     // User login response
//     c.JSON(http.StatusOK, gin.H{
//         "id":              user.ID,  // Convert to string
//         "name":           user.Name,
//         "email":          user.Email,
//         "registerNumber": user.RegisterNumber,
//         "organizationID":  user.OrganizationID,  // Convert to string
//         "role":           user.Role,
//         "class":          user.Class,
//         "adminName":      user.AdminName,
//     })
// }



// // Organization struct
// type Organization struct {
//     ID         int    `json:"id"`
//     Name       string `json:"name"`
//     Email      string `json:"email"`
//     AdminName  string `json:"adminName"`
// }

// func Login(c *gin.Context) {
//     var credentials struct {
//         RegisterNumber string `json:"registerNumber"`
//         Password       string `json:"password"`
//     }
//     if err := c.BindJSON(&credentials); err != nil {
//         c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
//         return
//     }

//     var user User
//     var org Organization

//     db, err := GetDBConnection()
//     if err != nil {
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection error"})
//         return
//     }
//     defer db.Close()

//     // Query 1: Check user table
//     query1 := "SELECT ID, Name, EmailId, RegisterNumber, OrganizationId, Role, class FROM user WHERE RegisterNumber = ? AND Password = ?"
//     err = db.QueryRow(query1, credentials.RegisterNumber, credentials.Password).Scan(&user.ID, &user.Name, &user.Email, &user.RegisterNumber, &user.OrganizationID, &user.Role, &user.Class)

//     if err == sql.ErrNoRows {
//         fmt.Printf("First query failed, attempting second query for RegisterNumber: %s\n", credentials.RegisterNumber)

//         // Query 2: Check organization table
//         query2 := "SELECT ID, Name, Email, AdminName FROM organization WHERE Email = ? AND Password = ?"
//         err = db.QueryRow(query2, credentials.RegisterNumber, credentials.Password).Scan(&org.ID, &org.Name, &org.Email, &org.AdminName)

//         if err == sql.ErrNoRows {
//             log.Printf("No matching records in both user and organization tables for RegisterNumber: %s", credentials.RegisterNumber)
//             c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid credentials"})
//             return
//         } else if err != nil {
//             log.Printf("Error querying organization table: %v", err)
//             c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data from organization table"})
//             return
//         }

//         // Populate user data with organization details
//         user.ID = org.ID
//         user.Name = org.Name
//         user.Email = org.Email
//         user.RegisterNumber = credentials.RegisterNumber
//         user.OrganizationID = 0
//         user.AdminName = org.AdminName
//         user.Class = "" // Default value or empty string if not applicable

//         // Respond with organization data, default user fields
//         c.JSON(http.StatusOK, gin.H{"user": user})
//         fmt.Print(user)
//         return
//     } else if err != nil {
//         log.Printf("Error querying user table: %v", err)
//         c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve data from user table"})
//         return
//     }

//     // Print user data for debugging
//     fmt.Printf("User data: %+v\n", user)

//     // Respond with user data
//     c.JSON(http.StatusOK, gin.H{"user": user})
// }
