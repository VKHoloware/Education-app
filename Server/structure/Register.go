package structure



type Student struct {
	Name           string  `json:"name"`
	Email          string  `json:"email"`
	RegisterNumber string  `json:"registernumber"`
	CreatedTime      string  `json:"createdtime"`
	EnglishProficiency *string `json:"englishproficiency"` // Pointer to handle NULL values

	// Class          *string `json:"class"`  // Use a pointer to handle NULL values
}
