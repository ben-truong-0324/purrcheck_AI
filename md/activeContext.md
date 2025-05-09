# Active Context: Purr Check AI

**Project Name:** Purr Check AI

**Date:** May 8, 2025

**Author:** Ben Truong

**Version:** 1.0

---

## 1. Current Work Focus

The current development focus is on building the Minimal Viable Product (MVP) web application. This involves:

* Developing the frontend landing page with the photo upload and text input form.
* Setting up the backend API to handle file uploads and receive text input.
* Integrating with the chosen AI model API (LLM with vision capabilities) to process the uploaded data.
* Designing and implementing the assessment results display page.
* Implementing the logic to track and enforce the one-free-assessment limit per user (initially using a simple method like IP address or browser session storage).
* Designing the paywall page and integrating the basic Stripe checkout flow for subscriptions.

## 2. Recent Changes

* Decision to initially use a third-party AI model API rather than attempting to host or train a custom model from the start, accelerating MVP development.
* Refined the free tier tracking mechanism to start with a simple IP-based or session-based approach to avoid requiring user accounts for the initial free assessment.
* Prioritized implementing the Stripe checkout session creation and redirect for the paywall as the first step in payment integration.

## 3. Next Steps

* Complete the frontend development for the landing, assessment, and paywall pages.
* Finish the backend API endpoints for upload, AI processing requests, and receiving AI results.
* Fully integrate the chosen AI model API into the backend processing logic.
* Implement the free assessment counter and paywall redirect logic.
* Integrate Stripe checkout session creation and handle successful/canceled payments.
* Set up basic database models for assessments and potentially a simple way to link them to free users (e.g., using a unique session ID).

## 4. Active Decisions and Considerations

* **AI Model Selection:** Which specific LLM with vision capabilities to use? Factors include cost, accuracy, latency, and ease of integration. Need to finalize this choice and secure API access.
* **Free Tier Tracking:** The initial IP/session-based tracking is simple but not foolproof. Consider the trade-off between ease of implementation and potential abuse in the MVP. Future iterations will require user accounts.
* **Backend Framework:** Confirm the specific backend framework (e.g., Express, Flask) and database (e.g., PostgreSQL) for the MVP.
* **Error Handling:** Define how to handle errors during file uploads, AI processing, or Stripe transactions and communicate them effectively to the user.

## 5. Important Patterns and Preferences

* **API-First Approach:** Design the backend as a clear API that the frontend consumes.
* **Asynchronous Processing:** AI model calls can be slow. Implement asynchronous processing where possible to avoid blocking the main request thread.
* **Clear Separation of Concerns:** Keep frontend, backend, and AI logic separate.
* **Configuration over Hardcoding:** Use environment variables or configuration files for API keys, database credentials, and other settings.

## 6. Learnings and Project Insights

* Integrating external AI APIs requires careful handling of request/response formats and potential rate limits.
* Designing a smooth user flow around a free trial and paywall is critical for conversion.
* Starting with a minimal feature set allows for quicker iteration and validation of the core concept.

---