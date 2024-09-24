package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

// 		func fetchDataFromFlask() (string, error) {
// 			response, err := http.Get("http://localhost:5000/generate")
// 			if err != nil {
// 				return "", fmt.Errorf("failed to make request: %w", err)
// 			}
// 			defer response.Body.Close()

// 			if response.StatusCode != http.StatusOK {
// 				return "", fmt.Errorf("unexpected status code: %d", response.StatusCode)
// 			}

// 			body, err := ioutil.ReadAll(response.Body)
// 			if err != nil {
// 				return "", fmt.Errorf("failed to read response body: %w", err)
// 			}

// 			fmt.Printf("Response body: %s\n", body)  // Debugging output

// 			return string(body), nil
// 		}

// 		func handler(w http.ResponseWriter, r *http.Request) {
//     if r.Method == http.MethodGet {
//         data, err := fetchDataFromFlask()
//         if err != nil {
//             http.Error(w, err.Error(), http.StatusInternalServerError)
//             return
//         }

//         w.Header().Set("Content-Type", "text/plain")
//         w.Write([]byte(data))
//     } else {
//         http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
//     }
// }
func fetchDataFromFlask() (map[string]string, error) {
    response, err := http.Get("http://localhost:5000/generatesynonyms")
    if err != nil {
        return nil, fmt.Errorf("failed to make request: %w", err)
    }
    defer response.Body.Close()

    if response.StatusCode != http.StatusOK {
        return nil, fmt.Errorf("unexpected status code: %d", response.StatusCode)
    }

    body, err := ioutil.ReadAll(response.Body)
    if err != nil {
        return nil, fmt.Errorf("failed to read response body: %w", err)
    }

    var data map[string]string
    if err := json.Unmarshal(body, &data); err != nil {
        return nil, fmt.Errorf("failed to unmarshal JSON: %w", err)
    }

    return data, nil
}

func handler(w http.ResponseWriter, r *http.Request) {
    if r.Method == http.MethodGet {
        data, err := fetchDataFromFlask()
        if err != nil {
            http.Error(w, err.Error(), http.StatusInternalServerError)
            return
        }

        w.Header().Set("Content-Type", "application/json")
        json.NewEncoder(w).Encode(data)
    } else {
        http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
    }
}


		func main() {
			http.HandleFunc("/fetch-data", handler)
			
			fmt.Println("Go server is listening on port 8081...")
			if err := http.ListenAndServe(":8081", nil); err != nil {
				log.Fatalf("Failed to start server: %v", err)
			}
		}
