package controller

import (
	"net/http"
	"server/internal/model"
	"server/internal/service"

	"github.com/gin-gonic/gin"
)

// @Summary Create a student
// @Tags Students
// @Accept json
// @Produce json
// @Param student body model.Student true "Student JSON"
// @Success 201 {object} model.Student
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /students [post]
func CreateStudent(c *gin.Context) {
	var student model.Student
	if err := c.ShouldBindJSON(&student); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.CreateStudent(student); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create student"})
		return
	}
	c.JSON(http.StatusCreated, student)
}

// @Summary Get a student by ID
// @Tags Students
// @Produce json
// @Param id path string true "Student ID"
// @Success 200 {object} model.Student
// @Failure 404 {object} map[string]string
// @Router /students/{id} [get]
func GetStudent(c *gin.Context) {
	id := c.Param("id")
	student, err := service.GetStudent(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Student not found"})
		return
	}
	c.JSON(http.StatusOK, student)
}

// @Summary Delete a student
// @Tags Students
// @Param id path string true "Student ID"
// @Success 200 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /students/{id} [delete]
func DeleteStudent(c *gin.Context) {
	id := c.Param("id")
	if err := service.DeleteStudent(id); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete student"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Student deleted"})
}

// @Summary Get all students
// @Tags Students
// @Param email query string false "Filter by email"
// @Param rollNo query string false "Filter by roll number"
// @Success 200 {array} model.Student
// @Failure 500 {object} map[string]string
// @Router /students [get]
func GetAllStudents(c *gin.Context) {
	filters := map[string]string{
		"email":  c.Query("email"),
		"rollNo": c.Query("rollNo"),
	}
	students, err := service.GetAllStudents(filters)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch students"})
		return
	}
	c.JSON(http.StatusOK, students)
}

// @Summary Update a student
// @Tags Students
// @Accept json
// @Produce json
// @Param id path string true "Student ID"
// @Param student body model.Student true "Updated student"
// @Success 200 {object} model.Student
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /students/{id} [put]
func UpdateStudent(c *gin.Context) {
	id := c.Param("id")
	var student model.Student
	if err := c.ShouldBindJSON(&student); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.UpdateStudent(id, student); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update student"})
		return
	}
	c.JSON(http.StatusOK, student)
}

// @Summary Patch a student
// @Tags Students
// @Accept json
// @Produce json
// @Param id path string true "Student ID"
// @Param updates body map[string]interface{} true "Fields to update"
// @Success 200 {object} map[string]string
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /students/{id} [patch]
func PatchStudent(c *gin.Context) {
	id := c.Param("id")
	var updates map[string]interface{}
	if err := c.ShouldBindJSON(&updates); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.PatchStudent(id, updates); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to patch student"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Student updated"})
}
