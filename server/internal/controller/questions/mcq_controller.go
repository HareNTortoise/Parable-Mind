// controller/questions/mcq_controller.go
package questions

import (
	"net/http"
	"server/internal/model/questions"
	service "server/internal/service/questions"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

// @Summary Create MCQ
// @Tags MCQs
// @Accept json
// @Produce json
// @Param mcq body questions.MCQ true "MCQ JSON"
// @Success 201 {object} questions.MCQ
// @Router /mcqs [post]
func CreateMCQ(c *gin.Context) {
	var m questions.MCQ
	if err := c.ShouldBindJSON(&m); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	m.ID = uuid.New().String()
	if err := service.CreateMCQ(m); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create MCQ"})
		return
	}
	c.JSON(http.StatusCreated, m)
}

// @Summary Get MCQ by ID
// @Tags MCQs
// @Produce json
// @Param id path string true "MCQ ID"
// @Success 200 {object} questions.MCQ
// @Router /mcqs/{id} [get]
func GetMCQ(c *gin.Context) {
	id := c.Param("id")
	m, err := service.GetMCQ(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "MCQ not found"})
		return
	}
	c.JSON(http.StatusOK, m)
}

// @Summary Delete MCQ
// @Tags MCQs
// @Param id path string true "MCQ ID"
// @Success 200 {object} map[string]string
// @Router /mcqs/{id} [delete]
func DeleteMCQ(c *gin.Context) {
	id := c.Param("id")
	if err := service.DeleteMCQ(id); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete MCQ"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "MCQ deleted"})
}

// @Summary Get all MCQs
// @Tags MCQs
// @Param bankId query string false "Filter by bank ID"
// @Param limit query string false "Pagination limit"
// @Param offset query string false "Pagination offset"
// @Success 200 {array} questions.MCQ
// @Router /mcqs [get]
func GetAllMCQs(c *gin.Context) {
	filters := map[string]string{
		"bankId": c.Query("bankId"),
		"limit":  c.DefaultQuery("limit", "10"),
		"offset": c.DefaultQuery("offset", "0"),
	}
	mcqs, err := service.GetAllMCQs(filters)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch MCQs"})
		return
	}
	c.JSON(http.StatusOK, mcqs)
}

// @Summary Update MCQ
// @Tags MCQs
// @Accept json
// @Produce json
// @Param id path string true "MCQ ID"
// @Param mcq body questions.MCQ true "Updated MCQ"
// @Success 200 {object} questions.MCQ
// @Router /mcqs/{id} [put]
func UpdateMCQ(c *gin.Context) {
	id := c.Param("id")
	var m questions.MCQ
	if err := c.ShouldBindJSON(&m); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	m.ID = id
	if err := service.UpdateMCQ(id, m); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update MCQ"})
		return
	}
	c.JSON(http.StatusOK, m)
}

// @Summary Patch MCQ
// @Tags MCQs
// @Accept json
// @Produce json
// @Param id path string true "MCQ ID"
// @Param updates body map[string]interface{} true "Fields to update"
// @Success 200 {object} map[string]string
// @Router /mcqs/{id} [patch]
func PatchMCQ(c *gin.Context) {
	id := c.Param("id")
	var updates map[string]interface{}
	if err := c.ShouldBindJSON(&updates); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.PatchMCQ(id, updates); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to patch MCQ"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "MCQ updated"})
}

// @Summary Bulk Create MCQs
// @Tags MCQs
// @Accept json
// @Produce json
// @Param mcqs body []questions.MCQ true "List of MCQs"
// @Success 201 {array} questions.MCQ
// @Router /mcqs/bulk [post]
func CreateBulkMCQs(c *gin.Context) {
	var mcqs []questions.MCQ
	if err := c.ShouldBindJSON(&mcqs); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	for i := range mcqs {
		mcqs[i].ID = uuid.New().String()
	}

	if err := service.CreateBulkMCQs(mcqs); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create MCQs"})
		return
	}

	c.JSON(http.StatusCreated, mcqs)
}
