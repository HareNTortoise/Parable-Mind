package controller

import (
	"net/http"
	"server/internal/model"
	"server/internal/service"

	"github.com/gin-gonic/gin"
)

// @Summary Create a post
// @Tags Posts
// @Accept json
// @Produce json
// @Param post body model.Post true "Post JSON"
// @Success 201 {object} model.Post
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /posts [post]
func CreatePost(c *gin.Context) {
	var post model.Post
	if err := c.ShouldBindJSON(&post); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.CreatePost(post); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create post"})
		return
	}
	c.JSON(http.StatusCreated, post)
}

// @Summary Get a post by ID
// @Tags Posts
// @Produce json
// @Param id path string true "Post ID"
// @Success 200 {object} model.Post
// @Failure 404 {object} map[string]string
// @Router /posts/{id} [get]
func GetPost(c *gin.Context) {
	id := c.Param("id")
	post, err := service.GetPost(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Post not found"})
		return
	}
	c.JSON(http.StatusOK, post)
}

// @Summary Delete a post
// @Tags Posts
// @Param id path string true "Post ID"
// @Success 200 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /posts/{id} [delete]
func DeletePost(c *gin.Context) {
	id := c.Param("id")
	if err := service.DeletePost(id); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete post"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Post deleted"})
}

// @Summary Get all posts
// @Tags Posts
// @Success 200 {array} model.Post
// @Failure 500 {object} map[string]string
// @Router /posts [get]
func GetAllPosts(c *gin.Context) {
	posts, err := service.GetAllPosts()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch posts"})
		return
	}
	c.JSON(http.StatusOK, posts)
}

// @Summary Update a post
// @Tags Posts
// @Accept json
// @Produce json
// @Param id path string true "Post ID"
// @Param post body model.Post true "Updated post"
// @Success 200 {object} model.Post
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /posts/{id} [put]
func UpdatePost(c *gin.Context) {
	id := c.Param("id")
	var post model.Post
	if err := c.ShouldBindJSON(&post); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.UpdatePost(id, post); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update post"})
		return
	}
	c.JSON(http.StatusOK, post)
}

// @Summary Patch a post
// @Tags Posts
// @Accept json
// @Produce json
// @Param id path string true "Post ID"
// @Param updates body map[string]interface{} true "Fields to update"
// @Success 200 {object} map[string]string
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /posts/{id} [patch]
func PatchPost(c *gin.Context) {
	id := c.Param("id")
	var updates map[string]interface{}
	if err := c.ShouldBindJSON(&updates); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.PatchPost(id, updates); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to patch post"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Post updated"})
}
