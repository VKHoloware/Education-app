package main

import (
	"log"
	"models" // Ensure this import path matches your actual project structure

	"routes"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	// "google.golang.org/genproto/googleapis/maps/routes/v1"
)

func main() {
    // Initialize Gin router
    r := gin.Default()

    // Apply CORS middleware
    r.Use(cors.New(cors.Config{
        AllowOrigins:     []string{"*"}, // Allow all origins
        AllowMethods:     []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
        AllowHeaders:     []string{"Origin", "Content-Type", "Accept", "Authorization"},
        ExposeHeaders:    []string{"Content-Length"},
        AllowCredentials: true,
    }))

    // Add security headers
    r.Use(func(c *gin.Context) {
        c.Writer.Header().Set("Cross-Origin-Opener-Policy", "same-origin")
        c.Writer.Header().Set("Cross-Origin-Embedder-Policy", "require-corp")
        c.Next()
    })
    models.GetDBConnection()
    // routes.Savewords();


    // Register the route and handler
    r.POST("/userRegister", models.UserRegister)
    r.POST("/login",models.Login)
    r.POST("/organisationregister",models.OrganisationRegister)
    r.GET("/organisationname",models.OrganisationName)
    r.GET("/teacherdata",models.TeachersDatas)
    r.GET("/studentdata",routes.StudentDatas)
    r.POST("/savequestionanswer",models.SaveToDatabase)
    r.POST("/deleteuser",models.DeleteUser)
    r.POST("/savelesson",models.SaveLessonData)
    r.POST("/savelevel",models.SaveStudentLevel)
    r.GET("/fetchVocabularyTestQuestions", models.FetchVocabularyTestQuestion)
    // r.POST("/savevocabulary",models.SaveVocabularyQuestion)
    r.POST("/saveTestScore", models.SaveTestScore)

 





    r.GET("/learnsavequestion",models.GetQA)
    r.GET("/organisationDetails",models.OrganisationDetails)
    r.GET("/data", models.DataHandler)
    r.GET("/vocabulary", models.DefaultVocabularyLevel)
    r.GET("/fetchvocabulary",models.FetchVocabularyQuestion)




    r.POST("/savewords",routes.SaveWords)
    r.GET("/getwords",routes.FetchWords)
    r.POST("/savevocabulary",routes.SaveVocabularyQuestion)
    r.POST("/savevocabularytestdata",routes.SaveVocabularyTestQuestion)
    r.POST("/getword",routes.Getwordfromapi)



    
    // r.GET("/data", models.DataHandler)   SaveVocabularyQuestion

    models.CheckGemini()

    port := ":8000"
    log.Printf("Starting server on %s...", port)

    if err := r.Run(port); err != nil {
        log.Fatal(err)
    }
}

