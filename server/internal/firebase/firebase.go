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

func createFirebaseCredentialsFromEnv() []byte {
	privateKey := os.Getenv("FIREBASE_PRIVATE_KEY")

	// Convert \\n (escaped newlines) to real \n
	privateKey = strings.ReplaceAll(privateKey, `\n`, "\n")

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
		"universe_domain":             "googleapis.com",
	}

	credJSON, err := json.Marshal(cred)
	if err != nil {
		log.Fatalf("❌ Failed to marshal Firebase credentials: %v", err)
	}
	return credJSON
}

func InitFirestore() {
	log.Println("🟡 Warming up Firestore...")

	ctx := context.Background()
	creds := option.WithCredentialsJSON(createFirebaseCredentialsFromEnv())

	client, err := firestore.NewClient(ctx, os.Getenv("FIREBASE_PROJECT_ID"), creds)
	if err != nil {
		log.Fatalf("❌ Failed to initialize Firestore: %v", err)
	}

	Client = client
	log.Println("✅ Firestore initialized using ENV variables")
}
