package controller

import (
	"net/http"
	"server/internal/model"
	"server/internal/service"

	"github.com/gin-gonic/gin"
)

// @Summary      Create a new assignment
// @Description  Creates a new assignment with optional question types
// @Tags         Assignments
// @Accept       json
// @Produce      json
// @Param        assignment  body      model.Assignment  true  "Assignment JSON"
// @Success      201         {object}  model.Assignment
// @Failure      400         {object}  map[string]string
// @Failure      500         {object}  map[string]string
// @Router       /assignments [post]
func CreateAssignment(c *gin.Context) {
	var a model.Assignment
	if err := c.ShouldBindJSON(&a); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := service.CreateAssignment(a); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create"})
		return
	}
	c.JSON(http.StatusCreated, a)
}

// @Summary      Get a single assignment
// @Description  Get an assignment by its ID
// @Tags         Assignments
// @Accept       json
// @Produce      json
// @Param        id   path      string  true  "Assignment ID"
// @Success      200  {object}  model.Assignment
// @Failure      404  {object}  map[string]string
// @Router       /assignments/{id} [get]
func GetAssignment(c *gin.Context) {
	id := c.Param("id")
	a, err := service.GetAssignment(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Assignment not found"})
		return
	}
	c.JSON(http.StatusOK, a)
}

// @Summary      Delete an assignment
// @Description  Delete an assignment by ID
// @Tags         Assignments
// @Accept       json
// @Produce      json
// @Param        id   path      string  true  "Assignment ID"
// @Success      200  {object}  map[string]string
// @Failure      500  {object}  map[string]string
// @Router       /assignments/{id} [delete]
func DeleteAssignment(c *gin.Context) {
	id := c.Param("id")
	err := service.DeleteAssignment(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Assignment deleted"})
}

// @Summary      Update an assignment
// @Description  Update assignment fields by ID
// @Tags         Assignments
// @Accept       json
// @Produce      json
// @Param        id          path      string            true  "Assignment ID"
// @Param        assignment  body      model.Assignment  true  "Updated assignment"
// @Success      200         {object}  model.Assignment
// @Failure      400         {object}  map[string]string
// @Failure      500         {object}  map[string]string
// @Router       /assignments/{id} [put]
func UpdateAssignment(c *gin.Context) {
	id := c.Param("id")
	var updated model.Assignment
	if err := c.ShouldBindJSON(&updated); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	updated.ID = id
	if err := service.UpdateAssignment(id, updated); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Update failed"})
		return
	}
	c.JSON(http.StatusOK, updated)
}

// @Summary      List assignments with filters and pagination
// @Description  Get all assignments (filter by points, dueDate; paginate using limit/offset)
// @Tags         Assignments
// @Accept       json
// @Produce      json
// @Param        points   query     int     false  "Filter by points"
// @Param        dueDate  query     string  false  "Filter by dueDate (RFC3339 format)"
// @Param        limit    query     int     false  "Limit results"
// @Param        offset   query     int     false  "Offset results"
// @Success      200      {array}   model.Assignment
// @Failure      500      {object}  map[string]string
// @Router       /assignments [get]
func GetAllAssignments(c *gin.Context) {
	limit := c.DefaultQuery("limit", "10")
	offset := c.DefaultQuery("offset", "0")
	points := c.Query("points")
	due := c.Query("dueDate")

	assignments, err := service.FilterAssignments(limit, offset, points, due)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch assignments"})
		return
	}
	c.JSON(http.StatusOK, assignments)
}
