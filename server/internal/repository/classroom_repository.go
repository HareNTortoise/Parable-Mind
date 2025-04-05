package repository

import (
	"context"
	"server/internal/firebase"
	"server/internal/model"

	"cloud.google.com/go/firestore"
)

func SaveClassroom(c model.Classroom) error {
	_, err := firebase.Client.Collection("classrooms").Doc(c.ID).Set(context.Background(), c)
	return err
}

func GetClassroomByID(id string) (*model.Classroom, error) {
	doc, err := firebase.Client.Collection("classrooms").Doc(id).Get(context.Background())
	if err != nil {
		return nil, err
	}
	var c model.Classroom
	doc.DataTo(&c)
	return &c, nil
}

func DeleteClassroom(id string) error {
	_, err := firebase.Client.Collection("classrooms").Doc(id).Delete(context.Background())
	return err
}

func GetAllClassrooms() ([]model.Classroom, error) {
	iter := firebase.Client.Collection("classrooms").Documents(context.Background())
	var results []model.Classroom
	for {
		doc, err := iter.Next()
		if err != nil {
			break
		}
		var c model.Classroom
		doc.DataTo(&c)
		results = append(results, c)
	}
	return results, nil
}

func PatchClassroom(id string, updates map[string]interface{}) error {
	_, err := firebase.Client.Collection("classrooms").Doc(id).Set(context.Background(), updates, firestore.MergeAll)
	return err
}
