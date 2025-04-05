package main

import (
	"fmt"
	"log"
	"os"

	"github.com/gin-contrib/cors"
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
	// Load env vars
	if err := godotenv.Load(); err != nil {
		log.Println("⚠️  .env file not found, relying on system environment variables")
	}

	// Initialize Firebase
	firebase.InitFirestore()

	// Setup Gin engine
	router := gin.Default()

	// ✅ Add CORS middleware
	router.Use(cors.New(cors.Config{
		AllowOrigins:     []string{"http://localhost:3000", "http://localhost:8080"},
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Authorization"},
		AllowCredentials: true,
	}))

	// Setup routes
	routes.SetupRoutes(router)

	// Swagger UI
	router.GET("/docs/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

	// Health check
	router.GET("/health", func(c *gin.Context) {
		c.JSON(200, gin.H{"status": "ok"})
	})

	// Start server
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	fmt.Printf("🚀 Server is running at:     http://localhost:%s\n", port)
	fmt.Printf("📘 Swagger documentation:    http://localhost:%s/docs/index.html\n", port)

	if err := router.Run(":" + port); err != nil {
		log.Fatalf("❌ Failed to start server: %v", err)
	}
}
