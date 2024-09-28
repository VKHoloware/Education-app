package models

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"structure"

	_ "github.com/go-sql-driver/mysql"
)

func AddVocabularyData(db *sql.DB, vocabulary structure.VocabularyData, datasJSON string) (string, error) {
	query := `
		INSERT INTO testdata (LessonLevel, UserLevel, OrganisationId, lesson, CreatedBy, CreatedTime, UpdatedBy, UpdatedTime, isDeleted)
		VALUES (?, ?, ?, ?, ?, NOW(), ?, NOW(), 0)`

	_, err := db.Exec(query, vocabulary.LessonLevel, vocabulary.UserLevel, vocabulary.OrganisationID, datasJSON, vocabulary.CreatedBy, vocabulary.CreatedBy)
	if err != nil {
		return "", fmt.Errorf("failed to execute the query: %v", err)
	}

	return "Lesson stored successfully", nil
}

// func AddVocabularyTestQuestion(db *sql.DB, vocabulary structure.SaveVocabularyTestQuestion) (string, error) {
// 	for _, testData := range vocabulary.TestData {
// 		// Extracting the fields from the testData object
// 		question := testData.Question
// 		answers := testData.Answers
// 		correctAnswerIndex := testData.CorrectAnswerIndex

// 		if question == "" || len(answers) == 0 || correctAnswerIndex < 0 {
// 			return "", fmt.Errorf("all fields are required in test data")
// 		}

// 		// Convert answers to JSON format if required
// 		answerJSON, err := json.Marshal(answers)
// 		if err != nil {
// 			return "", fmt.Errorf("failed to marshal answers to JSON: %v", err)
// 		}

// 		// Update query
// 		query := `
// 			UPDATE testdata 
// 			SET answer = ?
// 			WHERE OrganisationId = ? AND LessonLevel = ? AND UserLevel = ?`

// 		_, err = db.Exec(query, answerJSON, vocabulary.OrganisationID, vocabulary.LessonLevel, vocabulary.UserLevel)
// 		if err != nil {
// 			return "", fmt.Errorf("failed to execute the update query: %v", err)
// 		}
// 	}

// 	return "Test Answers Updated Successfully", nil
// }
func AddVocabularyTestQuestion(db *sql.DB, vocabulary structure.SaveVocabularyTestQuestion) (string, error) {
	// Check if TestData is empty
	if len(vocabulary.TestData) == 0 {
		return "", fmt.Errorf("no test data provided")
	}

	// Convert the entire TestData slice to JSON format
	testDataJSON, err := json.Marshal(vocabulary.TestData)
	if err != nil {
		return "", fmt.Errorf("failed to marshal TestData to JSON: %v", err)
	}

	// Update query
	query := `
		UPDATE testdata 
		SET answer = ?
		WHERE OrganisationId = ? AND LessonLevel = ? AND UserLevel = ?`

	_, err = db.Exec(query, testDataJSON, vocabulary.OrganisationID, vocabulary.LessonLevel, vocabulary.UserLevel)
	if err != nil {
		return "", fmt.Errorf("failed to execute the update query: %v", err)
	}

	return "Test Answers Updated Successfully", nil
}
