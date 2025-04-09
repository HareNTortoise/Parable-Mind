# 🧠 Parable Mind  
_An AI-Powered Teaching Assistant for Indian Classrooms_

**Parable Mind** automates the grading of all question types—MCQ, MSQ, NAT, and Subjective—while generating personalized feedback for each student.  
Built to reduce teacher workload and enhance student learning outcomes, Parable Mind aligns with the vision of **UN SDG 4: Quality Education**.

---

## 🔍 Problem Statement

Teachers face:
- High student-teacher ratios  
- Limited time per student  
- Lack of tools for giving **individualised feedback**

This is even more challenging in under-resourced settings—leading to poorer student outcomes.

---

## 🎯 Our Solution

Parable Mind offers an AI-powered system to:
- ✅ **Auto-grade assignments** (MCQ, MSQ, NAT, Subjective)
- 🧠 **Generate AI-based feedback** using LLMs (OpenAI/Gemini)
- 📚 **Simplify assignment and question management**
- 📊 **Track student performance** *(coming soon)*

---

## ✨ Key Features

| Feature                        | Description                                                                 |
|-------------------------------|-----------------------------------------------------------------------------|
| 🔍 **Automated Grading**       | Objective questions are graded instantly; subjective answers are AI-reviewed. |
| 🧠 **AI Feedback Engine**      | Tailored feedback for every student—editable by teachers before finalising.   |
| 📁 **Assignment Management**   | Create, tag, and assign questions. Use variables or generate content via AI. |
| 🏫 **Classroom Management**    | Easily manage students, teachers, and assignment distribution.               |
| 📈 **Performance Insights**    | *(Planned)* Visual dashboards with adaptive learning insights.               |

---

## 🏗️ Tech Stack

| Layer            | Technology                           |
|------------------|---------------------------------------|
| **Frontend**      | Flutter Web                          |
| **Backend**       | Go, Firebase (Auth, Firestore)       |
| **Microservices** | Python (for grading, feedback)       |
| **AI Services**   | OpenAI / Gemini APIs *(Planned)*     |
| **Routing**       | GoRouter                             |
| **State Mgmt**    | Flutter Bloc                         |
| **UI Framework**  | Responsive Framework                 |

---

## 🧩 Architecture Overview

```
[ Users (Teachers/Students) ]
           ⬇️
  [ Flutter Web App (UI) ]
           ⬇️
     [ Firebase Auth ]
           ⬇️
  [ Firestore Database ]
           ⬇️
[ AI Microservices (Python/Node.js) ]
      ⬇️             ⬇️
 [ Auto-Grading ]   [ AI Feedback ]
           ⬇️
  [ Personalized Student Reports ]
```

---

## 💻 GitHub Repo

👉 [**Parable Mind – GitHub Repository**](https://github.com/HareNTortoise/Parable-Mind/)

---

## 🤝 Contributing

We welcome all contributions:  
- 💡 Suggest new features  
- 🐛 Report issues  
- 🚀 Fork & submit PRs

---

## 📜 License

This project is licensed under the **BSD 3-Clause License**.  
See the [`LICENSE`](./LICENSE) file for full details.

---

## 🌍 UN SDG Alignment

Parable Mind supports **UN Sustainable Development Goal 4**:  
> _“Ensure inclusive and equitable quality education and promote lifelong learning opportunities for all.”_

---
