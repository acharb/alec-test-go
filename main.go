package main

import (
	"fmt"
	"net/http"
	"os"
)

func logRequest(r *http.Request) {
	uri := r.RequestURI
	method := r.Method
	fmt.Println("Got request!", method, uri)
}

func main() {

	// cmd := exec.Command("./start")
	// out, err := cmd.Output()
	// if err != nil {
	// 	panic(err)
	// }
	// fmt.Println("start bash output...")
	// fmt.Println(string(out))
	// fmt.Println("end bash output...")

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		logRequest(r)
		fmt.Fprintf(w, "Hello! you've requested %s\n", r.URL.Path)
	})

	port := os.Getenv("PORT")
	if port == "" {
		port = "80"
	}

	fmt.Printf("==> Server listening at %s \n", port)
	err = http.ListenAndServe(fmt.Sprintf(":%s", port), nil)
	if err != nil {
		panic(err)
	}
}
