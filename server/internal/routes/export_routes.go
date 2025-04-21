package routes

import (
	"server/internal/controller"

	"github.com/gin-gonic/gin"
)

func RegisterExportRoutes(r *gin.Engine) {
	r.POST("/generate-pdf", controller.GenerateQuestionPDF)
}
