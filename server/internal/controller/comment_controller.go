package controller

import (
	"net/http"
	"server/internal/model"
	"server/internal/service"

	"github.com/gin-gonic/gin"
)

// @Summary Create a comment
// @Tags Comments
// @Accept json
// @Produce json
// @Param comment body model.Comment true "Comment JSON"
// @Success 201 {object} model.Comment
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /comments [post]
func CreateComment(c *gin.Context) {
	var comment model.Comment
	if err := c.ShouldBindJSON(&comment); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.CreateComment(comment); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create comment"})
		return
	}
	c.JSON(http.StatusCreated, comment)
}

// @Summary Get a comment by ID
// @Tags Comments
// @Produce json
// @Param id path string true "Comment ID"
// @Success 200 {object} model.Comment
// @Failure 404 {object} map[string]string
// @Router /comments/{id} [get]
func GetComment(c *gin.Context) {
	id := c.Param("id")
	comment, err := service.GetComment(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Comment not found"})
		return
	}
	c.JSON(http.StatusOK, comment)
}

// @Summary Delete a comment
// @Tags Comments
// @Param id path string true "Comment ID"
// @Success 200 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /comments/{id} [delete]
func DeleteComment(c *gin.Context) {
	id := c.Param("id")
	if err := service.DeleteComment(id); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete comment"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Comment deleted"})
}

// @Summary Get all comments
// @Tags Comments
// @Success 200 {array} model.Comment
// @Failure 500 {object} map[string]string
// @Router /comments [get]
func GetAllComments(c *gin.Context) {
	comments, err := service.GetAllComments()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch comments"})
		return
	}
	c.JSON(http.StatusOK, comments)
}

// @Summary Update a comment
// @Tags Comments
// @Accept json
// @Produce json
// @Param id path string true "Comment ID"
// @Param comment body model.Comment true "Updated comment"
// @Success 200 {object} model.Comment
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /comments/{id} [put]
func UpdateComment(c *gin.Context) {
	id := c.Param("id")
	var comment model.Comment
	if err := c.ShouldBindJSON(&comment); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.UpdateComment(id, comment); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update comment"})
		return
	}
	c.JSON(http.StatusOK, comment)
}

// @Summary Patch a comment
// @Tags Comments
// @Accept json
// @Produce json
// @Param id path string true "Comment ID"
// @Param updates body map[string]interface{} true "Fields to update"
// @Success 200 {object} map[string]string
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /comments/{id} [patch]
func PatchComment(c *gin.Context) {
	id := c.Param("id")
	var updates map[string]interface{}
	if err := c.ShouldBindJSON(&updates); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.PatchComment(id, updates); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to patch comment"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Comment updated"})
}
