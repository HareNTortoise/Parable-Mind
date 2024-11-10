package utils

import (
	"net/http"
	"github.com/gin-gonic/gin"
)

// JSONResponse sends a JSON response with a 200 OK status
func JSONResponse(c *gin.Context, data interface{}) {
	c.JSON(http.StatusOK, data)
}
