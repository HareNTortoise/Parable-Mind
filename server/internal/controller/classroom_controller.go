package controller

import (
	"net/http"
	"server/internal/model"
	"server/internal/service"

	"github.com/gin-gonic/gin"
)

// @Summary Create Classroom
// @Tags Classrooms
// @Accept json
// @Produce json
// @Param classroom body model.Classroom true "Classroom JSON"
// @Success 201 {object} model.Classroom
// @Router /classrooms [post]
func CreateClassroom(c *gin.Context) {
	var cls model.Classroom
	if err := c.ShouldBindJSON(&cls); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.CreateClassroom(cls); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create classroom"})
		return
	}
	c.JSON(http.StatusCreated, cls)
}

// @Summary Get Classroom by ID
// @Tags Classrooms
// @Produce json
// @Param id path string true "Classroom ID"
// @Success 200 {object} model.Classroom
// @Router /classrooms/{id} [get]
func GetClassroom(c *gin.Context) {
	id := c.Param("id")
	cls, err := service.GetClassroom(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Classroom not found"})
		return
	}
	c.JSON(http.StatusOK, cls)
}

// @Summary Delete Classroom
// @Tags Classrooms
// @Param id path string true "Classroom ID"
// @Success 200 {object} map[string]string
// @Router /classrooms/{id} [delete]
func DeleteClassroom(c *gin.Context) {
	id := c.Param("id")
	if err := service.DeleteClassroom(id); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete classroom"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Classroom deleted"})
}

// @Summary Get all Classrooms
// @Tags Classrooms
// @Param limit query string false "Pagination limit"
// @Param offset query string false "Pagination offset"
// @Success 200 {array} model.Classroom
// @Router /classrooms [get]
func GetAllClassrooms(c *gin.Context) {
	filters := map[string]string{
		"limit":  c.DefaultQuery("limit", "10"),
		"offset": c.DefaultQuery("offset", "0"),
	}
	items, err := service.GetAllClassrooms(filters)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch classrooms"})
		return
	}
	c.JSON(http.StatusOK, items)
}

// @Summary Update Classroom
// @Tags Classrooms
// @Accept json
// @Produce json
// @Param id path string true "Classroom ID"
// @Param classroom body model.Classroom true "Updated Classroom"
// @Success 200 {object} model.Classroom
// @Router /classrooms/{id} [put]
func UpdateClassroom(c *gin.Context) {
	id := c.Param("id")
	var cls model.Classroom
	if err := c.ShouldBindJSON(&cls); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.UpdateClassroom(id, cls); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Update failed"})
		return
	}
	c.JSON(http.StatusOK, cls)
}

// @Summary Patch Classroom
// @Tags Classrooms
// @Accept json
// @Produce json
// @Param id path string true "Classroom ID"
// @Param updates body map[string]interface{} true "Fields to update"
// @Success 200 {object} map[string]string
// @Router /classrooms/{id} [patch]
func PatchClassroom(c *gin.Context) {
	id := c.Param("id")
	var updates map[string]interface{}
	if err := c.ShouldBindJSON(&updates); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.PatchClassroom(id, updates); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Patch failed"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Classroom updated"})
}
