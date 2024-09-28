package structure

// import "database/sql"

type AddWords struct {
    ID      int                `json:"id"`
	MyWords []WordEntry `json:"mywords"`
}

type WordEntry struct {
	Word        string `json:"Word"`
	Definition  string `json:"Definition"`
	Pronunciation string `json:"Pronunciation"`
}

type Fetchvocabulary struct {
    ID      int                `json:"id"`
}

type VocabularyData struct {
	LessonLevel   string `json:"LessonLevel"`
	UserLevel     string `json:"UserLevel"`
	// Datas         []map[string]interface{} `json:"Datas"`
	OrganisationID int    `json:"organisationid"`
	CreatedBy     string `json:"CreatedBy"`
		TestData        []TestQuestion `json:"TestData"`
		Datas         []map[string]interface{} `json:"Datas"`


}


type SaveVocabularyTestQuestion struct {
	LessonLevel     string                   `json:"LessonLevel"`
	UserLevel       string                   `json:"UserLevel"`
	TestData        []TestQuestion           `json:"TestData"` // Updated to reflect new structure
	OrganisationID  int                      `json:"OrganisationID"`
}

// type TestQuestion struct {
// 	Question          string        `json:"question"`
// 	Answers           []string      `json:"answers"` // Now specifically a slice of strings
// 	CorrectAnswerIndex int          `json:"correctAnswerIndex"`
// }
// type VocabularyData struct {
// 	LessonLevel     string        `json:"LessonLevel"`
// 	UserLevel       string        `json:"UserLevel"`
// 	OrganisationID  int           `json:"OrganisationID"`
// 	TestData        []TestQuestion `json:"TestData"`
// }

type TestQuestion struct {
	Question          string   `json:"question"`
	Answers           []string `json:"answers"` // A slice of strings for possible answers
	CorrectAnswerIndex int      `json:"correctAnswerIndex"`
}
