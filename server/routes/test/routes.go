package test

import (
	"github.com/gin-gonic/gin"
	controller "server/controller/test"
)

func SetupRoutes() *gin.Engine {
	router := gin.Default()
	router.GET("/api/users", controller.GetUsers)
	return router
}
