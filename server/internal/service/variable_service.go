package service

import (
	"server/internal/model"
	"server/internal/repository"
)

func CreateVariable(v model.Variable) error {
	return repository.SaveVariable(v)
}

func GetVariable(id string) (*model.Variable, error) {
	return repository.GetVariableByID(id)
}

func DeleteVariable(id string) error {
	return repository.DeleteVariable(id)
}

func GetAllVariables(filters map[string]string) ([]model.Variable, error) {
	return repository.GetAllVariables(filters)
}

func UpdateVariable(id string, updated model.Variable) error {
	updated.ID = id
	return repository.SaveVariable(updated)
}

func PatchVariable(id string, updates map[string]interface{}) error {
	return repository.PatchVariable(id, updates)
}
