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
