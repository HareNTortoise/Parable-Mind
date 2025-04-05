package routes

import (
	"server/internal/controller"

	"github.com/gin-gonic/gin"
)

func RegisterPostRoutes(r *gin.Engine) {
	post := r.Group("/posts")
	{
		post.GET("", controller.GetAllPosts)
		post.GET(":id", controller.GetPost)
		post.POST("", controller.CreatePost)
		post.PUT(":id", controller.UpdatePost)
		post.PATCH(":id", controller.PatchPost)
		post.DELETE(":id", controller.DeletePost)
	}
}
