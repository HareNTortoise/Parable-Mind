package model

type QuestionBank struct {
	ID      string `json:"id" firestore:"id"`
	Chapter string `json:"chapter" firestore:"chapter"`
	Topic   string `json:"topic" firestore:"topic"`
}
