package questions

import (
	"net/http"
	questionsModel "server/internal/model/questions"
	questionsService "server/internal/service/questions"

	"github.com/gin-gonic/gin"
)

// @Summary Create NAT
// @Tags NATs
// @Accept json
// @Produce json
// @Param nat body questions.NAT true "NAT JSON"
// @Success 201 {object} questions.NAT
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /nats [post]
func CreateNAT(c *gin.Context) {
	var n questionsModel.NAT
	if err := c.ShouldBindJSON(&n); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := questionsService.CreateNAT(n); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create NAT"})
		return
	}
	c.JSON(http.StatusCreated, n)
}

// @Summary Get NAT by ID
// @Tags NATs
// @Produce json
// @Param id path string true "NAT ID"
// @Success 200 {object} questions.NAT
// @Failure 404 {object} map[string]string
// @Router /nats/{id} [get]
func GetNAT(c *gin.Context) {
	id := c.Param("id")
	n, err := questionsService.GetNAT(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "NAT not found"})
		return
	}
	c.JSON(http.StatusOK, n)
}

// @Summary Delete NAT
// @Tags NATs
// @Param id path string true "NAT ID"
// @Success 200 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /nats/{id} [delete]
func DeleteNAT(c *gin.Context) {
	id := c.Param("id")
	if err := questionsService.DeleteNAT(id); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete NAT"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "NAT deleted"})
}

// @Summary Get all NATs
// @Tags NATs
// @Param bankId query string false "Filter by bank ID"
// @Param limit query string false "Pagination limit"
// @Param offset query string false "Pagination offset"
// @Success 200 {array} questions.NAT
// @Failure 500 {object} map[string]string
// @Router /nats [get]
func GetAllNATs(c *gin.Context) {
	filters := map[string]string{
		"bankId": c.Query("bankId"),
		"limit":  c.DefaultQuery("limit", "10"),
		"offset": c.DefaultQuery("offset", "0"),
	}
	nats, err := questionsService.GetAllNATs(filters)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch NATs"})
		return
	}
	c.JSON(http.StatusOK, nats)
}

// @Summary Update NAT
// @Tags NATs
// @Accept json
// @Produce json
// @Param id path string true "NAT ID"
// @Param nat body questions.NAT true "Updated NAT"
// @Success 200 {object} questions.NAT
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /nats/{id} [put]
func UpdateNAT(c *gin.Context) {
	id := c.Param("id")
	var n questionsModel.NAT
	if err := c.ShouldBindJSON(&n); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := questionsService.UpdateNAT(id, n); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update NAT"})
		return
	}
	c.JSON(http.StatusOK, n)
}

// @Summary Patch NAT
// @Tags NATs
// @Accept json
// @Produce json
// @Param id path string true "NAT ID"
// @Param updates body map[string]interface{} true "Fields to update"
// @Success 200 {object} map[string]string
// @Failure 400 {object} map[string]string
// @Failure 500 {object} map[string]string
// @Router /nats/{id} [patch]
func PatchNAT(c *gin.Context) {
	id := c.Param("id")
	var updates map[string]interface{}
	if err := c.ShouldBindJSON(&updates); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := questionsService.PatchNAT(id, updates); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to patch NAT"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "NAT updated"})
}
