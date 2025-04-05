package firebase

import (
	"context"
	"encoding/json"
	"log"
	"os"
	"strings"

	"cloud.google.com/go/firestore"
	"google.golang.org/api/option"
)

var Client *firestore.Client

func InitFirestore() {
	ctx := context.Background()

	privateKey := strings.ReplaceAll(os.Getenv("FIREBASE_PRIVATE_KEY"), `\\n`, "\n")

	cred := map[string]string{
		"type":                        os.Getenv("FIREBASE_TYPE"),
		"project_id":                  os.Getenv("FIREBASE_PROJECT_ID"),
		"private_key_id":              os.Getenv("FIREBASE_PRIVATE_KEY_ID"),
		"private_key":                 privateKey,
		"client_email":                os.Getenv("FIREBASE_CLIENT_EMAIL"),
		"client_id":                   os.Getenv("FIREBASE_CLIENT_ID"),
		"auth_uri":                    os.Getenv("FIREBASE_AUTH_URI"),
		"token_uri":                   os.Getenv("FIREBASE_TOKEN_URI"),
		"auth_provider_x509_cert_url": os.Getenv("FIREBASE_AUTH_PROVIDER_X509_CERT_URL"),
		"client_x509_cert_url":        os.Getenv("FIREBASE_CLIENT_X509_CERT_URL"),
	}

	credJSON, err := json.Marshal(cred)
	if err != nil {
		log.Fatalf("❌ Failed to marshal credentials: %v", err)
	}

	opt := option.WithCredentialsJSON(credJSON)
	projectID := os.Getenv("FIREBASE_PROJECT_ID")

	client, err := firestore.NewClient(ctx, projectID, opt)
	if err != nil {
		log.Fatalf("❌ Failed to initialize Firestore: %v", err)
	}

	Client = client
	log.Println("✅ Firestore initialized using ENV variables")
}
