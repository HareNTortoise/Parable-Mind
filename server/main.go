package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"

	"server/internal/firebase"
	"server/internal/routes"
	"server/internal/routes/questions"

	_ "server/internal/docs"

	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
)

// @title           Assignment API
// @version         1.0
// @description     API for managing assignments with different question types.
// @host            localhost:8080
// @BasePath        /

func main() {
	// Warm start: load env and initialize Firestore
	log.Println("🟡 Warming up server...")

	if err := godotenv.Load(); err != nil {
		log.Println("⚠️  .env file not found, using system environment variables")
	}

	firebase.InitFirestore()

	router := gin.Default()

	// Enable CORS
	router.Use(cors.Default())

	// Routes
	routes.RegisterAssignmentRoutes(router)
	routes.RegisterClassroomRoutes(router)
	routes.RegisterCommentRoutes(router)
	routes.RegisterPostRoutes(router)
	routes.RegisterQuestionBankRoutes(router)
	routes.RegisterStudentRoutes(router)
	routes.RegisterSubmissionRoutes(router)
	routes.RegisterTeacherRoutes(router)
	routes.RegisterVariableRoutes(router)
	questions.RegisterMCQRoutes(router)
	questions.RegisterMSQRoutes(router)

	router.GET("/docs/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
	router.GET("/health", func(c *gin.Context) {
		c.JSON(200, gin.H{"status": "ok"})
	})

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	addr := ":" + port

	// Startup logs
	fmt.Printf("✅ Server ready at:        http://localhost:%s\n", port)
	fmt.Printf("📘 Swagger docs at:        http://localhost:%s/docs/index.html\n", port)

	// Graceful shutdown support
	srv := &gin.Engine{}
	srv = router

	go func() {
		if err := srv.Run(addr); err != nil {
			log.Fatalf("❌ Server error: %v", err)
		}
	}()

	// Wait for termination signal (SIGINT, SIGTERM)
	quit := make(chan os.Signal, 1)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
	<-quit

	log.Println("🛑 Shutting down server gracefully...")

	_, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	// You can add shutdown logic here if needed (e.g., closing DB)
	log.Println("✅ Cleanup done. Exiting.")
}
