package repository

import (
	"context"
	"server/internal/firebase"
	"server/internal/model"

	"cloud.google.com/go/firestore"
)

func SaveQuestionBank(q model.QuestionBank) error {
	_, err := firebase.Client.Collection("questionBanks").Doc(q.ID).Set(context.Background(), q)
	return err
}

func GetQuestionBankByID(id string) (*model.QuestionBank, error) {
	doc, err := firebase.Client.Collection("questionBanks").Doc(id).Get(context.Background())
	if err != nil {
		return nil, err
	}
	var q model.QuestionBank
	doc.DataTo(&q)
	return &q, nil
}

func DeleteQuestionBank(id string) error {
	_, err := firebase.Client.Collection("questionBanks").Doc(id).Delete(context.Background())
	return err
}

func GetAllQuestionBanks(filters map[string]string, limit, offset int) ([]model.QuestionBank, error) {
	ctx := context.Background()
	q := firebase.Client.Collection("questionBanks").Query

	if chapter, ok := filters["chapter"]; ok {
		q = q.Where("chapter", "==", chapter)
	}
	if topic, ok := filters["topic"]; ok {
		q = q.Where("topic", "==", topic)
	}

	iter := q.Offset(offset).Limit(limit).Documents(ctx)
	var results []model.QuestionBank
	for {
		doc, err := iter.Next()
		if err != nil {
			break
		}
		var qb model.QuestionBank
		doc.DataTo(&qb)
		results = append(results, qb)
	}
	return results, nil
}

func PatchQuestionBank(id string, updates map[string]interface{}) error {
	_, err := firebase.Client.Collection("questionBanks").Doc(id).Set(context.Background(), updates, firestore.MergeAll)
	return err
}
