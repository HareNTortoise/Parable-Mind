package routes

import (
	"server/internal/controller"

	"github.com/gin-gonic/gin"
)

func RegisterQuestionBankRoutes(r *gin.Engine) {
	qb := r.Group("/questionbanks")
	{
		qb.GET("", controller.GetAllQuestionBanks)
		qb.GET(":id", controller.GetQuestionBank)
		qb.POST("", controller.CreateQuestionBank)
		qb.PUT(":id", controller.UpdateQuestionBank)
		qb.PATCH(":id", controller.PatchQuestionBank)
		qb.DELETE(":id", controller.DeleteQuestionBank)
	}
}
