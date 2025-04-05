// main.go (entry point)
package main

import (
	"log"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"

	"server/internal/firebase"
	"server/internal/routes"

	_ "server/internal/docs" // Swagger docs import

	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
)

// @title           Assignment API
// @version         1.0
// @description     API for managing assignments with different question types.
// @host            localhost:8080
// @BasePath        /

func main() {
	_ = godotenv.Load()
	firebase.InitFirestore()

	r := gin.Default()
	routes.SetupRoutes(r)

	// Swagger UI endpoint
	r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

	// Health check
	r.GET("/health", func(c *gin.Context) {
		c.JSON(200, gin.H{"status": "ok"})
	})

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	log.Println("🚀 Server running on port:", port)
	r.Run(":" + port)
}
