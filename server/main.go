package main

import (
	"fmt"
	routes "server/routes/test"
)

func main() {
	router := routes.SetupRoutes()

	port := ":8080"
	fmt.Printf("Server running on http://localhost%s\n", port)
	router.Run(port)
}
