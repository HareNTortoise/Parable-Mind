package controller

import (
	"net/http"
	"server/internal/model"
	"server/internal/service"

	"github.com/gin-gonic/gin"
)

// @Summary Create a question bank
// @Tags QuestionBank
// @Accept json
// @Produce json
// @Param questionbank body model.QuestionBank true "QuestionBank JSON"
// @Success 201 {object} model.QuestionBank
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /questionbanks [post]
func CreateQuestionBank(c *gin.Context) {
	var qb model.QuestionBank
	if err := c.ShouldBindJSON(&qb); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.CreateQuestionBank(qb); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create question bank"})
		return
	}
	c.JSON(http.StatusCreated, qb)
}

// @Summary Get a question bank by ID
// @Tags QuestionBank
// @Produce json
// @Param id path string true "QuestionBank ID"
// @Success 200 {object} model.QuestionBank
// @Failure 404 {object} map[string]string
// @Router /questionbanks/{id} [get]
func GetQuestionBank(c *gin.Context) {
	id := c.Param("id")
	qb, err := service.GetQuestionBank(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Question bank not found"})
		return
	}
	c.JSON(http.StatusOK, qb)
}

// @Summary Delete a question bank
// @Tags QuestionBank
// @Param id path string true "QuestionBank ID"
// @Success 200 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /questionbanks/{id} [delete]
func DeleteQuestionBank(c *gin.Context) {
	id := c.Param("id")
	if err := service.DeleteQuestionBank(id); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete question bank"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Question bank deleted"})
}

// @Summary Get all question banks
// @Tags QuestionBank
// @Param chapter query string false "Filter by chapter"
// @Param topic query string false "Filter by topic"
// @Param limit query string false "Pagination limit"
// @Param offset query string false "Pagination offset"
// @Success 200 {array} model.QuestionBank
// @Failure 500 {object} map[string]string
// @Router /questionbanks [get]
func GetAllQuestionBanks(c *gin.Context) {
	filters := map[string]string{
		"chapter": c.Query("chapter"),
		"topic":   c.Query("topic"),
		"limit":   c.DefaultQuery("limit", "10"),
		"offset":  c.DefaultQuery("offset", "0"),
	}
	banks, err := service.GetAllQuestionBanks(filters)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch question banks"})
		return
	}
	c.JSON(http.StatusOK, banks)
}

// @Summary Update a question bank
// @Tags QuestionBank
// @Accept json
// @Produce json
// @Param id path string true "QuestionBank ID"
// @Param questionbank body model.QuestionBank true "Updated QuestionBank"
// @Success 200 {object} model.QuestionBank
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /questionbanks/{id} [put]
func UpdateQuestionBank(c *gin.Context) {
	id := c.Param("id")
	var qb model.QuestionBank
	if err := c.ShouldBindJSON(&qb); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.UpdateQuestionBank(id, qb); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update question bank"})
		return
	}
	c.JSON(http.StatusOK, qb)
}

// @Summary Patch a question bank
// @Tags QuestionBank
// @Accept json
// @Produce json
// @Param id path string true "QuestionBank ID"
// @Param updates body map[string]interface{} true "Fields to update"
// @Success 200 {object} map[string]string
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /questionbanks/{id} [patch]
func PatchQuestionBank(c *gin.Context) {
	id := c.Param("id")
	var updates map[string]interface{}
	if err := c.ShouldBindJSON(&updates); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.PatchQuestionBank(id, updates); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to patch question bank"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Question bank updated"})
}
