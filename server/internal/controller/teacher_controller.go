package controller

import (
	"net/http"
	"server/internal/model"
	"server/internal/service"

	"github.com/gin-gonic/gin"
)

// @Summary Create a teacher
// @Tags Teachers
// @Accept json
// @Produce json
// @Param teacher body model.Teacher true "Teacher JSON"
// @Success 201 {object} model.Teacher
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /teachers [post]
func CreateTeacher(c *gin.Context) {
	var t model.Teacher
	if err := c.ShouldBindJSON(&t); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.CreateTeacher(t); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create teacher"})
		return
	}
	c.JSON(http.StatusCreated, t)
}

// @Summary Get a teacher by ID
// @Tags Teachers
// @Produce json
// @Param id path string true "Teacher ID"
// @Success 200 {object} model.Teacher
// @Failure 404 {object} map[string]string
// @Router /teachers/{id} [get]
func GetTeacher(c *gin.Context) {
	id := c.Param("id")
	t, err := service.GetTeacher(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Teacher not found"})
		return
	}
	c.JSON(http.StatusOK, t)
}

// @Summary Delete a teacher
// @Tags Teachers
// @Param id path string true "Teacher ID"
// @Success 200 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /teachers/{id} [delete]
func DeleteTeacher(c *gin.Context) {
	id := c.Param("id")
	if err := service.DeleteTeacher(id); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete teacher"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Teacher deleted"})
}

// @Summary Get all teachers
// @Tags Teachers
// @Param email query string false "Filter by email"
// @Param phone query string false "Filter by phone"
// @Param limit query string false "Pagination limit"
// @Param offset query string false "Pagination offset"
// @Success 200 {array} model.Teacher
// @Failure 500 {object} map[string]string
// @Router /teachers [get]
func GetAllTeachers(c *gin.Context) {
	filters := map[string]string{
		"email":  c.Query("email"),
		"phone":  c.Query("phone"),
		"limit":  c.DefaultQuery("limit", "10"),
		"offset": c.DefaultQuery("offset", "0"),
	}
	teachers, err := service.GetAllTeachers(filters)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch teachers"})
		return
	}
	c.JSON(http.StatusOK, teachers)
}

// @Summary Update a teacher
// @Tags Teachers
// @Accept json
// @Produce json
// @Param id path string true "Teacher ID"
// @Param teacher body model.Teacher true "Updated Teacher"
// @Success 200 {object} model.Teacher
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /teachers/{id} [put]
func UpdateTeacher(c *gin.Context) {
	id := c.Param("id")
	var t model.Teacher
	if err := c.ShouldBindJSON(&t); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.UpdateTeacher(id, t); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update teacher"})
		return
	}
	c.JSON(http.StatusOK, t)
}

// @Summary Patch a teacher
// @Tags Teachers
// @Accept json
// @Produce json
// @Param id path string true "Teacher ID"
// @Param updates body map[string]interface{} true "Fields to update"
// @Success 200 {object} map[string]string
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /teachers/{id} [patch]
func PatchTeacher(c *gin.Context) {
	id := c.Param("id")
	var updates map[string]interface{}
	if err := c.ShouldBindJSON(&updates); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.PatchTeacher(id, updates); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to patch teacher"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Teacher updated"})
}
