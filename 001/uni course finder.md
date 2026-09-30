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
