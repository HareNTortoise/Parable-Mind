package repository

import (
	"context"
	"server/internal/firebase"
	"server/internal/model"

	"cloud.google.com/go/firestore"
)

func SaveStudent(s model.Student) error {
	_, err := firebase.Client.Collection("students").Doc(s.ID).Set(context.Background(), s)
	return err
}

func GetStudentByID(id string) (*model.Student, error) {
	doc, err := firebase.Client.Collection("students").Doc(id).Get(context.Background())
	if err != nil {
		return nil, err
	}
	var s model.Student
	doc.DataTo(&s)
	return &s, nil
}

func DeleteStudent(id string) error {
	_, err := firebase.Client.Collection("students").Doc(id).Delete(context.Background())
	return err
}

func GetAllStudents(filters map[string]string) ([]model.Student, error) {
	ctx := context.Background()
	q := firebase.Client.Collection("students").Query

	if email, ok := filters["email"]; ok && email != "" {
		q = q.Where("email", "==", email)
	}
	if rollNo, ok := filters["rollNo"]; ok && rollNo != "" {
		q = q.Where("rollNo", "==", rollNo)
	}

	iter := q.Documents(ctx)
	var results []model.Student
	for {
		doc, err := iter.Next()
		if err != nil {
			break
		}
		var s model.Student
		doc.DataTo(&s)
		results = append(results, s)
	}
	return results, nil
}

func PatchStudent(id string, updates map[string]interface{}) error {
	_, err := firebase.Client.Collection("students").Doc(id).Set(context.Background(), updates, firestore.MergeAll)
	return err
}
