package service

import (
	"server/internal/model"
	"server/internal/repository"
)

func CreatePost(p model.Post) error {
	return repository.SavePost(p)
}

func GetPost(id string) (*model.Post, error) {
	return repository.GetPostByID(id)
}

func DeletePost(id string) error {
	return repository.DeletePost(id)
}

func GetAllPosts() ([]model.Post, error) {
	return repository.GetAllPosts()
}

func UpdatePost(id string, updated model.Post) error {
	updated.ID = id
	return repository.SavePost(updated)
}

func PatchPost(id string, updates map[string]interface{}) error {
	return repository.PatchPost(id, updates)
}
