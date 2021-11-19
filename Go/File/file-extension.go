package main

import (
	"fmt"
	"path/filepath"
)

func main() {
	// Get the file extension of a file
	fmt.Println(getFileExtension("assets/ignore/README.md"))
}

// Get the file extension of a file
func getFileExtension(path string) string {
	return filepath.Ext(path)
}
