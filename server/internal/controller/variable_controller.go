package controller

import (
	"net/http"
	"server/internal/model"
	"server/internal/service"

	"github.com/gin-gonic/gin"
)

// @Summary Create a variable
// @Tags Variables
// @Accept json
// @Produce json
// @Param variable body model.Variable true "Variable JSON"
// @Success 201 {object} model.Variable
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /variables [post]
func CreateVariable(c *gin.Context) {
	var v model.Variable
	if err := c.ShouldBindJSON(&v); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.CreateVariable(v); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create variable"})
		return
	}
	c.JSON(http.StatusCreated, v)
}

// @Summary Get a variable by ID
// @Tags Variables
// @Produce json
// @Param id path string true "Variable ID"
// @Success 200 {object} model.Variable
// @Failure 404 {object} map[string]string
// @Router /variables/{id} [get]
func GetVariable(c *gin.Context) {
	id := c.Param("id")
	v, err := service.GetVariable(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Variable not found"})
		return
	}
	c.JSON(http.StatusOK, v)
}

// @Summary Delete a variable
// @Tags Variables
// @Param id path string true "Variable ID"
// @Success 200 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /variables/{id} [delete]
func DeleteVariable(c *gin.Context) {
	id := c.Param("id")
	if err := service.DeleteVariable(id); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete variable"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Variable deleted"})
}

// @Summary Get all variables
// @Tags Variables
// @Param variableType query string false "Filter by variable type"
// @Param limit query string false "Pagination limit"
// @Param offset query string false "Pagination offset"
// @Success 200 {array} model.Variable
// @Failure 500 {object} map[string]string
// @Router /variables [get]
func GetAllVariables(c *gin.Context) {
	filters := map[string]string{
		"variableType": c.Query("variableType"),
		"limit":        c.DefaultQuery("limit", "10"),
		"offset":       c.DefaultQuery("offset", "0"),
	}
	variables, err := service.GetAllVariables(filters)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch variables"})
		return
	}
	c.JSON(http.StatusOK, variables)
}

// @Summary Update a variable
// @Tags Variables
// @Accept json
// @Produce json
// @Param id path string true "Variable ID"
// @Param variable body model.Variable true "Updated Variable"
// @Success 200 {object} model.Variable
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /variables/{id} [put]
func UpdateVariable(c *gin.Context) {
	id := c.Param("id")
	var v model.Variable
	if err := c.ShouldBindJSON(&v); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.UpdateVariable(id, v); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update variable"})
		return
	}
	c.JSON(http.StatusOK, v)
}

// @Summary Patch a variable
// @Tags Variables
// @Accept json
// @Produce json
// @Param id path string true "Variable ID"
// @Param updates body map[string]interface{} true "Fields to update"
// @Success 200 {object} map[string]string
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /variables/{id} [patch]
func PatchVariable(c *gin.Context) {
	id := c.Param("id")
	var updates map[string]interface{}
	if err := c.ShouldBindJSON(&updates); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.PatchVariable(id, updates); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to patch variable"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Variable updated"})
}
