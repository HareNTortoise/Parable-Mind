package controller

import (
	"net/http"
	"server/internal/model"
	"server/internal/service"

	"github.com/gin-gonic/gin"
)

// @Summary Create Variable
// @Tags Variables
// @Accept json
// @Produce json
// @Param variable body model.Variable true "Variable JSON"
// @Success 201 {object} model.Variable
// @Router /variables [post]
func CreateVariable(c *gin.Context) {
	var v model.Variable
	if err := c.ShouldBindJSON(&v); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.CreateVariable(v); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create"})
		return
	}
	c.JSON(http.StatusCreated, v)
}

// @Summary Get Variable by ID
// @Tags Variables
// @Produce json
// @Param id path string true "Variable ID"
// @Success 200 {object} model.Variable
// @Router /variables/{id} [get]
func GetVariable(c *gin.Context) {
	id := c.Param("id")
	v, err := service.GetVariable(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Not found"})
		return
	}
	c.JSON(http.StatusOK, v)
}

// @Summary Delete Variable
// @Tags Variables
// @Param id path string true "Variable ID"
// @Success 200 {object} map[string]string
// @Router /variables/{id} [delete]
func DeleteVariable(c *gin.Context) {
	id := c.Param("id")
	if err := service.DeleteVariable(id); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Deleted"})
}

// @Summary Get all Variables
// @Tags Variables
// @Param limit query string false "Limit"
// @Param offset query string false "Offset"
// @Success 200 {array} model.Variable
// @Router /variables [get]
func GetAllVariables(c *gin.Context) {
	filters := map[string]string{
		"limit":  c.DefaultQuery("limit", "10"),
		"offset": c.DefaultQuery("offset", "0"),
	}
	items, err := service.GetAllVariables(filters)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch"})
		return
	}
	c.JSON(http.StatusOK, items)
}

// @Summary Update Variable
// @Tags Variables
// @Accept json
// @Produce json
// @Param id path string true "ID"
// @Param variable body model.Variable true "Variable"
// @Success 200 {object} model.Variable
// @Router /variables/{id} [put]
func UpdateVariable(c *gin.Context) {
	id := c.Param("id")
	var v model.Variable
	if err := c.ShouldBindJSON(&v); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.UpdateVariable(id, v); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Update failed"})
		return
	}
	c.JSON(http.StatusOK, v)
}

// @Summary Patch Variable
// @Tags Variables
// @Accept json
// @Produce json
// @Param id path string true "ID"
// @Param updates body map[string]interface{} true "Updates"
// @Success 200 {object} map[string]string
// @Router /variables/{id} [patch]
func PatchVariable(c *gin.Context) {
	id := c.Param("id")
	var updates map[string]interface{}
	if err := c.ShouldBindJSON(&updates); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.PatchVariable(id, updates); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Patch failed"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Updated"})
}
