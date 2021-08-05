package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"os/exec"
)

type password struct {
	Password string `json:"password"`
}

func main() {
	http.HandleFunc("/execute", func(w http.ResponseWriter, r *http.Request) {
		if r.Method == "POST" {
			decoder := json.NewDecoder(r.Body)
			var pw password
			err := decoder.Decode(&pw)
			if nil != err {
				w.WriteHeader(500)
				_, _ = w.Write([]byte("failed decode password"))
				return
			}

			cmd := exec.Command("/bin/sh", "-c", "sudo ls")
			stdin, err := cmd.StdinPipe()
			if err != nil {
				log.Fatal(err)
			}

			go func() {
				defer stdin.Close()
				io.WriteString(stdin, pw.Password)
			}()

			out, err := cmd.CombinedOutput()
			if err != nil {
				log.Fatal(err)
			}

			fmt.Printf("%s\n", out)

			_, _ = w.Write([]byte("success"))
			return
		}
	})

	http.ListenAndServe(":9091", nil)
}
