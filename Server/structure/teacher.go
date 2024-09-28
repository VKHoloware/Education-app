package structure

type Savevocabularylesson struct {

	LessonLevel string `json:"lessonlevel"`
	StudentLevel string `json:"studentlevel"`
	OrganisationId int `json:"organisationid"`
	Question []WordEntry `json:"questions"`

	

}