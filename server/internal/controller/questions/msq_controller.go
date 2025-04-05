package questions

import (
	"net/http"
	questionsModel "server/internal/model/questions"
	"server/internal/service/questions"

	"github.com/gin-gonic/gin"
)

// @Summary Create MSQ
// @Tags MSQs
// @Accept json
// @Produce json
// @Param msq body questions.MSQ true "MSQ JSON"
// @Success 201 {object} questions.MSQ
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /msqs [post]
func CreateMSQ(c *gin.Context) {
	var m questionsModel.MSQ
	if err := c.ShouldBindJSON(&m); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := questions.CreateMSQ(m); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create MSQ"})
		return
	}
	c.JSON(http.StatusCreated, m)
}

// @Summary Get MSQ by ID
// @Tags MSQs
// @Produce json
// @Param id path string true "MSQ ID"
// @Success 200 {object} questions.MSQ
// @Failure 404 {object} map[string]string
// @Router /msqs/{id} [get]
func GetMSQ(c *gin.Context) {
	id := c.Param("id")
	m, err := questions.GetMSQ(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "MSQ not found"})
		return
	}
	c.JSON(http.StatusOK, m)
}

// @Summary Delete MSQ
// @Tags MSQs
// @Param id path string true "MSQ ID"
// @Success 200 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /msqs/{id} [delete]
func DeleteMSQ(c *gin.Context) {
	id := c.Param("id")
	if err := questions.DeleteMSQ(id); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete MSQ"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "MSQ deleted"})
}

// @Summary Get all MSQs
// @Tags MSQs
// @Param bankId query string false "Filter by bank ID"
// @Param limit query string false "Pagination limit"
// @Param offset query string false "Pagination offset"
// @Success 200 {array} questions.MSQ
// @Failure 500 {object} map[string]string
// @Router /msqs [get]
func GetAllMSQs(c *gin.Context) {
	filters := map[string]string{
		"bankId": c.Query("bankId"),
		"limit":  c.DefaultQuery("limit", "10"),
		"offset": c.DefaultQuery("offset", "0"),
	}
	msqs, err := questions.GetAllMSQs(filters)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch MSQs"})
		return
	}
	c.JSON(http.StatusOK, msqs)
}

// @Summary Update MSQ
// @Tags MSQs
// @Accept json
// @Produce json
// @Param id path string true "MSQ ID"
// @Param msq body questions.MSQ true "Updated MSQ"
// @Success 200 {object} questions.MSQ
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /msqs/{id} [put]
func UpdateMSQ(c *gin.Context) {
	id := c.Param("id")
	var m questionsModel.MSQ
	if err := c.ShouldBindJSON(&m); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := questions.UpdateMSQ(id, m); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update MSQ"})
		return
	}
	c.JSON(http.StatusOK, m)
}

// @Summary Patch MSQ
// @Tags MSQs
// @Accept json
// @Produce json
// @Param id path string true "MSQ ID"
// @Param updates body map[string]interface{} true "Fields to update"
// @Success 200 {object} map[string]string
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /msqs/{id} [patch]
func PatchMSQ(c *gin.Context) {
	id := c.Param("id")
	var updates map[string]interface{}
	if err := c.ShouldBindJSON(&updates); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := questions.PatchMSQ(id, updates); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to patch MSQ"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "MSQ updated"})
}
