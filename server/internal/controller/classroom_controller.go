package controller

import (
	"net/http"
	"server/internal/model"
	"server/internal/service"

	"github.com/gin-gonic/gin"
)

// @Summary Create a classroom
// @Tags Classrooms
// @Accept json
// @Produce json
// @Param classroom body model.Classroom true "Classroom JSON"
// @Success 201 {object} model.Classroom
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /classrooms [post]
func CreateClassroom(c *gin.Context) {
	var classroom model.Classroom
	if err := c.ShouldBindJSON(&classroom); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.CreateClassroom(classroom); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create classroom"})
		return
	}
	c.JSON(http.StatusCreated, classroom)
}

// @Summary Get a classroom by ID
// @Tags Classrooms
// @Produce json
// @Param id path string true "Classroom ID"
// @Success 200 {object} model.Classroom
// @Failure 404 {object} map[string]string
// @Router /classrooms/{id} [get]
func GetClassroom(c *gin.Context) {
	id := c.Param("id")
	classroom, err := service.GetClassroom(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Classroom not found"})
		return
	}
	c.JSON(http.StatusOK, classroom)
}

// @Summary Delete a classroom
// @Tags Classrooms
// @Param id path string true "Classroom ID"
// @Success 200 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /classrooms/{id} [delete]
func DeleteClassroom(c *gin.Context) {
	id := c.Param("id")
	if err := service.DeleteClassroom(id); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete classroom"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Classroom deleted"})
}

// @Summary Get all classrooms
// @Tags Classrooms
// @Success 200 {array} model.Classroom
// @Failure 500 {object} map[string]string
// @Router /classrooms [get]
func GetAllClassrooms(c *gin.Context) {
	classrooms, err := service.GetAllClassrooms()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch classrooms"})
		return
	}
	c.JSON(http.StatusOK, classrooms)
}

// @Summary Update a classroom
// @Tags Classrooms
// @Accept json
// @Produce json
// @Param id path string true "Classroom ID"
// @Param classroom body model.Classroom true "Updated classroom"
// @Success 200 {object} model.Classroom
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /classrooms/{id} [put]
func UpdateClassroom(c *gin.Context) {
	id := c.Param("id")
	var classroom model.Classroom
	if err := c.ShouldBindJSON(&classroom); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.UpdateClassroom(id, classroom); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update classroom"})
		return
	}
	c.JSON(http.StatusOK, classroom)
}

// @Summary Patch a classroom
// @Tags Classrooms
// @Accept json
// @Produce json
// @Param id path string true "Classroom ID"
// @Param updates body map[string]interface{} true "Fields to update"
// @Success 200 {object} map[string]string
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /classrooms/{id} [patch]
func PatchClassroom(c *gin.Context) {
	id := c.Param("id")
	var updates map[string]interface{}
	if err := c.ShouldBindJSON(&updates); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.PatchClassroom(id, updates); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to patch classroom"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Classroom updated"})
}
