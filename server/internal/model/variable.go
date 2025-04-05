package model

type Variable struct {
	ID            string            `json:"id" firestore:"id"`
	Name          string            `json:"name" firestore:"name"`
	NamePosition  map[string][2]int `json:"namePosition" firestore:"namePosition"`
	ValuePosition map[string][2]int `json:"valuePosition" firestore:"valuePosition"`
	Unit          string            `json:"unit" firestore:"unit"`
	UnitPosition  map[string][2]int `json:"unitPosition" firestore:"unitPosition"`
	VariableType  string            `json:"variableType" firestore:"variableType"`
}
