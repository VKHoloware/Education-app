package models

import (
	"bytes"
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)
func CheckGemini() {
  apiKey := os.Getenv("GOOGLE_API_KEY")
    log.Printf("Fetched API Key: %s", apiKey)
    if apiKey == "" {
        log.Fatal("GOOGLE_API_KEY environment variable is not set")
    }

    url := "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyAIGoyXutTer63xnuxlDYuwyoAuqAW-SOU "

    // Create a request payload
    requestBody := map[string]interface{}{
        "model":     "gpt-3.5-turbo",
        "prompt":    "Hello, how are you?",
        "max_tokens": 50,
    }

    jsonData, err := json.Marshal(requestBody)
    if err != nil {
        log.Fatalf("Failed to marshal request body: %v", err)
    }

    // Create a new POST request
    req, err := http.NewRequest("POST", url, bytes.NewBuffer(jsonData))
    if err != nil {
        log.Fatalf("Failed to create request: %v", err)
    }

    // Set headers
    req.Header.Set("Authorization", "Bearer "+apiKey)
    req.Header.Set("Content-Type", "application/json")

    // Send the request
    client := &http.Client{}
    resp, err := client.Do(req)
    if err != nil {
        log.Fatalf("Failed to send request: %v", err)
    }
    defer resp.Body.Close()

    // Read the response
    body, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        log.Fatalf("Failed to read response body: %v", err)
    }

    // Print the response
    log.Printf("Response Status: %s", resp.Status)
    log.Printf("Response Body: %s", body)
}

