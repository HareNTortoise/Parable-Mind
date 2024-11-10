package test

import (
	models "server/models/test"
	"server/utils"
	"github.com/gin-gonic/gin"
)

// GetUsers responds with a list of users in JSON format
func GetUsers(c *gin.Context) {
	users := []models.User{
		{ID: 1, Name: "John Doe", Email: "john@example.com"},
		{ID: 2, Name: "Jane Smith", Email: "jane@example.com"},
	}
	utils.JSONResponse(c, users)
}
