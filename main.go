package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"os/exec"
)

const imagePath = "output.png"

type generateBody struct {
	Line1 string
	Line2 string
}

func main() {

	fs := http.FileServer(http.Dir("public"))
	http.Handle("/", fs)

	http.HandleFunc("/output.png", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != "GET" {
			w.WriteHeader(404)
			return
		}

		// TODO - result of this might be being cached?
		http.ServeFile(w, r, imagePath)
	})

	http.HandleFunc("/generate", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != "POST" {
			w.WriteHeader(404)
			return
		}

		decoder := json.NewDecoder(r.Body)
		var t generateBody
		err := decoder.Decode(&t)
		if err != nil {
			w.WriteHeader(500)
			fmt.Fprintf(w, "failed to decode payload")
			return
		}

		// validate payload
		if t.Line1 == "" && t.Line2 == "" {
			w.WriteHeader(422)
			fmt.Fprintf(w, "no text defined")
			return
		}

		cmd := exec.Command("./generate.sh", t.Line1, t.Line2)

		// Print output
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr

		err = cmd.Run()
		if err != nil {
			fmt.Printf("Generation failed: %s\n", err)
			w.WriteHeader(500)
			fmt.Fprintf(w, "failed to generate")
		} else {
			fmt.Println("Generation completed")
			fmt.Fprintf(w, "done")
		}
	})

	http.HandleFunc("/upload", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != "POST" {
			w.WriteHeader(404)
			return
		}

		cmd := exec.Command("./upload.sh")

		// Print output
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr

		fmt.Println("Starting upload")
		err := cmd.Run()
		if err != nil {
			fmt.Printf("Upload failed: %s\n", err)
			w.WriteHeader(500)
			fmt.Fprintf(w, "failed to upload")
		} else {
			fmt.Println("Upload completed")
			fmt.Fprintf(w, "done")
		}
	})

	fmt.Println("Starting server")
	http.ListenAndServe(":8080", nil)
}
