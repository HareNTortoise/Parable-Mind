# 🧠 Parable Mind  
_An AI-powered assistant to automate grading and feedback for Indian classrooms_

Parable Mind helps teachers save time and improve student outcomes by automating assignment grading, providing AI-driven feedback, and streamlining academic workflows.

---

## 🚨 The Problem

Teachers are overwhelmed:
- High student-teacher ratios
- Time-consuming grading
- Limited individualised feedback

This is especially challenging in under-resourced schools.

---

## ✅ The Solution

Parable Mind empowers teachers with:
- 📝 **Auto-grading** of MCQ, MSQ, NAT, and Subjective questions  
- 💡 **AI-generated feedback** personalised to each student  
- 📚 **Simplified assignment and classroom management**  
- 📈 **(Coming soon)** Student performance tracking dashboards

---

## ✨ Core Features

- 🧠 **AI Feedback Engine** — Uses LLMs (OpenAI/Gemini) to draft feedback  
- ⚙️ **Assignment Builder** — Create questions, tag topics, add variables  
- 🚀 **One-click Grading** — Review and finalise AI-generated marks + comments  
- 🏫 **Teacher Tools** — Manage classes, track students, collaborate with staff  
- 📊 **Performance Insights** — (Planned) Adaptive insights and trends

---

## 🧩 Architecture Overview

```
[ Flutter Web App ]
       ⬇️
[ Firebase Auth & Firestore ]
       ⬇️
[ Go Backend API ] <--> [ AI Microservice (FastAPI) ]
       ⬇️
[ PDF Reports | Feedback | Dashboard Views ]
```

---

## ⚙️ Tech Stack

| Layer         | Tech                                     |
|--------------|-------------------------------------------|
| Frontend      | Flutter Web (GoRouter + BLoC)            |
| Backend       | Go, Gin, Firebase (Firestore, Auth)      |
| AI Service    | Python, FastAPI, OpenAI/Gemini API       |
| Docs          | Swagger (Swaggo), Postman                |
| Infra         | .env-based local dev, container-ready    |

---

## 📦 Backend API (Go + Firebase)

- Full CRUD for: Assignments, Students, Teachers, Submissions, Questions (MCQ, MSQ, NAT, Subjective)
- Generates PDF reports using `wkhtmltopdf`
- Structured MVC-style layout
- Swagger docs & Postman collections included

**Run locally:**

```bash
make run
# or manually:
swag init --output ./internal/docs
go run cmd/server/main.go
```

**API Docs:**  
- Swagger UI: `http://localhost:8080/docs`  
- Sample `.env` included in `/server`

---

## 🤖 AI Microservice (FastAPI)

- Grades Subjective/NAT answers
- Generates student feedback using LLMs
- Logs saved to `ai_microservice.log`

**Run locally:**

```bash
pip install -r requirements.txt
uvicorn main:app --host 0.0.0.0 --port 8000
```

**Docs:**  
- Swagger UI: `http://localhost:8000/docs`  
- ReDoc: `http://localhost:8000/redoc`

---

## 🤝 Contributing

We welcome all contributions!

- 💡 Feature suggestions  
- 🐛 Bug reports  
- 📦 PRs and refactors  
- 📚 Documentation fixes

---

## 🌍 UN SDG Alignment

Parable Mind aligns with **UN Sustainable Development Goal 4**:  
> _“Ensure inclusive and equitable quality education and promote lifelong learning opportunities for all.”_