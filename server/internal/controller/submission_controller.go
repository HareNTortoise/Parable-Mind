package controller

import (
	"net/http"
	"server/internal/model"
	"server/internal/service"

	"github.com/gin-gonic/gin"
)

// @Summary Create a submission
// @Tags Submissions
// @Accept json
// @Produce json
// @Param submission body model.Submission true "Submission JSON"
// @Success 201 {object} model.Submission
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /submissions [post]
func CreateSubmission(c *gin.Context) {
	var s model.Submission
	if err := c.ShouldBindJSON(&s); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.CreateSubmission(s); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create submission"})
		return
	}
	c.JSON(http.StatusCreated, s)
}

// @Summary Get a submission by ID
// @Tags Submissions
// @Produce json
// @Param id path string true "Submission ID"
// @Success 200 {object} model.Submission
// @Failure 404 {object} map[string]string
// @Router /submissions/{id} [get]
func GetSubmission(c *gin.Context) {
	id := c.Param("id")
	s, err := service.GetSubmission(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Submission not found"})
		return
	}
	c.JSON(http.StatusOK, s)
}

// @Summary Delete a submission
// @Tags Submissions
// @Param id path string true "Submission ID"
// @Success 200 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /submissions/{id} [delete]
func DeleteSubmission(c *gin.Context) {
	id := c.Param("id")
	if err := service.DeleteSubmission(id); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete submission"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Submission deleted"})
}

// @Summary Get all submissions
// @Tags Submissions
// @Param studentId query string false "Filter by student ID"
// @Param assignmentId query string false "Filter by assignment ID"
// @Success 200 {array} model.Submission
// @Failure 500 {object} map[string]string
// @Router /submissions [get]
func GetAllSubmissions(c *gin.Context) {
	filters := map[string]string{
		"studentId":    c.Query("studentId"),
		"assignmentId": c.Query("assignmentId"),
	}
	submissions, err := service.GetAllSubmissions(filters)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch submissions"})
		return
	}
	c.JSON(http.StatusOK, submissions)
}

// @Summary Update a submission
// @Tags Submissions
// @Accept json
// @Produce json
// @Param id path string true "Submission ID"
// @Param submission body model.Submission true "Updated Submission"
// @Success 200 {object} model.Submission
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /submissions/{id} [put]
func UpdateSubmission(c *gin.Context) {
	id := c.Param("id")
	var s model.Submission
	if err := c.ShouldBindJSON(&s); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.UpdateSubmission(id, s); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update submission"})
		return
	}
	c.JSON(http.StatusOK, s)
}

// @Summary Patch a submission
// @Tags Submissions
// @Accept json
// @Produce json
// @Param id path string true "Submission ID"
// @Param updates body map[string]interface{} true "Fields to update"
// @Success 200 {object} map[string]string
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /submissions/{id} [patch]
func PatchSubmission(c *gin.Context) {
	id := c.Param("id")
	var updates map[string]interface{}
	if err := c.ShouldBindJSON(&updates); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.PatchSubmission(id, updates); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to patch submission"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Submission updated"})
}
