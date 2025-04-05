package model

type Classroom struct {
	ID            string   `json:"id" firestore:"id"`
	Subject       string   `json:"subject" firestore:"subject"`
	TeacherID     string   `json:"teacherId" firestore:"teacherId"`
	AssignmentIDs []string `json:"assignmentIds" firestore:"assignmentIds"`
	Credits       int      `json:"credits" firestore:"credits"`
}
