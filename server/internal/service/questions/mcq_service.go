package questions

import (
	modelQuestions "server/internal/model/questions"
	"server/internal/repository/questions"
)

func CreateMCQ(m modelQuestions.MCQ) error {
	return questions.SaveMCQ(m)
}

func GetMCQ(id string) (*modelQuestions.MCQ, error) {
	return questions.GetMCQByID(id)
}

func DeleteMCQ(id string) error {
	return questions.DeleteMCQ(id)
}

func GetAllMCQs(filters map[string]string) ([]modelQuestions.MCQ, error) {
	return questions.GetAllMCQs(filters)
}

func UpdateMCQ(id string, updated modelQuestions.MCQ) error {
	updated.ID = id
	return questions.SaveMCQ(updated)
}

func PatchMCQ(id string, updates map[string]interface{}) error {
	return questions.PatchMCQ(id, updates)
}
