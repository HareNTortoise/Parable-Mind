package main

import (
	"fmt"
	"log"
	"os"
	"os/signal"
	"syscall"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"

	"server/internal/firebase"
	"server/internal/routes"
	"server/internal/routes/questions"

	_ "server/internal/docs" // Swagger docs

	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
)

// @title           ParableMind API
// @version         1.0
// @description     Backend API for managing assignments, questions, classrooms and more.
// @host            localhost:8080
// @BasePath        /

func main() {
	log.Println("🟡 Warming up server...")

	// Load environment variables
	if err := godotenv.Load(); err != nil {
		log.Println("⚠️  .env file not found, using system environment variables")
	}

	// Initialize Firebase
	firebase.InitFirestore()

	// Setup Gin
	router := gin.Default()
	router.Use(cors.Default())

	// Register all routes
	registerRoutes(router)

	// Swagger & health check
	router.GET("/docs/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
	router.GET("/health", func(c *gin.Context) {
		c.JSON(200, gin.H{"status": "ok"})
	})

	// Get port from environment
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	address := ":" + port

	// Log endpoints
	fmt.Printf("✅ Server running at:       http://localhost:%s\n", port)
	fmt.Printf("📘 Swagger docs available:  http://localhost:%s/docs/index.html\n", port)

	// Run the server in a goroutine for graceful shutdown
	go func() {
		if err := router.Run(address); err != nil {
			log.Fatalf("❌ Server failed: %v", err)
		}
	}()

	// Graceful shutdown
	gracefulShutdown()
}

// registerRoutes registers all API routes.
func registerRoutes(router *gin.Engine) {
	// Core routes
	routes.RegisterAssignmentRoutes(router)
	routes.RegisterClassroomRoutes(router)
	routes.RegisterCommentRoutes(router)
	routes.RegisterPostRoutes(router)
	routes.RegisterQuestionBankRoutes(router)
	routes.RegisterStudentRoutes(router)
	routes.RegisterSubmissionRoutes(router)
	routes.RegisterTeacherRoutes(router)
	routes.RegisterVariableRoutes(router)

	// Question types
	questions.RegisterMCQRoutes(router)
	questions.RegisterMSQRoutes(router)
	questions.RegisterNATRoutes(router)
	questions.RegisterSubjectiveRoutes(router)
}

// gracefulShutdown listens for termination signals to cleanly shut down the server.
func gracefulShutdown() {
	quit := make(chan os.Signal, 1)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
	<-quit

	log.Println("🛑 Shutting down server...")

	// If you need cleanup logic (e.g., closing Firestore or DB), do it here.
	log.Println("✅ Server exited cleanly")
}
