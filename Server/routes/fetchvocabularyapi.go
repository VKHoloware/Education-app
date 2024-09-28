package routes

import (
	"fmt"
	"io"
	"net/http"

	"github.com/gin-gonic/gin"
)


func Getwordfromapi(c *gin.Context) {
	// url := "https://e2e-dictionary.p.rapidapi.com/dictionary/Default"

	// req, _ := http.NewRequest("GET", url, nil)
	// req.Header.Add("x-rapidapi-key", "6e59d3feadmshc11ecd239e4c245p1640ccjsn2689e96bb981")
	// req.Header.Add("x-rapidapi-host", "e2e-dictionary.p.rapidapi.com")

	// res, err := http.DefaultClient.Do(req)
	// fmt.Print(res)

	// if err != nil {
	// 	fmt.Print(err)
	// 	c.JSON(http.StatusInternalServerError, gin.H{"error": "Error fetching data from the dictionary API"})
	// 	return
	// }
	// defer res.Body.Close()

	// body, _ := io.ReadAll(res.Body)

	// // Send the JSON response from the external API back to the client (Flutter)
	// c.Data(http.StatusOK, "application/json", body)
	var requestBody struct {
		Word string `json:"word"`
	}
	if err := c.ShouldBindJSON(&requestBody); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request body"})
		return
	}

	word := requestBody.Word

	// Call the dictionary API using the word received from Flutter
	url := fmt.Sprintf("https://e2e-dictionary.p.rapidapi.com/dictionary/%s", word)

	req, _ := http.NewRequest("GET", url, nil)
	req.Header.Add("x-rapidapi-key", "6e59d3feadmshc11ecd239e4c245p1640ccjsn2689e96bb981") // Replace with your RapidAPI key
	req.Header.Add("x-rapidapi-host", "e2e-dictionary.p.rapidapi.com")

	res, err := http.DefaultClient.Do(req)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error fetching data from the dictionary API"})
		return
	}
	defer res.Body.Close()

	body, _ := io.ReadAll(res.Body)

	// Send the response from the external API back to the Flutter app
	c.Data(http.StatusOK, "application/json", body)

	
}
