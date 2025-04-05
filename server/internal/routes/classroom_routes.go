package routes

import (
	"server/internal/controller"

	"github.com/gin-gonic/gin"
)

func RegisterClassroomRoutes(r *gin.Engine) {
	classroom := r.Group("/classrooms")
	{
		classroom.GET("", controller.GetAllClassrooms)
		classroom.GET(":id", controller.GetClassroom)
		classroom.POST("", controller.CreateClassroom)
		classroom.PUT(":id", controller.UpdateClassroom)
		classroom.PATCH(":id", controller.PatchClassroom)
		classroom.DELETE(":id", controller.DeleteClassroom)
	}
}
