package service

import (
	"server/internal/model"
	"server/internal/repository"
	"strconv"
)

func CreateQuestionBank(q model.QuestionBank) error {
	return repository.SaveQuestionBank(q)
}

func GetQuestionBank(id string) (*model.QuestionBank, error) {
	return repository.GetQuestionBankByID(id)
}

func DeleteQuestionBank(id string) error {
	return repository.DeleteQuestionBank(id)
}

func GetAllQuestionBanks(filters map[string]string) ([]model.QuestionBank, error) {
	limit := 10
	offset := 0
	if l, err := strconv.Atoi(filters["limit"]); err == nil {
		limit = l
	}
	if o, err := strconv.Atoi(filters["offset"]); err == nil {
		offset = o
	}
	return repository.GetAllQuestionBanks(filters, limit, offset)
}

func UpdateQuestionBank(id string, updated model.QuestionBank) error {
	updated.ID = id
	return repository.SaveQuestionBank(updated)
}

func PatchQuestionBank(id string, updates map[string]interface{}) error {
	return repository.PatchQuestionBank(id, updates)
}
