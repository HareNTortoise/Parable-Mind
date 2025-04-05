package service

import (
	"server/internal/model"
	"server/internal/repository"
)

func CreateClassroom(c model.Classroom) error {
	return repository.SaveClassroom(c)
}

func GetClassroom(id string) (*model.Classroom, error) {
	return repository.GetClassroomByID(id)
}

func DeleteClassroom(id string) error {
	return repository.DeleteClassroom(id)
}

func GetAllClassrooms() ([]model.Classroom, error) {
	return repository.GetAllClassrooms()
}

func UpdateClassroom(id string, updated model.Classroom) error {
	updated.ID = id
	return repository.SaveClassroom(updated)
}

func PatchClassroom(id string, updates map[string]interface{}) error {
	return repository.PatchClassroom(id, updates)
}
