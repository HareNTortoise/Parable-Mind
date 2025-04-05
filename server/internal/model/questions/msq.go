package questions

import "server/internal/model"

type MSQ struct {
	ID            string           `json:"id" firestore:"id"`
	BankID        string           `json:"bankId" firestore:"bankId"`
	Question      string           `json:"question" firestore:"question"`
	Variable      []model.Variable `json:"variable" firestore:"variable"`
	Points        int              `json:"points" firestore:"points"`
	Options       []string         `json:"options" firestore:"options"`
	AnswerIndices []int            `json:"answerIndices" firestore:"answerIndices"`
}
