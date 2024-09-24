package models

import (
    "encoding/json"
    "math/rand"
    "net/http"
    "time"

    "github.com/gin-gonic/gin"
    _ "github.com/go-sql-driver/mysql" // Import the MySQL driver
)

// Define a structure that matches the JSON format
type EntryLevelQuestion struct {
    Question string   `json:"question"`
    Options  []string `json:"options,omitempty"`
    Type     string   `json:"type"`
    Answer   string   `json:"answer,omitempty"`
}

type EntryLevelData struct {
    EntryLevelQuestions []EntryLevelQuestion `json:"entrylevelquestions"`
}



func fetchData() (*EntryLevelData, error) {
    db, err := GetDBConnection()
    if err != nil {
        return nil, err
    }
    defer db.Close()

    var jsonData string
    err = db.QueryRow("SELECT question FROM entrylevelquestion WHERE ID = ?", 1).Scan(&jsonData)
    if err != nil {
        return nil, err
    }

    var data EntryLevelData
    err = json.Unmarshal([]byte(jsonData), &data)
    if err != nil {
        return nil, err
    }

    return &data, nil
}

func getRandomSubset(data *EntryLevelData, subsetSize int) []EntryLevelQuestion {
    rand.Seed(time.Now().UnixNano())
    
    shuffled := make([]EntryLevelQuestion, len(data.EntryLevelQuestions))
    copy(shuffled, data.EntryLevelQuestions)
    
    rand.Shuffle(len(shuffled), func(i, j int) {
        shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
    })

    if subsetSize > len(shuffled) {
        subsetSize = len(shuffled)
    }
	print(shuffled[:subsetSize])
    return shuffled[:subsetSize]
}


// HTTP handler to return random data
func DataHandler(c *gin.Context) {
    data, err := fetchData()
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }

    subsetSize := 5
    subsetData := getRandomSubset(data, subsetSize)

    c.JSON(http.StatusOK, gin.H{"entrylevelquestions": subsetData})
}


