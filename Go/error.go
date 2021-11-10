package main

import (
	"log"
	"os"
)

var (
	err error
)

func main() {
	// Handle all errors in a single unified way.
	err = os.Remove("/tmp/file")
	handleAllErrors(err)
	// Handle errors case by case.
	err = os.Remove("/tmp/file")
	if err != nil {
		log.Println(err)
	}
}

// Handle all errors in a single unified way.
func handleAllErrors(err error) {
	if err != nil {
		log.Println(err)
	}
}

/* Note: There are alternative ways to handle errors in Go,
but they aren't encouraged since they complicate the code and make it less understandable.
*/
