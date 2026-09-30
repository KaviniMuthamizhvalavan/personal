The flow is:

```text
User goal, skill chips and filters
    -> FastAPI validates the request
    -> Parse known skills, negations and the learning goal
    -> Detect a curated track, or use the user's chosen track
    -> If Track is Auto and the LLM is enabled: draft a track
    -> Validate the draft and connect its skills to catalog courses
    -> Search with BM25 and semantic matching
    -> Calculate skill gaps and build a learning path
    -> Personalize the recommended course order
    -> Fill the Honest Advisor templates
    -> Calculate Answer check values
    -> Return the response to the frontend
```

| File or area | Purpose |
|---|---|
| `data/raw/coursera_course_2024.csv` | Original course input. |
| `data/processed/courses.json` | Cleaned course records. |
| `data/processed/embeddings.npy` | One embedding per course. |
| `data/processed/course_ids.json` | Maps embedding rows to course IDs. |
| `data/processed/manifest.json` | Records versions, model details, counts and integrity checks. |
| `data/rules/goal_skills.json` | Track definitions, skill matching patterns and dependency rules. |
| `data/rules/skill_aliases.json` | Alternative names for skills. |
| `data/rules/course_prerequisites.json` | Reviewed prerequisites and their evidence. |
| `data/rules/course_overrides.json` | Manual corrections to course data. |



| Category                  | Technology Used               | Alternatives                      | Why Used                                                                   |
| ------------------------- | ----------------------------- | --------------------------------- | -------------------------------------------------------------------------- |
| **Dataset**               | Coursera (Hugging Face)       | Kaggle, edX, Udemy                | Provides ready-to-use course data with skills, ratings and descriptions.   |
| **Data Processing**       | Python, Pandas                | Polars, CSV module                | Simplifies data cleaning and preprocessing.                                |
| **Data Storage**          | JSON, NumPy                   | PostgreSQL, MongoDB               | Lightweight, easy to maintain and suitable for a small, read-only catalog. |
| **Backend**               | Python, FastAPI               | Flask, Django                     | Fast API development, built-in validation and automatic API documentation. |
| **API Server**            | Uvicorn                       | Gunicorn, Hypercorn               | Lightweight ASGI server compatible with FastAPI.                           |
| **Keyword Search**        | BM25                          | TF-IDF, Elasticsearch             | Efficient keyword matching, especially for technical terms.                |
| **Semantic Search**       | MiniLM, Sentence Transformers | BERT, OpenAI Embeddings           | Lightweight, fast and supports meaning-based search offline.               |
| **Vector Similarity**     | NumPy (Cosine Similarity)     | FAISS, Chroma, Qdrant             | Exact similarity search without additional infrastructure.                 |
| **Search Ranking**        | Reciprocal Rank Fusion (RRF)  | Weighted Score, Cross-Encoder     | Combines keyword and semantic rankings without score normalization.        |
| **Goal Parsing**          | Regex                         | spaCy, LLM                        | Fast, deterministic and handles known skills and negations.                |
| **Skill Mapping**         | JSON Skill Graph              | Neo4j, NetworkX                   | Simple to maintain and sufficient for the small skill graph.               |
| **Learning Path**         | Greedy Algorithm              | Dijkstra, A*                      | Fast, deterministic and easy to explain.                                   |
| **AI Track Generation**   | GPT-4o-mini                   | Gemini, Claude, Llama             | Generates custom skill tracks for goals beyond predefined tracks.          |
| **Confidence Estimation** | Logistic Regression (NumPy)   | Scikit-learn, Isotonic Regression | Estimates relevance probability with minimal dependencies.                 |
| **Feedback Storage**      | SQLite                        | PostgreSQL, MongoDB               | Lightweight, serverless and suitable for local feedback storage.           |
| **Frontend**              | React 19, TypeScript          | Vue, Angular, Svelte              | Reusable components and type safety for API responses.                     |
| **Build Tool**            | Vite                          | Webpack, Next.js                  | Fast development server and simple backend integration.                    |
| **UI Styling**            | Plain CSS                     | Tailwind, Bootstrap, Material UI  | Provides design flexibility with minimal dependencies.                     |
| **Testing**               | Pytest, FastAPI TestClient    | unittest, Postman                 | Enables automated API testing without running a separate server.           |
| **Evaluation**            | Precision@5, MRR@5, F1        | nDCG, Recall@K                    | Measures recommendation relevance, ranking and skill-gap accuracy.         |
